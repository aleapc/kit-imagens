# Critério de texto nas imagens — revisão do dono, 2026-08-04

## A regra nova

O bloco de `estilo` dos pedidos `destino-*` diz "Sem nenhum texto, letra, número ou
logotipo na imagem." O dono revisou esse critério em 2026-08-04:

> **Texto pode existir, desde que esteja na língua do país visitado e correto.**
> *"Um turista na Espanha não vai encontrar uma placa escrita em alemão."*

## O raciocínio

O eixo do produto é **destino × língua materna do aluno**. `curso-espanha-de` e
`curso-espanha-fr` são o mesmo curso sobre visitar a Espanha, servidos a alunos de
línguas maternas diferentes — e usam **a mesma arte** (verificado: arquivos byte-idênticos
entre as variantes).

Como o destino é único por acervo, o idioma que apareceria numa placa também é único. Uma
placa em espanhol dentro de `curso-espanha-*` está correta para todos os alunos, seja o
aluno alemão ou francês. Texto no idioma do destino **não** quebra o reuso.

O que quebra é texto no idioma **errado** ou inventado.

## Teste empírico — 2026-08-04

Havia dúvida se o gerador consegue escrever um idioma corretamente. Testado com pedido
explícito de italiano:

> Sobre a porta, uma placa com a palavra CAFFÈ. Ao lado, uma lousa com três linhas a giz
> em italiano correto: ESPRESSO, CORNETTO, PANINO.

**Resultado: as duas variantes saíram com grafia perfeita**, inclusive o acento grave de
`CAFFÈ`. Nenhuma letra inventada.

**Conclusão que isso permite:** o gerador escreve corretamente **quando as palavras são
ditadas no prompt**. O que ele erra é o texto que inventa sozinho para preencher cenário —
daí o pseudo-texto encontrado na auditoria, onde nada havia sido ditado.

## Regra operacional

| situação | decisão |
|---|---|
| Palavras **ditadas no prompt**, na língua do destino | ✅ permitido — conferir a grafia na revisão visual |
| Texto que o gerador **inventa** (placa/cardápio/rótulo não pedido) | ❌ proibido — sai pseudo-texto |
| Texto em idioma que não é o do destino | ❌ proibido |
| Logotipo de marca comercial | ❌ proibido |
| Números e dígitos | ✅ universais |
| Sinalização internacional sem idioma (cruz de farmácia) | ✅ permitido |
| Texto na faixa inferior, onde o card sobrepõe o título | ❌ evitar |

Trava adotada nos prompts, substituindo a proibição total anterior:

> Nenhum texto inventado ou ilegível. Se aparecer texto na imagem, apenas as palavras
> ditadas acima, grafadas corretamente em <idioma do destino>. Superfícies sem palavra
> ditada ficam lisas e vazias.

## Efeito sobre a auditoria de `AUDITORIA-ZERO-TEXTO.md`

As 15 imagens marcadas como violação foram descritas pelos auditores como "texto impresso
ilegível", "marcas que podem formar letras", "linhas de escrita" — ou seja, **pseudo-texto
que o gerador inventou**, nenhum ditado. Continuam reprovadas sob o critério novo, pela
segunda linha da tabela.

O que muda é a **correção**: em vez de remover o texto, agora é possível ditar a palavra
certa no idioma do destino — o que produz uma cena mais verossímil que uma parede vazia.

Os itens antes classificados como violação por serem "logotipo" ou "dígito" saem da lista:
- `franca b17` — só a cruz verde de farmácia → aceitável
- `franca b14` — só o teclado numérico → aceitável

`alemanha b17` **permanece**: além da cruz, tem rótulos com letras em caixas de remédio.

**Violações remanescentes: 13** (era 15).

| curso | ids |
|---|---|
| destino-alemanha | b04, b10, b17, i02, i03, i10 |
| destino-franca | a01, b02, b06, i02, i03, i05, i07 |
