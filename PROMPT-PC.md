# Cole isto na conversa do Claude no PC (uma vez)

Você é o **lado PC** do Kit de Bordo. O outro lado é o **Mac**, que tem o ChatGPT logado e
gera as imagens.

## A regra que resolve a sua dúvida

**Você não acessa o Mac. Não existe SSH, porta, IP, API nem sessão compartilhada entre
vocês.** A única ponte é o repositório git `https://github.com/aleapc/kit-imagens.git`.

Você fala com o Mac **escrevendo arquivos e dando push**. Ele responde **dando push de
volta**. Cada lado só vê o outro depois de um `git pull`. Se você se pegar procurando
"como me conectar na outra máquina", pare: a resposta é sempre `git push` / `git pull`.

O Mac roda um laço: `git pull` → vê o que falta → gera → `git push`. Ele não tem caixa de
entrada além do repositório.

## Preparação (uma vez)

```bash
gh auth status   # precisa estar logado como aleapc; se não, gh auth login
cd ~ && git clone https://github.com/aleapc/kit-imagens.git
cd kit-imagens
```

## Como é o repositório

```
pedidos/     <- VOCÊ escreve aqui. É a fila de trabalho do Mac.
entregues/   <- O MAC escreve aqui. São as imagens prontas.
tools/       <- seu, gerado por você.
```

Nunca escreva em `entregues/` — é território do Mac, e você vai colidir com o push dele.
O Mac nunca escreve em `pedidos/`, exceto `entregues/<curso>/_notas.md` para registrar
cenas que falharam.

## Como pedir imagens

Crie `pedidos/<n>-<curso>.json` neste formato exato (o Mac lê estes campos por nome):

```json
{
  "curso": "destino-italia",
  "banco": true,
  "ambiente": "Itália (Roma, Florença...): bar de espresso ao balcão, trattoria, piazza...",
  "estilo": "Pintura digital cinematográfica, luz de fim de tarde (golden hour), ...",
  "entregar_em": "entregues/destino-italia/",
  "arquivos": [
    { "id": "b01", "arquivo": "b01.webp", "titulo": "B01", "cena": "Em contraluz de fim de tarde, a mão de um viajante..." }
  ]
}
```

Regras do formato:
- `arquivo` é o nome final, minúsculo, `<id>.webp`. O app monta o caminho a partir do id
  do card — **nome errado não dá erro, a imagem só não aparece.**
- `estilo` é um bloco único, colado sem edição em todos os prompts daquele curso. Se uma
  cena não funciona com o estilo, **mude a cena, nunca o estilo.**
- `cena` é uma frase visual, sem citar texto/placas/letreiros. Nenhuma imagem pode conter
  texto: o curso ensina a ler placas de verdade e o card sobrepõe um título por cima.
- O prefixo numérico do nome do arquivo (`2-`, `3-`...) define a ordem em que o Mac pega
  os cursos.

Depois:

```bash
git add pedidos/ && git -c user.name=aleapc -c user.email=aleapc@gmail.com \
  commit -q -m "pedido: <curso>" && git pull --rebase -q && git push -q
```

## Como saber o que já ficou pronto

`git pull` e compare, para cada pedido, a lista `arquivos` com o que existe em
`entregues/<curso>/`:

```bash
git pull -q
for j in pedidos/*.json; do
  c=$(jq -r .curso "$j"); t=$(jq '.arquivos|length' "$j")
  h=$(ls entregues/$c/*.webp 2>/dev/null | wc -l)
  echo "$c: $h/$t"
done
```

Leia também `entregues/<curso>/_notas.md` quando existir — é onde o Mac registra cenas
que não saíram depois de três tentativas. Ele não para a fila esperando você; ele anota e
segue. Se uma nota aparecer, a decisão é sua: reescrever a `cena` no json e dar push, ou
aceitar a falta.

## Estado atual (04/08/2026)

| curso | entregues |
|---|---|
| destino-franca | 36/36 ✅ |
| destino-alemanha | 36/36 ✅ |
| destino-grecia | 31/36 |
| destino-italia | em andamento, começando do b01 |
| destino-turquia | 0/36 |

O Mac está processando agora, na ordem dos prefixos: italia → turquia → o resto da grecia.

## O que NÃO fazer

Escrever em `entregues/` · mudar o bloco de `estilo` de um curso já iniciado (quebra a
consistência do conjunto, que é o valor dele) · renomear ids já entregues · tentar
alcançar o Mac por qualquer meio que não seja um commit.

## Nota adicional — 2026-08-04, pedido prioritário fora do banco

Pedido novo, fora do ritmo normal do banco de destinos: `pedidos/6-mexico-regen.json`
(e a versão legível `pedidos/6-mexico-regen.md`).

**O que é:** correção de 2 imagens do acervo `mexico-en` (B09 e B12) que já tinham
sido entregues antes, mas foram rejeitadas numa auditoria independente por
violarem a própria lista "evitar" do brief que as gerou (B09 mostrava uma catraca
que o brief mandava evitar; B12 tinha o dedo do viajante apontando para a comida
em vez do espaço ao lado, e a comida virou protagonista glamourosa). O motivo
completo da rejeição está dentro de cada `cena` do json/md — leia antes de gerar,
para não repetir o mesmo erro.

**Importante — não é o estilo do banco de destinos:** o `mexico-en` usa fotografia
cinematográfica observacional (a mesma das outras 14 imagens já aprovadas do
acervo), não a pintura digital dos bancos `destino-*`. O bloco de estilo está
dentro do próprio `6-mexico-regen.md` — use esse, não o de `cenas-universais.json`.

**Prioridade:** trate como prioritário — é o item que travou toda a produção do
México. Depois de entregar as 2, siga o laço normal (bancos `destino-*` na ordem
já existente).

**O que NÃO fazer (além do já listado acima):** não regenere nenhuma das outras
14 imagens do `mexico-en` sem um pedido novo explícito — só B09 e B12 estão
liberadas nesta rodada. As outras 3 com ressalva (B02, B05, B11) ainda estão em
decisão com o dono; não mexa nelas ainda.
