#!/bin/bash
# listener.sh — Daemon que monitora pedidos/ e gera imagens automaticamente via ChatGPT

set -e

KIT_HOME="$HOME/kit-imagens"
PEDIDOS_DIR="$KIT_HOME/pedidos"
ENTREGUES_DIR="$KIT_HOME/entregues"
LOG_FILE="$KIT_HOME/.listener.log"
STATE_FILE="$KIT_HOME/.listener-state.json"
POLL_INTERVAL=30  # segundos

# Inicializa JSON de estado
init_state() {
  if [ ! -f "$STATE_FILE" ]; then
    echo '{"courses":{},"last_check":""}' > "$STATE_FILE"
  fi
}

# Detecta JSONs em pedidos/
get_courses() {
  find "$PEDIDOS_DIR" -maxdepth 1 -name "*.json" -type f | sort
}

# Lista imagens faltantes para um curso
get_missing_images() {
  local course_json="$1"
  local curso=$(jq -r '.curso' "$course_json")
  local entrega_dir=$(jq -r '.entregar_em' "$course_json")

  # Conta quantas imagens já existem
  local total=$(jq '.arquivos | length' "$course_json")
  local existing=$(find "$ENTREGUES_DIR/$curso/" -name "*.webp" 2>/dev/null | wc -l)

  if [ "$existing" -lt "$total" ]; then
    echo "$(($total - $existing))"
  else
    echo "0"
  fi
}

# Log com timestamp
log_msg() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# Notifica (pode integrar com osascript para macOS notification)
notify() {
  log_msg "$1"
  # Opcional: osascript -e "display notification \"$1\" with title \"kit-imagens\""
}

# Loop principal
main_loop() {
  log_msg "Listener iniciado"
  init_state

  while true; do
    log_msg "Poll iniciado"

    # Detecta cursos
    while IFS= read -r course_json; do
      if [ -z "$course_json" ]; then continue; fi

      curso=$(jq -r '.curso' "$course_json" 2>/dev/null)
      if [ -z "$curso" ]; then continue; fi

      missing=$(get_missing_images "$course_json")

      if [ "$missing" -gt 0 ]; then
        notify "FALTA: $curso — $missing imagens pendentes"
        log_msg "Fila: $curso ($missing imagens)"

        # Opcional: auto-gera via xdotool (fragile, desabilitado por padrão)
        # attempt_auto_generate "$course_json"
      fi
    done < <(get_courses)

    log_msg "Poll finalizado"
    sleep "$POLL_INTERVAL"
  done
}

# Função experimental: tenta automatizar via xdotool
attempt_auto_generate() {
  local course_json="$1"
  local curso=$(jq -r '.curso' "$course_json")

  # Verifica se xdotool está disponível
  if ! command -v xdotool &> /dev/null; then
    log_msg "xdotool não disponível, pulando auto-gen para $curso"
    return
  fi

  log_msg "Tentando auto-gen para $curso..."

  # Encontra a janela do ChatGPT
  local window_id=$(xdotool search --name "ChatGPT" | head -1)
  if [ -z "$window_id" ]; then
    log_msg "Janela ChatGPT não encontrada"
    return
  fi

  # Ativa janela
  xdotool windowactivate "$window_id"
  sleep 2

  # Lê primeira imagem faltante do JSON
  local first_missing=$(jq -r '.arquivos[] | select(.arquivo | test("[ab]0[1-9]")) | .id' "$course_json" | head -1)
  if [ -z "$first_missing" ]; then
    log_msg "Nenhuma imagem faltante identificada para $curso"
    return
  fi

  # Extrai prompt (simplificado — real precisa montar completo com estilo + cena)
  local prompt=$(jq -r '.arquivos[] | select(.id == "'$first_missing'") | .cena' "$course_json")
  log_msg "Prompt para $first_missing: ${prompt:0:50}..."

  # Clica no campo de input
  xdotool windowactivate "$window_id" click 1 --clearmodifiers
  sleep 1

  # Digita prompt (LENTO — melhor é usar clipboard)
  # xdotool type --delay 10 "$prompt"

  # Método clipboard (mais rápido)
  echo "$prompt" | pbcopy
  xdotool key ctrl+v
  sleep 1

  # Pressiona Enter
  xdotool key Return

  log_msg "Prompt enviado para $first_missing, aguardando geração..."
}

# Trap para limpar ao parar
cleanup() {
  log_msg "Listener parado"
  exit 0
}
trap cleanup SIGINT SIGTERM

main_loop
