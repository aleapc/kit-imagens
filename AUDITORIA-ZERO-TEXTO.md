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

## RESOLVIDO — os 15 duvidosos auditados com zoom (2026-08-08)

Cada um dos 15 foi ampliado (recorte + upscale via `sips`, região do elemento suspeito) e
julgado objetivamente. Critério: pseudo-texto legível/inventado = corrige; textura,
desfoque, dígitos e quadros decorativos = mantém.

### Resultado

| curso | id | elemento | veredito |
|---|---|---|---|
| alemanha | a02 | caixa de talheres | limpo (madeira) |
| alemanha | b03 | comanda | limpo (marca ondulada mínima, sem palavra) |
| alemanha | **b07** | **letreiros de táxi** | **pseudo-texto** |
| alemanha | b13 | conta manuscrita | limpo (rabisco indistinto) |
| alemanha | b14 | teclado | limpo (só dígitos, permitidos) |
| alemanha | i04 | cartazes na fachada | limpo (molduras desfocadas) |
| alemanha | i06 | quadros | limpo (pinturas decorativas) |
| alemanha | i07 | maquininha | limpo (tela apagada, dígitos) |
| franca | a04 | papéis na porta | limpo (aviso ilegível, imperceptível em tamanho real) |
| franca | a05 | rótulos | limpo (rótulos claros sem escrita) |
| franca | **b07** | **painel do terminal + letreiros de táxi** | **pseudo-texto** |
| franca | **b13** | **nota do garçom** | **pseudo-escrita (várias linhas)** |
| franca | b15 | etiqueta na gola | limpo (marca minúscula ilegível) |
| franca | i04 | toldo | limpo (toldo desfocado) |
| franca | i10 | placas + rótulos | limpo (papel liso, molduras desfocadas, moedas OK) |

**3 com pseudo-texto real; 12 limpos.**

### O que foi corrigido

Só o acervo **no ar** precisava de correção. Regenerados e conferidos com zoom antes de
substituir:

- **franca b07** — táxis sem letreiro, terminal sem painel escrito.
- **franca b13** — cartão totalmente liso e em branco.

**alemanha b07 NÃO foi corrigida de propósito:** o acervo `destino-alemanha` está parado
(sem curso, não está no ar), então a arte dele não tem consumidor. Fica registrado aqui; se
o curso da Alemanha for retomado, regenerar b07 antes de publicar.
