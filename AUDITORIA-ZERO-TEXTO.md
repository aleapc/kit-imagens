# Auditoria "zero texto" — destino-alemanha e destino-franca

**Data:** 2026-08-04 · **Executada por:** estação Mac · **Escopo:** 72 imagens já entregues

## Por que esta auditoria existe

Ao entregar as primeiras imagens de `destino-italia`, duas saíram com elementos que o
bloco de estilo proíbe ("Sem nenhum texto, letra, número ou logotipo na imagem"): uma
placa com texto simulado e uma bandeira italiana. Isso levantou a suspeita de que os
acervos entregues **antes** de eu passar a usar uma trava anti-sinalização no prompt
tivessem o mesmo defeito.

Tinham.

## Resultado

| curso | OK | violações | duvidosos |
|---|---|---|---|
| destino-alemanha | 22 | **6** | 8 |
| destino-franca | 20 | **9** | 7 |
| **total** | 42 | **15** | 15 |

**42 de 72 imagens (58%) estão limpas.** 15 têm violação confirmada e 15 têm elementos
ambíguos que merecem um segundo olhar humano.

## Violações confirmadas

### destino-alemanha

| id | o que há na imagem |
|---|---|
| b04 | bilhetes com texto impresso e blocos tipográficos, centro inferior |
| b10 | painel de partidas com dezenas de linhas de caracteres alaranjados, topo central |
| b17 | rótulos em caixas de medicamento no balcão + cruz verde de farmácia (logotipo) |
| i02 | placa amarela com marcas de texto na parede do bar |
| i03 | cardápio/lousa com linhas de texto + emblema circular na parede |
| i10 | conta/recibo com linhas impressas e valores, dentro da pasta de couro |

### destino-franca

| id | o que há na imagem |
|---|---|
| a01 | letras em toldo/letreiro vermelho + monograma dourado no vidro |
| b02 | formas de letras em placas de madeira na prateleira da padaria |
| b06 | crachá com linhas de texto pendurado no cordão da funcionária |
| b14 | teclado da maquininha com dígitos visíveis nas teclas |
| b17 | cruz verde de farmácia em neon (logotipo) |
| i02 | cartazes emoldurados com marcas de texto + rótulos em garrafas |
| i03 | lousa de cardápio com escrita à mão |
| i05 | rótulos com texto em garrafas, prateleira e primeiro plano |
| i07 | rótulos escritos em garrafas de vinho + cartaz atrás da anfitriã |

## Duvidosos (precisam de decisão humana)

Elementos onde não dá para afirmar se é texto ou só textura, na resolução entregue:

- **alemanha:** a02 (caixa de talheres), b03 (comanda), b07 (bandeiras + painel), b13
  (conta manuscrita), b14 (teclado), i04 (cartazes na fachada), i06 (quadros), i07 (maquininha)
- **franca:** a04 (papéis na porta), a05 (rótulos), b07 (painel + táxis), b13 (nota do
  garçom), b15 (etiqueta na gola), i04 (toldo), i10 (placas na parede + rótulos)

## Padrão recorrente

Os mesmos objetos reaparecem em ambos os acervos: **rótulo de garrafa, cardápio/lousa,
conta/recibo, painel de aeroporto, crachá, teclado numérico, cruz de farmácia.** O
gerador trata todos como cenário neutro e os insere sem serem pedidos. A proibição
genérica do bloco de estilo não segura — é preciso nomear os objetos.

Note que `b17` (farmácia) e `i02`/`i03` (bar/cardápio) falharam **nos dois países**, com
o mesmo tipo de elemento. São cenas que atraem o defeito por natureza.

## Trava aplicada a partir de agora

Acrescentada ao prompt (não ao `estilo` do json, que não foi alterado):

> IMPORTANTE: nenhuma bandeira, nenhum brasão, nenhuma placa, nenhum letreiro, nenhuma
> sinalização e nenhum crachá visível — nem pequenos ou desfocados ao fundo. Superfícies
> de parede e painéis devem ficar lisos e vazios.

Para cenas de bar, farmácia, restaurante e transporte convém estender: "garrafas sem
rótulo, sem cardápio nem lousa, sem conta impressa, sem painel de horários, sem teclado
numérico com dígitos."

## O que NÃO é violação (confirmado)

Monumentos e marcos geográficos são o padrão aceito — a `b06` de `destino-franca` mostra
a Torre Eiffel e está aprovada. Isso foi mantido como critério.

## RESOLVIDO — 2026-08-04

O dono revisou o critério (ver `CRITERIO-TEXTO.md`): texto é permitido desde que esteja
no idioma do destino e correto. Sob o critério novo, `franca b17` (cruz de farmácia) e
`franca b14` (teclado numérico) deixaram de ser violação. As demais permaneceram, porque
o que têm é **pseudo-texto inventado pelo gerador**, não texto correto.

**As 13 violações remanescentes foram todas regeneradas e commitadas.**

| curso | ids corrigidos |
|---|---|
| destino-alemanha | b04, b10, b17, i02, i03, i10 |
| destino-franca | a01, b02, b06, i02, i03, i05, i07 |

Cada uma foi conferida visualmente antes de substituir o arquivo, e a verificação de md5
confirma ausência de duplicatas em ambos os acervos.

### O que funcionou

Nomear o objeto específico no prompt, em vez de repetir a proibição genérica:

- painel de partidas → "faixas luminosas e manchas de cor fora de foco, SEM linha de
  caracteres discernível"
- rótulos → "garrafas LISAS, vidro colorido puro, sem papel, sem escrita e sem selo"
- conta/recibo → "retângulo claro LISO e em branco"
- lousa de menu → "MUITO desfocada, lida apenas como superfície escura"
- crachá → "cordão liso no pescoço, SEM crachá pendurado"

Onde a cena original já pedia desfoque ("painel luminoso e desfocado", "lousa de menu
desfocada"), a correção foi só reforçar o que o pedido já dizia — o gerador é que havia
ignorado.

## Ainda pendente: os 15 duvidosos

Continuam sem ação, à espera de critério humano. São casos onde não dá para afirmar, na
resolução entregue, se a marca é texto ou textura — rótulo borrado, etiqueta de gola,
marcas em toldo distante. Lista completa na seção acima.
