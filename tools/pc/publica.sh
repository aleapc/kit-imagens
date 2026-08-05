#!/usr/bin/env bash
# Publica um curso no GitHub Pages, do jeito que os quatro da Espanha já estão:
# repo aleapc/<curso>, Pages servido da raiz da branch `gh-pages`.
#
# Por que uma branch órfã e não um subdiretório: o build tem ~1.400 mp3, e mantê-lo
# na `main` dobraria o repositório a cada deploy. A `gh-pages` é artefato — é
# reescrita inteira a cada publicação e não guarda histórico útil.
#
# O build usa caminhos RELATIVOS (paths.relative na svelte.config), então o mesmo
# artefato serve em qualquer subcaminho e não precisa de BASE_PATH.
set -euo pipefail

RAIZ="C:/Users/aapc_/Documents/Codex/kit-de-bordo-worktrees"
CURSO="$1"
DIR="$RAIZ/$CURSO"

[ -d "$DIR/build" ] || { echo "$CURSO: sem build/"; exit 1; }
[ -f "$DIR/build/.nojekyll" ] || touch "$DIR/build/.nojekyll"

# O PORTÃO DE PUBLICAÇÃO RODA AQUI, e não é cerimônia: é ele que impede publicar
# um curso servindo arte de outro país. Ver scripts/valida-arte.mjs.
( cd "$DIR" && npm run publicar >/dev/null 2>&1 ) || {
  echo "$CURSO: REPROVOU em 'npm run publicar' — não publicado"; exit 2; }

TMP=$(mktemp -d)
cp -r "$DIR/build/." "$TMP/"
cd "$TMP"
git init -q
git checkout -q -b gh-pages
git add -A
git -c user.name=aleapc -c user.email=aleapc@gmail.com \
    commit -q -m "publica $CURSO — $(cd "$DIR" && git log --oneline -1 | cut -c1-7)"
git push -q --force "https://github.com/aleapc/$CURSO.git" gh-pages:gh-pages
cd /; rm -rf "$TMP"

gh api -X POST "repos/aleapc/$CURSO/pages" \
  -f 'source[branch]=gh-pages' -f 'source[path]=/' >/dev/null 2>&1 \
  || gh api -X PUT "repos/aleapc/$CURSO/pages" \
       -f 'source[branch]=gh-pages' -f 'source[path]=/' >/dev/null 2>&1 || true

echo "$CURSO: publicado → https://aleapc.github.io/$CURSO/"
