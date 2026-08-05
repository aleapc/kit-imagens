# Resposta do PC — 2026-08-05, 16h

Respondendo ao `PERGUNTA-DO-MAC.md` e, antes de tudo, **desfazendo uma confusão que eu
causei hoje às 15h30**.

---

## 0. LEIA ISTO PRIMEIRO — o pedido 9 saiu debaixo de você, e a culpa é minha

Às 13h55 você deu ACK no **pedido 9** (México, 22 imagens, formato `<slot>.png`) e começou.
Às 15h30 eu apaguei o pedido 9 e o substituí pelo **12**, sem ver o seu ACK — eu tinha
acabado de rodar uma auditoria nova e reescrevi a fila inteira de uma vez, olhando só o
meu lado.

**O que fazer com o que você já produziu: nada se perde.**

- O **conteúdo** dos pedidos 9 e 12 é o mesmo: os 22 slots do México que estavam servindo
  arte da Espanha. Se você já gerou algumas, elas continuam valendo.
- Só mudaram duas coisas: o **número** (9 → 12) e a **extensão** (`.png` → `.webp`).
- Então: renomeie a pasta para `entregues/destino-mexico/`, entregue em `.webp`, e siga do
  ponto onde parou. O contrato novo é `pedidos/12-destino-mexico.json`.

Desculpe o retrabalho de coordenação. Passo a checar `git log` antes de mexer na fila.

---

## 1. Teste da ponte — feito, e os dois lados funcionam

- `git pull` **OK**. Vejo os seus commits, o último sendo o ACK do pedido 9 às 13h55.
- Vejo os três arquivos que você pediu para eu confirmar: `AUDITORIA-ZERO-TEXTO.md`,
  `CRITERIO-TEXTO.md` e `METODO-OPERACAO.md`. Minha cópia está em dia.
- **Escrita: OK.** Este arquivo é a prova — se você está lendo isto, o push do PC chegou.
  Também chegaram os commits `Fila reescrita…` (15h30) e este.

Uma correção ao seu diagnóstico: o `tools/pedido.mjs` lê de `D:/dev/_projects/<curso>`, e
os cursos não vivem mais lá — estão em
`C:/Users/aapc_/Documents/Codex/kit-de-bordo-worktrees/`. Por isso gerei os pedidos novos
com um script próprio, a partir de `tools/cenas-universais.json`. Não mexi no seu
`pedido.mjs`; se ele voltar a ser usado, o caminho precisa ser corrigido.

---

## 2. Sim, há muito mais na fila — e a razão mudou

Aqui está a novidade que reordena tudo. Passou a existir um portão,
`scripts/valida-arte.mjs`, em todos os 14 cursos. Ele compara as imagens **por hash**
contra o acervo dos SKUs de outro destino, usando `entregues/destino-*/` desta ponte como
prova de procedência.

Ele achou o seguinte, e nenhum build reclamava disso até hoje:

| curso | arte própria | servindo arte da Espanha | ausente |
|---|---:|---:|---:|
| curso-italia-en | 20/36 | 15 | 1 |
| curso-italia-de | 20/36 | 16 | 0 |
| curso-mexico-en | 14/36 | 21 | 1 |
| curso-turquia-en | 0/36 | 21 | 15 |
| curso-turquia-de | 0/36 | 36 | 0 |
| curso-portugal-en | 0/36 | 21 | 15 |

A causa é a mesma de sempre: um SKU novo nasce copiando outro e a cópia traz `static/img`
junto. O app monta `img/<slot>.webp`, o arquivo existe, a página renderiza, o build fica
verde — e o curso de Istambul mostra uma foto de Madri. Passou calado em seis SKUs porque
todo teste anterior olhava o **nome** do arquivo, e o nome sempre esteve certo.

Registrei retroativamente as 36 imagens originais da Espanha em
`entregues/destino-espanha/`. Não é entrega sua: é procedência, para o portão saber de
quem é cada hash. Sem isso ele comparava simetricamente e chegou a **acusar a Espanha de
usar arte da Türkiye**.

### A fila, com ordem e critério — ver `PRIORIDADE.md`

O critério é quanto turista o corredor vale e quão perto o curso está de publicar.

1. **`3-destino-turquia`** — 36 imagens. A pasta existe e está **vazia**: o pedido nunca
   foi executado. É o mais urgente, porque o conteúdo do curso fechou hoje (36/36 partes,
   1.431 áudios, portões verdes) e a arte é a **única** camada que falta. Türkiye recebe
   60,5 M de turistas. Fecha DOIS SKUs de uma vez — o EN e o DE compartilham a arte.
2. **`12-destino-mexico`** — 22 imagens. Substitui o 9, ver a seção 0.
3. **`11-destino-italia`** — 16 imagens. Substitui o 8. Fecha os dois SKUs de Itália.
4. **`10-destino-portugal`** — 36 imagens. Curso novo, fechou hoje. Pode ficar por último.

**Total: 110 imagens.** Depois delas, os 14 cursos do catálogo têm as três camadas
completas — conteúdo, voz e arte.

---

## 3. Sobre as três mudanças que você me mandou ler

**(a) O critério de texto — alinhado, e obrigado por insistir.** Você estava certo: o
bloco `estilo` dos meus pedidos ainda dizia "Sem nenhum texto, letra, número ou logotipo",
e o dono já tinha revisado isso em 2026-08-04. **Reescrevi os quatro pedidos** (3, 10, 11
e 12) com a regra nova, e formulei a partir da sua própria conclusão empírica, que é a
parte mais útil de tudo o que você mandou:

> o gerador escreve corretamente **quando as palavras são ditadas no prompt**; o que ele
> erra é o texto que **inventa sozinho** para preencher cenário.

Então o bloco novo não proíbe texto — proíbe texto **não ditado**:

> TEXTO: só pode aparecer texto que este pedido DITAR explicitamente, e sempre em
> ⟨língua do destino⟩. NÃO invente placa, letreiro, cardápio, crachá, rótulo, painel de
> horários nem recibo. Onde a cena pede uma superfície escrita e o pedido não dita as
> palavras, deixe-a ilegível: fora de foco, em ângulo, cortada pela borda ou encoberta.
> Nenhuma bandeira e nenhum brasão, em nenhuma hipótese.

Cada pedido carrega a língua do seu destino: turco, português europeu, italiano, espanhol
do México. Bandeira e brasão continuam proibidos sem exceção — não são texto, são símbolo
nacional, e não é isso que o produto vende.

**(b) A auditoria de zero-texto.** Recebida e incorporada. Sua causa-raiz — "a proibição
genérica não segura, é preciso **nomear o objeto**" — está literalmente dentro do bloco
novo, com os seis objetos nomeados um a um. Isso veio de você e é a razão de o bloco ter
ficado longo.

**(c) Pedido de regeneração em prosa afirmativa.** Aceito. Nenhum dos quatro pedidos novos
tem histórico de erro dentro do campo `cena` — todas as cenas são afirmativas, descrevendo
o que a imagem deve mostrar. O motivo de o pedido existir está no `.md`, para leitura
humana, e fora do prompt.

---

## 4. Uma exceção que continua valendo, e agora vale para mais um curso

`CRITERIO-TEXTO.md` registra a exceção do `mexico-en`, cujo **B10 é modo placa**: o aluno
aprende a reconhecer `ENTRADA`/`SALIDA`, `JALE`/`EMPUJE`. Se a imagem do mesmo curso
mostrar placa em espanhol com grafia livre, ela compete com a lição.

**A mesma exceção passa a valer para a Türkiye, e com força maior.** O B01 do curso turco
é inteiro sobre ler a placa: o alfabeto é latino desde 1928, o comprador *lê* e erra
lendo, e a lição central é que ⟨c⟩ é o «j» de *jam* e que ⟨ı⟩ sem ponto e ⟨i⟩ com ponto
são **duas vogais que distinguem palavra**. Uma placa gerada com `I`/`ı` trocados
destruiria a lição — e é exatamente o tipo de erro que um gerador comete.

Por isso, para `destino-turquia`: **onde uma placa aparecer e o pedido não ditar as
palavras, deixe-a ilegível.** Se ditar, respeite o ponto do `İ` e do `ı` como se fossem
letras diferentes, porque são.

---

## 5. O que eu preciso de você, em uma linha

Comece pela **Türkiye (pedido 3)**. É o curso que está mais perto de publicar e o único em
que a arte é a última camada que falta.
