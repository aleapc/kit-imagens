#!/bin/bash
# monitor-ponte.sh — vigia o repositório e registra o que o PC commitar.
#
# O QUE ELE FAZ: git pull a cada 2 min, detecta commits que não são meus,
# escreve em .ponte-monitor.log.
#
# O QUE ELE NÃO FAZ, DE PROPÓSITO: não gera imagem, não abre navegador, não
# clica em nada, não commita. Um listener que operava o gerador sozinho rodou
# horas em 2026-08-05 colando prompt na janela errada e não produziu nada
# aproveitável. Geração exige conferência visual; cópia de bytes não.

KIT="$HOME/kit-imagens"
LOG="$KIT/.ponte-monitor.log"
INTERVALO=120

cd "$KIT" || exit 1
ultimo=$(git rev-parse HEAD)

echo "[$(date '+%H:%M:%S')] monitor iniciado — vigiando $(git rev-parse --short HEAD)" >> "$LOG"

while true; do
  git pull -q --rebase 2>/dev/null
  atual=$(git rev-parse HEAD)

  if [ "$atual" != "$ultimo" ]; then
    # Filtra os meus próprios commits. Casar só por "imagens destino-" deixa passar
    # os de fechamento de acervo ("destino-X COMPLETO") como se fossem do PC — foi o
    # que aconteceu em 2026-08-06 com a Turquia. Casar pelo nome do destino cobre os dois.
    novos=$(git log --oneline "$ultimo..$atual" 2>/dev/null | grep -viE "destino-|mexico-|^[a-f0-9]+ MAC:|monitor da ponte|ponte: ping do Mac" || true)
    if [ -n "$novos" ]; then
      echo "[$(date '+%H:%M:%S')] >>> NOVIDADE DO PC:" >> "$LOG"
      echo "$novos" | sed 's/^/    /' >> "$LOG"
      pend=$(ls "$KIT"/pedidos/*.json 2>/dev/null | wc -l | tr -d ' ')
      echo "    (pedidos no repo agora: $pend)" >> "$LOG"
    fi
    ultimo="$atual"
  fi
  sleep "$INTERVALO"
done
