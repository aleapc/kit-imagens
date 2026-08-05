#!/bin/bash
# start-listener.sh — Inicia daemon listener + coordena auto-gen

KIT_HOME="$HOME/kit-imagens"
PID_FILE="$KIT_HOME/.listener.pid"
LOG_FILE="$KIT_HOME/.listener.log"

# Para listener anterior se existir
if [ -f "$PID_FILE" ]; then
  old_pid=$(cat "$PID_FILE")
  if kill -0 "$old_pid" 2>/dev/null; then
    echo "Parando listener anterior (PID $old_pid)..."
    kill "$old_pid" || true
    sleep 2
  fi
  rm -f "$PID_FILE"
fi

# Cria wrapper que chama auto-gen para cursos que precisam
monitor_and_autogen() {
  while true; do
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Poll..." >> "$LOG_FILE"

    # Verifica cada curso
    for json in "$KIT_HOME/pedidos"/*.json; do
      if [ ! -f "$json" ]; then continue; fi

      curso=$(jq -r '.curso' "$json" 2>/dev/null)
      if [ -z "$curso" ]; then continue; fi

      # Conta imagens faltantes
      total=$(jq '.arquivos | length' "$json")
      existing=$(find "$KIT_HOME/entregues/$curso/" -name "*.webp" 2>/dev/null | wc -l)
      missing=$((total - existing))

      if [ "$missing" -gt 0 ]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] Fila: $curso ($missing/$total)" >> "$LOG_FILE"

        # Dispara auto-gen em background se não estiver rodando
        if ! pgrep -f "auto-gen.sh.*$curso" > /dev/null; then
          echo "[$(date '+%Y-%m-%d %H:%M:%S')] Iniciando auto-gen para $curso..." >> "$LOG_FILE"
          "$KIT_HOME/auto-gen-full.sh" "$json" >> "$LOG_FILE" 2>&1 &
        fi
      fi
    done

    sleep 60  # Poll a cada 60 segundos
  done
}

# Inicia daemon
echo "Iniciando listener daemon..."
monitor_and_autogen > /dev/null 2>&1 &
listener_pid=$!
echo "$listener_pid" > "$PID_FILE"

echo "✓ Listener rodando (PID $listener_pid)"
echo "✓ Log: $LOG_FILE"
echo ""
echo "Para parar: kill $listener_pid"
echo "Ou: pkill -f 'monitor_and_autogen'"
echo ""
echo "Monitorando $KIT_HOME/pedidos/ a cada 60s..."
tail -f "$LOG_FILE"
