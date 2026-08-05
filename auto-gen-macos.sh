#!/bin/bash
# auto-gen-macos.sh — Automatiza geração via AppleScript + ChatGPT + clipboard (macOS)

set -e

KIT_HOME="$HOME/kit-imagens"
PEDIDOS_DIR="$KIT_HOME/pedidos"
ENTREGUES_DIR="$KIT_HOME/entregues"
LOG_FILE="$KIT_HOME/.auto-gen.log"

CHATGPT_URL="https://chatgpt.com/c/6a6d4215-5c78-83e9-9786-afa53ca1d4b8"
SLEEP_GEN=45  # segundos aguardando geração

log_msg() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Ativa e focusa Chrome com ChatGPT
activate_chatgpt() {
  log_msg "Ativando Chrome..."
  osascript << 'APPLESCRIPT'
tell application "Google Chrome"
  activate
end tell
APPLESCRIPT
  sleep 1
}

# Extrai estilo do JSON
get_style() {
  local json_file="$1"
  jq -r '.estilo' "$json_file"
}

# Encontra próxima imagem faltante
get_next_missing() {
  local json_file="$1"
  local curso=$(jq -r '.curso' "$json_file")

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

# Envia prompt via clipboard + JS
send_prompt() {
  local prompt="$1"

  activate_chatgpt

  log_msg "Copiando prompt para clipboard..."
  echo -n "$prompt" | pbcopy

  log_msg "Colando prompt no ChatGPT..."
  osascript << 'APPLESCRIPT'
tell application "Google Chrome"
  activate
end tell

delay 0.5

tell application "System Events"
  keystroke "v" using command down
end tell

delay 1

tell application "System Events"
  key code 36  -- Return
end tell
APPLESCRIPT

  log_msg "Aguardando ${SLEEP_GEN}s para geração..."
  sleep "$SLEEP_GEN"
}

# Extrai imagem via JS + clipboard
extract_image() {
  local img_id="$2"
  local output="$3"

  log_msg "Executando JS de extração..."

  # JS de extração (mesma lógica que antes)
  osascript << 'APPLESCRIPT'
tell application "Google Chrome"
  execute javascript "
  if (!location.href.includes('6a6d4215-5c78-83e9-9786-afa53ca1d4b8')) throw new Error('WRONG CHAT');
  const imgs = [...document.querySelectorAll('main img[alt^=\"Generated image\"]')];
  const img = imgs[imgs.length-1];
  if (!img || img.naturalWidth === 0 || !img.complete) throw new Error('not loaded');
  await img.decode();
  const c = document.createElement('canvas');
  c.width = 1200; c.height = 800;
  c.getContext('2d').drawImage(img, 0, 0, 1200, 800);
  const b64 = c.toDataURL('image/webp', 0.92).split(',')[1];
  await navigator.clipboard.writeText('KITIMG:' + b64);
  'copied, len=' + b64.length;
  " in tab 1 of window 1
end tell
APPLESCRIPT

  sleep 2

  # Captura do clipboard
  log_msg "Capturando do clipboard..."
  CLIP=$(pbpaste)
  if [[ "$CLIP" == KITIMG:* ]]; then
    log_msg "Clipboard válido, salvando $output..."
    echo "$CLIP" | sed 's/^KITIMG://' | base64 -d > "$output"
    log_msg "✓ Arquivo salvo: $(ls -lh "$output" | awk '{print $5, $9}')"
    return 0
  else
    log_msg "✗ Clipboard inválido ou clobbered"
    return 1
  fi
}

# Commit + push
commit_image() {
  local curso="$1"
  local img_id="$2"

  log_msg "Commitando $img_id..."
  cd "$KIT_HOME"
  git add entregues/"$curso"/ 2>/dev/null || true
  git -c user.name=aleapc -c user.email=aleapc@gmail.com commit -q -m "imagens $curso: +1 ($img_id)" 2>/dev/null || true
  git pull --rebase -q 2>/dev/null || true
  git push -q 2>/dev/null || true
  log_msg "✓ Git completo"
}

# Main: processa um curso
process_course() {
  local course_json="$1"

  local curso=$(jq -r '.curso' "$course_json")
  log_msg "=============== Processando $curso ==============="

  local style=$(get_style "$course_json")

  # Loop: processa cada imagem faltante
  local count=0
  local max_images=5  # Limita por rodada

  while [ $count -lt $max_images ]; do
    local img_id=$(get_next_missing "$course_json")
    if [ -z "$img_id" ]; then
      log_msg "✓ $curso COMPLETO!"
      break
    fi

    log_msg "→ Processando: $img_id"
    local scene=$(get_scene "$course_json" "$img_id")
    local prompt=$(mount_prompt "$style" "$scene")

    # Envia e aguarda
    send_prompt "$prompt"

    # Extrai e salva
    local output_path="$ENTREGUES_DIR/$curso/${img_id}.webp"
    if extract_image "$curso" "$img_id" "$output_path"; then
      commit_image "$curso" "$img_id"
      log_msg "✓ $img_id completo"
      ((count++))
    else
      log_msg "✗ $img_id falhou, aguardando retry..."
      sleep 5
    fi
  done

  log_msg "✓ Rodada concluída ($count/$max_images)"
}

# Main
if [ $# -eq 0 ]; then
  log_msg "Uso: $0 <curso_json>"
  log_msg "Exemplo: $0 ~/kit-imagens/pedidos/4-destino-grecia.json"
  exit 1
fi

process_course "$1"
