# Fila de imagens — PRIORIDADE MÁXIMA (2026-08-09)

## 1. destino-japao (36) — DESTINO NOVO, prioridade máxima
Pedido: pedidos/13-destino-japao.json · Entregar em entregues/destino-japao/
Destrava os maiores corredores asiáticos: ZH→Japão 6,98 M, KO→Japão 8,82 M, EN→Japão 2,72 M.
Ver recado em RESPOSTA-DO-PC-3.md.

---

# Fila de imagens — estado real em 2026-08-05

## O que mudou hoje, e por que a fila foi reescrita

Passou a existir um portão, `scripts/valida-arte.mjs`, em todos os 14 cursos. Ele
compara as imagens **por hash** contra o acervo dos SKUs de outro destino, usando
`entregues/destino-*/` desta ponte como prova de procedência.

Ele achou o mesmo acidente pela sétima vez no catálogo: **um SKU novo nasce
copiando outro, e a cópia traz `static/img` junto**. O app monta
`img/<slot>.webp`, o arquivo existe, a página renderiza, o build fica verde — e
o curso de Istambul mostra uma foto de Madri. Nenhum portão pegava isso porque
todos testavam o NOME do arquivo, e o nome sempre esteve certo.

Registro retroativo: as 36 imagens originais da Espanha foram gravadas em
`entregues/destino-espanha/` para dar procedência ao portão. Elas são
legitimamente compartilhadas pelos quatro SKUs de destino Espanha — arte é ativo
de DESTINO, igual ao áudio nativo, e reilustrar a mesma Espanha para cada
comprador seria queimar dinheiro. O defeito é servir a Espanha em outro país.

## Estado por curso, medido e não estimado

| curso | próprias | de outro destino | ausentes | pedido |
|---|---:|---:|---:|---|
| curso-espanha (EN·DE·FR·IT) | 36/36 | 0 | 0 | — |
| curso-franca-en / -de | 36/36 | 0 | 0 | — |
| curso-grecia-en / -de | 36/36 | 0 | 0 | — |
| curso-italia-en | 20/36 | 15 | 1 | **11** |
| curso-italia-de | 20/36 | 16 | 0 | **11** |
| curso-mexico-en | 14/36 | 21 | 1 | **12** |
| curso-turquia-en | 0/36 | 21 | 15 | **3** |
| curso-turquia-de | 0/36 | 36 | 0 | herda do EN |
| curso-portugal-en | 0/36 | 21 | 15 | **10** |

`turquia-de` e `italia-de` não precisam de pedido próprio: mesmo destino que o
irmão EN, então recebem a mesma arte por sincronização assim que o EN fechar.

## Ordem sugerida, e o critério

O critério é quanto turista o corredor vale e quão perto o curso está de publicar.

> **Atenção, coordenação:** o Mac deu ACK no pedido 9 às 13h55 e começou a produzi-lo;
> eu apaguei o 9 às 15h30 sem ver o ACK. O conteúdo é o mesmo do 12 — mudaram só o número
> e a extensão (`.png` → `.webp`). Nada do que ele gerou se perde. Ver `RESPOSTA-DO-PC.md`.

> **Critério de texto:** os quatro pedidos foram reescritos com a regra de 2026-08-04.
> Texto **pode** aparecer, na língua do destino, **desde que ditado no pedido** — o que o
> gerador erra é o texto que inventa sozinho. Ver `CRITERIO-TEXTO.md`.

1. **`3-destino-turquia`** — 36 imagens. A pasta `entregues/destino-turquia/`
   existe e está VAZIA, então o pedido nunca foi executado. É o curso mais
   urgente: o conteúdo fechou hoje (36/36 partes, 1.431 áudios, portões verdes) e
   a arte é a única camada que falta. Türkiye recebe 60,5 M de turistas.
2. **`12-destino-mexico`** — 22 imagens. EUA→México é 14,1 M, o maior corredor
   comprador pago do mapa, e o curso está pronto para publicar fora isto.
   *Substitui o pedido 9 — mesmos slots, extensão `.webp` em vez de `.png`. O Mac já
   começou o 9: o trabalho dele aproveita inteiro.*
3. **`11-destino-italia`** — 16 imagens. Fecha os dois SKUs de Itália de uma vez
   (EN e DE), e Alemanha→Itália é o maior corredor individual europeu, 14,1 M.
   *Substitui o pedido 8.*
4. **`10-destino-portugal`** — 36 imagens. O curso ainda está sendo escrito, então
   não bloqueia nada hoje; pode entrar por último.

## O que NÃO mudou

O bloco de estilo é o mesmo, e a trava de "nenhuma bandeira, nenhum brasão,
nenhuma placa, nenhum letreiro" continua valendo — foi a correção de processo
que você mesmo aplicou a partir do `b06` da Itália, e ela está copiada em todos
os pedidos novos.

As 36 cenas também são as mesmas, e é assim que tem de ser: elas são universais
na **composição** e instanciadas no **ambiente** do destino. É por isso que o
`b02` da Türkiye é um café com copo-tulipa de chá e o de Portugal é uma
pastelaria com balcão de mármore, sendo a mesma cena.
