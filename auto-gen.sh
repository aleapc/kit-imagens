#!/bin/bash
# auto-gen.sh — Automatiza geração via xdotool + ChatGPT + clipboard

set -e

KIT_HOME="$HOME/kit-imagens"
PEDIDOS_DIR="$KIT_HOME/pedidos"
ENTREGUES_DIR="$KIT_HOME/entregues"
LOG_FILE="$KIT_HOME/.auto-gen.log"

CHATGPT_CHAT_ID="6a6d4215-5c78-83e9-9786-afa53ca1d4b8"
SLEEP_GEN=45  # segundos aguardando geração

log_msg() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Encontra window ID do ChatGPT
get_chatgpt_window() {
  # Tenta buscar pela URL ou título
  local wid=$(xdotool search --name "ChatGPT\|chatgpt.com" | head -1)
  if [ -z "$wid" ]; then
    # Fallback: busca janela do Chrome/Safari contendo ChatGPT
    wid=$(xdotool search --name "6a6d4215" | head -1)
  fi
  echo "$wid"
}

# Extrai estilo do JSON
get_style() {
  local json_file="$1"
  jq -r '.estilo' "$json_file"
}

# Extrai ambiente (para adaptar cena)
get_ambient() {
  local json_file="$1"
  jq -r '.ambiente' "$json_file"
}

# Encontra próxima imagem faltante
get_next_missing() {
  local json_file="$1"
  local curso=$(jq -r '.curso' "$json_file")

  # Lista em ordem: b, i, a
  jq -r '.arquivos[] | .id' "$json_file" | while read id; do
    local img_path="$ENTREGUES_DIR/$curso/${id}.webp"
    if [ ! -f "$img_path" ]; then
      echo "$id"
      return 0
    fi
  done
  return 1
}

# Extrai cena para um ID específico
get_scene() {
  local json_file="$1"
  local id="$2"
  jq -r ".arquivos[] | select(.id == \"$id\") | .cena" "$json_file"
}

# Monta prompt completo
mount_prompt() {
  local style="$1"
  local scene="$2"
  echo "${style} Cena: ${scene}"
}

# Envia prompt via xdotool
send_prompt() {
  local wid="$1"
  local prompt="$2"

  log_msg "Ativando janela ChatGPT (wid=$wid)..."
  xdotool windowactivate "$wid"
  sleep 2

  log_msg "Clicando no campo de input..."
  # Clica no campo text (aproximadamente no centro-inferior da janela)
  xdotool click 1
  sleep 1

  log_msg "Copiando prompt para clipboard..."
  echo -n "$prompt" | pbcopy

  log_msg "Colando prompt..."
  xdotool key ctrl+v
  sleep 1

  log_msg "Enviando (Return)..."
  xdotool key Return

  log_msg "Aguardando ${SLEEP_GEN}s para geração..."
  sleep "$SLEEP_GEN"
}

# Captura screenshot para debug
screenshot_debug() {
  local output="$KIT_HOME/.debug-$(date +%s).png"
  # macOS: screencapture
  # screencapture "$output"
  # Linux: import from ImageMagick
  # import "$output"
  log_msg "Debug screenshot: $output"
}

# Verifica se nova imagem apareceu (polling do DOM)
check_new_image() {
  local wid="$1"
  local prev_alt="$2"  # alt text da imagem anterior

  # Executa JS no navegador (Chrome DevTools Protocol seria melhor, mas complexo)
  # Para agora: simples wait + assume geração completou
  return 0
}

# Extrai imagem via clipboard (reusa lógica manual)
extract_image() {
  local wid="$1"
  local img_id="$2"
  local output="$3"

  log_msg "Executando JS de extração (img_id=$img_id)..."

  # Monta JS de extração
  read -r -d '' JS_EXTRACT << 'JSEOF' || true
if (!location.href.includes('6a6d4215-5c78-83e9-9786-afa53ca1d4b8')) throw new Error('WRONG CHAT');
const imgs = [...document.querySelectorAll('main img[alt^="Generated image"]')];
const img = imgs[imgs.length-1];
if (!img || img.naturalWidth === 0 || !img.complete) throw new Error('not loaded');
await img.decode();
const c = document.createElement('canvas');
c.width = 1200; c.height = 800;
c.getContext('2d').drawImage(img, 0, 0, 1200, 800);
const b64 = c.toDataURL('image/webp', 0.92).split(',')[1];
await navigator.clipboard.writeText('KITIMG:' + b64);
'copied, len=' + b64.length;
JSEOF

  # Execute via osascript (macOS) — para Linux usar xdotool script
  osascript -e "tell application \"Google Chrome\" to execute javascript \"$JS_EXTRACT\" in tab 1 of window 1" 2>/dev/null || {
    log_msg "JS execution failed, retrying..."
    sleep 5
    return 1
  }

  # Captura do clipboard
  log_msg "Capturando do clipboard..."
  sleep 2

  CLIP=$(pbpaste)
  if [[ "$CLIP" == KITIMG:* ]]; then
    log_msg "Clipboard válido, salvando $output..."
    echo "$CLIP" | sed 's/^KITIMG://' | base64 -d > "$output"
    log_msg "Arquivo salvo: $(ls -lh "$output")"
    return 0
  else
    log_msg "Clipboard inválido ou clobbered"
    return 1
  fi
}

# Commit + push
commit_image() {
  local curso="$1"
  local img_id="$2"

  log_msg "Commitando $img_id..."
  cd "$KIT_HOME"
  git add entregues/"$curso"/
  git -c user.name=aleapc -c user.email=aleapc@gmail.com commit -q -m "imagens $curso: +1 ($img_id)" || true
  git pull --rebase -q || true
  git push -q || true
  log_msg "Push completo"
}

# Main: processa um curso
process_course() {
  local course_json="$1"

  local curso=$(jq -r '.curso' "$course_json")
  log_msg "=============== Processando $curso ==============="

  local style=$(get_style "$course_json")

  # Encontra window do ChatGPT
  local wid=$(get_chatgpt_window)
  if [ -z "$wid" ]; then
    log_msg "ERRO: ChatGPT não encontrado, aborting"
    return 1
  fi
  log_msg "ChatGPT window ID: $wid"

  # Loop: processa cada imagem faltante
  local count=0
  local max_images=5  # Limita por rodada

  while [ $count -lt $max_images ]; do
    local img_id=$(get_next_missing "$course_json")
    if [ -z "$img_id" ]; then
      log_msg "$curso completo!"
      break
    fi

    log_msg "Processando: $img_id"
    local scene=$(get_scene "$course_json" "$img_id")
    local prompt=$(mount_prompt "$style" "$scene")

    # Envia e aguarda
    send_prompt "$wid" "$prompt"

    # Extrai e salva
    local output_path="$ENTREGUES_DIR/$curso/${img_id}.webp"
    if extract_image "$wid" "$img_id" "$output_path"; then
      commit_image "$curso" "$img_id"
      log_msg "✓ $img_id completo"
      ((count++))
    else
      log_msg "✗ $img_id falhou, aguardando retry..."
      sleep 10
    fi
  done

  log_msg "Rodada concluída ($count/$max_images)"
}

# Main
if [ $# -eq 0 ]; then
  log_msg "Uso: $0 <curso_json>"
  log_msg "Exemplo: $0 ~/kit-imagens/pedidos/4-destino-grecia.json"
  exit 1
fi

process_course "$1"
