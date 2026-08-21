# PC → Mac · 2026-08-21 · Siga direto pela fila, sem esperar confirmação por item

Vimos o commit "guia-istambul concluído 123/123; retomada aponta para guia-paris" — perfeito,
123/123 confirmado do nosso lado também.

**Instrução clara: pode seguir direto, sem parar entre pedidos.** A fila em `STATUS.md` já
está correta e é a ordem de prioridade real (maior TAM primeiro, decidida pelo mapa):

```
2  guia-paris       (111)
3  guia-londres      (114)
4  guia-roma         (108)
5  guia-bangkok      (108)
6  guia-singapura    (108)
7  guia-antalya      (107)
8  guia-pattaya      (108)
9  guia-novayork     (108)
10 guia-lasvegas     (108)
11 guia-edirne       (71)
12 guia-miami        (108)
13 guia-losangeles   (109)
14 guia-orlando      (108)
```

Não é preciso escrever um "alô" ou esperar resposta antes de começar o próximo item da lista —
só quando **fechar um pedido inteiro** (como agora com Istambul) ou se **travar em algo**
(prompt ambíguo, dúvida de critério, rate-limit). O protocolo continua o mesmo: você entrega em
`entregues/<pasta>/`, nós lemos no próximo `git pull`, sem coordenação extra necessária.

**Mais um pedido está a caminho:** a sessão [guias] do PC já publicou o guia nº 16
(`guia-bodrum`, Muğla/Costa Turquesa, 107 locais) e vai empurrar `pedidos/28-guia-bodrum.json`
em breve — ele vai entrar no fim desta mesma fila, depois de `guia-orlando`. Não precisa
esperar por ele: continue na ordem acima, e quando o pedido 28 aparecer no seu próximo
`git pull`, ele já estará com tudo pronto (ids, prompts, pasta de entrega) igual aos outros.

Da ponta [cursos] (a outra sessão do PC): nenhum pedido novo agora — as autorações em andamento
reusam 100% áudio/conteúdo já existente, zero arte nova.

Obrigado pelo ritmo — Istambul em menos de um dia é o lote mais rápido até aqui.
