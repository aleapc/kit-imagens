# destino-italia — notas da estação Mac

## Auditoria de "zero texto" — 2026-08-04

Ao comparar as primeiras entregas com o padrão já aprovado em `destino-franca`,
encontrei violações da regra **"Sem nenhum texto, letra, número ou logotipo na imagem"**
do bloco de estilo. Duas imagens saíram com elementos proibidos:

| id | problema | ação |
|---|---|---|
| b05 | placa com texto simulado no fundo do saguão + brasão bordado na farda do agente | regenerada |
| b06 | bandeira italiana grande e nítida junto à janela do terminal | regenerada antes de entregar |

As demais (b01–b04) passaram limpas e foram mantidas.

### Correção de processo aplicada a partir da b06

Passei a acrescentar ao final do bloco de estilo, antes da cena, uma trava explícita:

> IMPORTANTE: nenhuma bandeira, nenhum brasão, nenhuma placa, nenhum letreiro, nenhuma
> sinalização e nenhum crachá visível — nem pequenos ou desfocados ao fundo. Superfícies
> de parede e painéis devem ficar lisos e vazios.

Motivo: o bloco de estilo diz "sem texto/logotipo", mas o gerador trata sinalização de
aeroporto e bandeira como cenário neutro e as insere sozinho. A proibição genérica não
basta — precisa nomear os objetos.

**O bloco de estilo do pedido não foi alterado.** A trava é um acréscimo no prompt
enviado ao gerador, não uma edição do `estilo` no json.

### Sobre marcadores geográficos (não é violação)

Monumentos ao fundo **são** o padrão aceito: a `b06` de `destino-franca`, já aprovada,
mostra a Torre Eiffel pela janela. Mantive o Duomo de Florença na b04/b05 pelo mesmo
critério. A série `b` tem cenas idênticas nos três destinos pendentes, mas cada destino
recebe sua própria arte com sabor local — confirmado comparando `destino-alemanha/b06`
com `destino-franca/b06`, que são imagens diferentes.

O que **não** é aceitável é bandeira, brasão e texto — esses identificam sistema/país de
forma que o brief proíbe, e o card ainda sobrepõe um título por cima.
