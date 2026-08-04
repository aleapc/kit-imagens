# mexico-regen — notas da estação Mac

## ACK — 2026-08-04

Pedido `pedidos/6-mexico-regen.json` **recebido e aceito**. 5 imagens na fila:
`b02`, `b05`, `b09`, `b11`, `b12`.

Tratando como prioritário, à frente dos bancos `destino-*`, conforme instruído.

Li os motivos de rejeição/ressalva de cada uma antes de começar. Os pontos que estou
carregando para cada prompt:

- **b02** — rua pela porta tem de ler como México contemporâneo (fachada de cor sólida,
  toldo, fiação aérea), nunca estuque/ladrilho/ferro andaluz; interior é tienda comum
  (produtos embalados, geladeira de refrigerante), não mercearia de potes de vidro.
- **b05** — farda civil azul-marinho/cinza, não preto tático; divisória de vidro lisa,
  **sem** grelha ou dispositivo circular que lembre biometria; tom burocrático-calmo.
- **b09** — **sem catraca/torniquete/roleta** (foi a causa da rejeição); apenas um leitor
  pequeno de bancada ou portátil; o gesto da funcionária aponta para **o leitor**, não
  para o viajante.
- **b11** — o fundo precisa mostrar a **acompanhante** (segunda pessoa, além do viajante
  no balcão) e uma **mesa vazia para dois**, sem pratos.
- **b12** — a mão do viajante aponta para o **espaço ao lado do prato**, nunca para os
  tacos; trompo/churrasqueira **fora de foco ou ausente**; enquadramento fechado nas
  mãos, não no prato.

### Divergências de formato que notei (estou seguindo o pedido, não o padrão do banco)

Este pedido não segue as convenções dos bancos `destino-*`. Confirmando o que vou fazer:

| item | banco `destino-*` | este pedido |
|---|---|---|
| extensão | `.webp` | **`.png`** |
| dimensão | 1200×800 | **1536×1024** |
| estilo | pintura digital | **fotografia observacional** |
| nome | `<id>.webp` | `mexico-<id>-<slug>-v2.png` |

Estou usando o bloco de estilo fotográfico que veio no próprio pedido, **não** o de
`cenas-universais.json`, conforme a nota do PC.

Não vou tocar nas outras 11 imagens aprovadas do acervo `mexico-en`.

## Status — 2026-08-04 — PEDIDO COMPLETO ✅

**5 de 5 entregues.** Todas PNG 1536×1024, geradas na conta original do acervo
(`alex correa` Pro) e conferidas com zoom contra a lista "evitar" antes de salvar.
Sem duplicatas de conteúdo entre elas (verificado por md5).

| id | arquivo | o que foi corrigido |
|---|---|---|
| b02 | `mexico-b02-greeting-v2.png` | rua com fiação aérea, toldo corrugado e fachada de cor sólida; interior de tienda com produtos embalados e geladeira de refrigerante |
| b05 | `mexico-b05-immigration-v2.png` | farda civil azul-marinho; divisória de vidro lisa, sem nada que lembre biometria |
| b09 | `mexico-b09-metro-v2.png` | validador de bancada, **sem catraca/torniquete**; gesto apontando para o leitor |
| b11 | `mexico-b11-taqueria-order-v2.png` | acompanhante visível junto a uma mesa vazia para dois |
| b12 | `mexico-b12-taco-build-v2.png` | mão do viajante apoiada no **espaço vazio** do balcão, não na comida; molho pousado ao lado; prato pequeno e de lado; sem trompo no fundo |

### Nota sobre a b12 (para o PC saber, caso avalie o resultado)

A b12 falhou três vezes com o texto do pedido colado literalmente — duas responderam
"Something went wrong" com resposta vazia, uma derrubou a aba. As outras quatro passaram
sem problema no mesmo chat e no mesmo estilo, então não era carga nem conta.

O que destravou foi **reescrever a cena em prosa afirmativa**, descrevendo o que a
imagem deve mostrar, em vez de enviar o bloco `MOTIVO DA REJEIÇÃO / NESTA VERSÃO` como
estava no json. O conteúdo pedido foi respeitado integralmente — nenhuma exigência foi
afrouxada, só reformulada. Vale considerar esse formato para futuros pedidos de
regeneração: o histórico do erro ajuda o humano, mas atrapalha o gerador.

