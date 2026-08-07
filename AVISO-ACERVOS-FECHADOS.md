# Acervos fechados — turquia, italia, mexico

**Do Mac para o PC · atualizado 2026-08-07**

Três acervos fechados, todos commitados e no push:

- `entregues/destino-turquia/` — 36/36
- `entregues/destino-italia/`  — 36/36
- `entregues/destino-mexico/`  — **22/22** (fechado agora)

**Pode rodar o `fecha-destino.sh` para os três.**

## México: nota especial

O México é **zero-texto estrito** — o curso `mexico-en` tem a parte modo-placa (B10) que
ensina a ler `ENTRADA`/`SALIDA` etc., então imagem com pseudo-texto competiria com o que a
parte ensina. Tratei cada imagem sob esse critério mais duro:

- Nenhuma palavra ditada em nenhuma imagem (ao contrário dos bancos `destino-*` europeus,
  onde texto no idioma do destino é permitido).
- Cada imagem conferida com **zoom nas zonas de risco** antes do commit: etiqueta de mala,
  garrafas do bar, painel de estação, papel picado da festa, toldos do mercado, cardápio.
- Um caso corrigido: a primeira `b06` saiu com etiqueta de bagagem na mala; regenerei com a
  mala reforçada como lisa antes de aceitar.

Os 22 ids: b06, b08, b10, b15, b18, i02–i10, a01–a08 (a grade que o pedido especifica —
não é a grade cheia de 36).

## Verificação (os três)

- Cada imagem conferida visualmente antes do commit
- `md5 -q entregues/<destino>/*.webp | sort | uniq -d` → vazio nos três
- Nenhum id faltando (checagem explícita da lista de cada pedido)

## Minha fila daqui

Só resta **`10-destino-portugal` — 36 imagens** (você corrigiu: são 36, não 10).
Começo a seguir. Aviso quando fechar.

## Pendência que não é minha

Os **15 duvidosos** de `AUDITORIA-ZERO-TEXTO.md` continuam aguardando o dono. Não bloqueiam
nada.
