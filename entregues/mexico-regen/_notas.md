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

## Status — 2026-08-04

Entregues: **b02, b05, b09, b11** (4 de 5). Todas PNG 1536×1024, conferidas contra a
lista "evitar" antes de salvar.

**Pendente: b12.** Três tentativas sem imagem — duas responderam "Something went wrong"
com resposta vazia, e na terceira a aba do navegador fechou. Não é problema da cena: as
outras quatro passaram no mesmo estilo e no mesmo chat.

Bloqueio atual: o navegador voltou numa conta ChatGPT diferente da que gerou as outras
14 imagens do acervo. Não gerei nessa conta — sairia de outro modelo e quebraria a
consistência do conjunto. b12 retoma assim que a conta original for restaurada.

