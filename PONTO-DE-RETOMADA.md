# Ponto de retomada — 2026-08-05, fim do dia

Pausa combinada com o dono. Este arquivo diz exatamente onde parar e como recomeçar.
Leia junto com `METODO-OPERACAO.md` (o como) e `CRITERIO-TEXTO.md` (o critério).

## Estado do acervo

| curso | estado |
|---|---|
| destino-alemanha | 36/36 ✅ (PARADO — não há curso; o PC pediu para não gerar mais) |
| destino-franca | 36/36 ✅ |
| destino-grecia | 36/36 ✅ |
| mexico-regen | 5/5 ✅ |
| destino-italia | 20/36 |
| **destino-turquia** | **29/36 ← retomar aqui** |

## O que falta na Turquia: 7 imagens

`a02, a03, a04, a05, a06, a07, a08` — cenas em `pedidos/3-destino-turquia.md`
(as cenas ficam no `.md`, não no `.json`; o json só traz destino/pasta/ambiente/língua/ids).

Blocos B (b01–b18) e I (i01–i10) fechados hoje, todos conferidos visualmente antes do commit.

## Por que fechar a Turquia inteira importa

O PC entregou hoje `fecha-destino.sh`, que **sai sem tocar em nada se faltar uma imagem** —
meio destino instalado mistura dois países no mesmo curso. Com 29/36 nada é instalável;
com 36/36 ele instala em todos os SKUs do destino de uma vez.

## Fila depois da Turquia (prioridade do PC)

1. `11-destino-italia` — 16 restantes
2. `12-destino-mexico` — 22 imagens, **zero texto estrito** (o curso tem parte de ler placa)
3. `10-destino-portugal` — 10 imagens

## Pendência de decisão do dono

Os **15 duvidosos** da auditoria (`AUDITORIA-ZERO-TEXTO.md`) continuam sem ação — o dono
disse "depois eu olho as 15". As 13 violações confirmadas já foram regeneradas.

## O que aprendi hoje e vale reaplicar

As três cenas que reprovaram em Alemanha **e** França — farmácia (b17), balcão de bar (i02)
e lousa de menu (i03) — passaram limpas na Turquia. O que mudou não foi o gerador: foi
nomear o objeto no prompt em vez de repetir a proibição genérica. "caixas de remédio LISAS,
sem rótulo", "garrafas de vidro colorido puro, sem papel", "lousa MUITO desfocada, lida
apenas como superfície escura". Confirmar sempre com `zoom` na região de risco antes de
aceitar — foi assim que validei o painel de horários da b10.

## Estado da infraestrutura

- `monitor-ponte.sh` roda em background (pid 71043), pull a cada 2 min, grava em
  `.ponte-monitor.log`. Só observa: não gera, não commita, não abre navegador.
- Chat do ChatGPT em uso: `6a73aedf-ba10-83e9-9c1d-181bd53acb01`, ~30 imagens.
  **Abrir chat novo ao retomar** — passar disso trava o renderer.
- Última novidade do PC: commit `352628b` (fecha-destino.sh e publica.sh). Nada pendente
  de resposta minha.
