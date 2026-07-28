# kit-imagens — ponte de geração de imagens

Coordena a produção das imagens dos cards do Kit de Bordo entre duas máquinas que
nunca se falam direto. **O git é o único canal.**

- **PC** (onde vive o código, `D:/dev`): gera os pedidos a partir do código de cada
  curso e recolhe as entregas, distribuindo-as para `static/img/` de cada curso.
- **Mac** (onde roda o ChatGPT): lê os pedidos, produz as imagens, devolve em `entregues/`.

## Estrutura

```
pedidos/<curso>.json   ← lista FECHADA de arquivos esperados (o contrato)
pedidos/<curso>.md     ← o mesmo, legível, para o Claude do Mac colar
entregues/<curso>/     ← o Mac deposita <id>.webp aqui
entregues/<curso>/_notas.md  ← o Mac anota o que pulou e por quê
tools/pedido.mjs       ← gera um pedido a partir de D:/dev/_projects/<curso>
STATUS.md              ← estado da fila, atualizado pelo PC
PROMPT-MAC.md          ← cola-se uma vez na conversa do Mac
```

## O protocolo, e por que ele aguenta falha

Um pedido está **completo** ⟺ todo `id` de `pedidos/<curso>.json` existe em
`entregues/<curso>/`. Não há flag de status, nem "done", nem lock: **o disco é a fonte da
verdade**, e os dois lados computam o mesmo a partir dele. Consequências:

- **Idempotente.** O Mac só gera o que falta. Se cair no meio, retoma sem repetir.
- **Sem corrida.** O PC pode recolher entregas parciais; o Mac pode empurrar em lotes.
- **Sem memória.** Nenhum dos dois lados precisa lembrar do que fez — reabrir a sessão
  e dar `git pull` reconstrói o estado inteiro.

## O encadeamento entre cursos

O PC observa `entregues/`. Quando um curso fica completo, o PC (a) distribui as imagens
para o repositório daquele curso e (b) **gera o pedido do próximo** com
`node tools/pedido.mjs <próximo-curso>` e o empurra. O Mac, no `git pull` seguinte, vê o
pedido novo e começa — sem ninguém precisar avisar.

## O limite honesto

Os dois "listeners" são laços de polling que vivem **enquanto a sessão de cada Claude
estiver aberta**. Não há daemon. Se a conversa do Mac fechar, a produção para até ela ser
reaberta com `git pull`; o estado nunca se perde, mas não avança sozinho. É automação
enquanto ambos estão vivos, não um serviço permanente.
