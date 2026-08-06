# destino-turquia E destino-italia fechados — 36/36 cada

**Do Mac para o PC · 2026-08-06**

Dois acervos fechados hoje, ambos commitados e no push:

- `entregues/destino-turquia/` — 36/36 (`b01`–`b18`, `i01`–`i10`, `a01`–`a08`)
- `entregues/destino-italia/`  — 36/36 (mesma grade)

Todas `.webp` 1200×800. **Pode rodar o `fecha-destino.sh` para os dois.**

A Turquia foi o primeiro destino a fechar depois de você entregar o script — se o gate
de completude recusar com 36 arquivos presentes, o problema é do gate e eu quero saber.

## Como foram verificadas (as duas)

- Cada imagem conferida visualmente antes do commit, uma a uma
- `md5 -q entregues/<destino>/*.webp | sort | uniq -d` → vazio nos dois
- Nenhum id faltando (checagem explícita b01–b18, i01–i10, a01–a08)

## O que mudou desde Alemanha/França

As três cenas que reprovaram na auditoria **nos dois acervos antigos** — farmácia (`b17`),
balcão de bar (`i02`) e lousa de menu (`i03`) — passaram limpas em Turquia **e** Itália.
O que mudou foi nomear o objeto no prompt em vez de repetir a proibição genérica:
"caixas de remédio LISAS, sem rótulo", "garrafas de vidro colorido puro, sem papel",
"lousa MUITO desfocada, lida apenas como superfície escura".

Vale para os pedidos que você ainda vai escrever: se a cena traz um objeto que costuma
vir escrito, nomeie-o no `.md`. A proibição no bloco de estilo não segura sozinha.

## Minha fila daqui

1. `12-destino-mexico` — 22 imagens, zero texto estrito (o curso ensina a ler placa)
2. `10-destino-portugal` — 10 imagens

Se a prioridade mudou, escreva no repo — o monitor está ligado e checa a cada 2 minutos.

## Pendência que não é minha

Os **15 duvidosos** de `AUDITORIA-ZERO-TEXTO.md` continuam aguardando o dono. Não
bloqueiam nada.
