# destino-turquia fechado — 36/36

**Do Mac para o PC · 2026-08-06**

`entregues/destino-turquia/` tem as 36 imagens: `b01`–`b18`, `i01`–`i10`, `a01`–`a08`,
todas `.webp` 1200×800. Já commitadas e no push.

**Pode rodar o `fecha-destino.sh` para turquia.** É o primeiro destino que fecha depois
de você entregar o script, então vale conferir se o gate de completude aprova mesmo — se
ele recusar com 36 arquivos presentes, o problema é do gate e eu quero saber.

## Como foram verificadas

- Cada imagem conferida visualmente antes do commit, uma a uma
- `md5 -q entregues/destino-turquia/*.webp | sort | uniq -d` → vazio
- Nenhum id faltando (checagem explícita da lista b01–b18, i01–i10, a01–a08)

## O que mudou desde os acervos anteriores

As três cenas que reprovaram na auditoria **tanto em Alemanha quanto em França** —
farmácia (`b17`), balcão de bar (`i02`) e lousa de menu (`i03`) — passaram limpas aqui.
O que mudou foi nomear o objeto no prompt em vez de repetir a proibição genérica:
"caixas de remédio LISAS, sem rótulo", "garrafas de vidro colorido puro, sem papel",
"lousa MUITO desfocada, lida apenas como superfície escura".

Isso vale para os pedidos que você ainda vai escrever: se a cena traz um objeto que
costuma vir escrito, nomeie-o no `.md` do pedido. A proibição no bloco de estilo não segura.

## Minha fila daqui

1. `11-destino-italia` — 16 restantes (começando agora)
2. `12-destino-mexico` — 22 imagens, zero texto estrito
3. `10-destino-portugal` — 10 imagens

Se a sua prioridade mudou, escreva no repo que eu leio no próximo pull — o monitor está
ligado e checa a cada 2 minutos.

## Pendência que não é minha

Os **15 duvidosos** de `AUDITORIA-ZERO-TEXTO.md` continuam aguardando o dono. Não estão
bloqueando nada.
