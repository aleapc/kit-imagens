#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# FECHA UM DESTINO: da entrega de arte do Mac até o site no ar.
#
#   bash fecha-destino.sh turquia          # todos os SKUs desse destino
#   bash fecha-destino.sh turquia --seco   # mostra o que faria, sem publicar
#
# Existe porque a sequência é sempre a mesma e eu vinha fazendo à mão: sincroniza
# da ponte, confere o portão de arte, reconstrói, roda `publicar`, empurra a
# gh-pages e CONFERE O SITE. O último passo é o que mais importa — hoje mesmo
# publiquei quatro cursos, fui olhar, e a aba do navegador dizia o nome do país
# errado. Declarar publicado sem abrir a página é como declarar build verde sem
# rodar o portão.
#
# Arte é ativo de DESTINO: um destino fecha os seus SKUs de uma vez, porque
# EN→Türkiye e DE→Türkiye mostram a mesma Türkiye.
# ─────────────────────────────────────────────────────────────────────────────
set -uo pipefail

RAIZ="C:/Users/aapc_/Documents/Codex/kit-de-bordo-worktrees"
PONTE="E:/dev-d/kit-imagens"
DESTINO="${1:-}"
SECO=""
[ "${2:-}" = "--seco" ] && SECO=1

[ -n "$DESTINO" ] || { echo "uso: bash fecha-destino.sh <destino> [--seco]"; exit 1; }

SKUS=$(cd "$RAIZ" && ls -d curso-"$DESTINO"* 2>/dev/null)
[ -n "$SKUS" ] || { echo "nenhum curso de destino \"$DESTINO\""; exit 1; }

echo "=== fecha-destino · $DESTINO · SKUs: $(echo $SKUS | tr '\n' ' ')"

# ── 1. a ponte ainda está produzindo? ───────────────────────────────────────
( cd "$PONTE" && git pull -q 2>/dev/null )
ENTREGUE=$(ls "$PONTE/entregues/destino-$DESTINO/"*.webp 2>/dev/null | wc -l)
PEDIDO=$(ls "$PONTE"/pedidos/*-destino-"$DESTINO".json 2>/dev/null | head -1)
ESPERADO=36
[ -n "$PEDIDO" ] && ESPERADO=$(node -e "console.log(require('$PEDIDO').ids.length)" 2>/dev/null || echo 36)
echo "    arte na ponte: $ENTREGUE de $ESPERADO"
if [ "$ENTREGUE" -lt "$ESPERADO" ]; then
  echo "    ⏸ o Mac ainda está produzindo — nada a fechar. Saindo sem tocar em nada."
  exit 0
fi

# ── 2. instala nos SKUs do destino ──────────────────────────────────────────
for c in $SKUS; do
  cp "$PONTE/entregues/destino-$DESTINO/"*.webp "$RAIZ/$c/static/img/" 2>/dev/null
  printf "    %-20s arte instalada\n" "$c"
done

# ── 3. o portão decide, não eu ──────────────────────────────────────────────
FALHOU=0
for c in $SKUS; do
  if ( cd "$RAIZ/$c" && node scripts/valida-arte.mjs --estrito >/dev/null 2>&1 ); then
    printf "    %-20s arte ✓\n" "$c"
  else
    printf "    %-20s arte ✗ — ver `npm run arte`\n" "$c"; FALHOU=1
  fi
done
[ "$FALHOU" = 0 ] || { echo "    parando: arte reprovada"; exit 2; }

[ -n "$SECO" ] && { echo "    (--seco: pararia aqui, sem construir nem publicar)"; exit 0; }

# ── 4. construir, publicar, e CONFERIR ──────────────────────────────────────
for c in $SKUS; do
  echo "--- $c"
  ( cd "$RAIZ/$c" && { [ -x node_modules/.bin/vite ] || npm install >/dev/null 2>&1; } \
      && npm run build >/dev/null 2>&1 ) \
    || { echo "    build FALHOU"; continue; }
  ( cd "$RAIZ/$c" && git add -A >/dev/null 2>&1 \
      && git commit -q -m "arte do destino $DESTINO instalada — $ESPERADO imagens próprias" >/dev/null 2>&1
    git push -q origin HEAD:refs/heads/main >/dev/null 2>&1 )
  bash "$RAIZ/_ferramentas/publica.sh" "$c" 2>/dev/null | grep -E "publicado|REPROVOU" \
    || { echo "    publicação FALHOU"; continue; }

  # A CONFERÊNCIA, e ela não é opcional. Cache de CDN pode devolver a versão
  # velha por um tempo, então o ?cb= é obrigatório.
  T=$(curl -s -H 'Cache-Control: no-cache' "https://aleapc.github.io/$c/?cb=$RANDOM$$" \
        | grep -oE "<title>[^<]*</title>" | head -1)
  echo "    no ar: $T"
done

echo "=== $DESTINO fechado. Atualize o Mapa: cobertura e os cards dos SKUs."
