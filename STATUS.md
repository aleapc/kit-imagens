# Estado da fila

Atualizado pelo PC. Última revisão: **2026-08-05**, depois de o listener do Mac voltar.

> **Aviso:** a versão anterior deste arquivo descrevia um mundo que não existe mais. Ela
> priorizava `mexico-regen` e falava de uma fila `grécia → itália → turquia` montada
> quando **nenhum curso de Itália existia**. Entre uma coisa e outra, dois cursos de
> Itália fecharam. A fila abaixo é a real.

## O que mudou

| curso | conteúdo | áudio | arte própria | estado |
|---|---:|---:|---:|---|
| curso-espanha (EN·DE·FR·IT) | 36/36 | ✅ | ✅ | **no ar** |
| curso-mexico-en | 36/36 | 1.218 mp3 | 29/36 | pronto p/ publicar |
| **curso-italia-en** | **36/36** | **1.082 mp3** | **16/36** | pronto p/ publicar |
| **curso-italia-de** | **36/36** | **1.082 mp3** | **16/36** | pronto p/ publicar |
| curso-franca-en | em escrita | — | 36/36 ✅ | arte pronta, conteúdo em produção |
| grécia · turquia · portugal · franca-de | não iniciado | — | 31 / 0 / — / — | sem curso para servir |

## Fila, em ordem

1. **`pedidos/8-destino-italia-parte-2.json` — 20 imagens. É o gargalo real.**
   Dois cursos completos, com áudio gravado e build verde, estão prontos para publicar e
   hoje mostram **foto da Espanha em 17 slots** e nada em 3. Um deles, DE→Itália, é o
   **maior corredor individual da Europa** (14,1 M de chegadas/ano).
   Uma entrega destrava os dois.
2. `pedidos/7-mexico-avancado.json` — 7 imagens (A02–A08). México também está completo
   e esperando; volume menor, mesma natureza.
3. `pedidos/4-destino-grecia.json` — **desprioritizado.** Tem 31 imagens entregues e
   **nenhum curso** para servir: as worktrees de Grécia continuam clones intocados da
   Espanha, com 0 mp3. Arte adiantada não vira produto.
4. `pedidos/3-destino-turquia.json`, `5-destino-alemanha.json` — mesma situação, e a
   Alemanha segue **estacionada** (não há curso nem previsão).

## O princípio que reordena isto

Arte e áudio nativo são **ativos de DESTINO**. Duas coisas seguem daí:

- **Uma entrega serve todos os SKUs do mesmo destino.** As 20 imagens do pedido 8 servem
  `curso-italia-en` e `curso-italia-de` sem uma variação sequer — foi assim que os 551
  clipes de áudio italiano entraram no SKU alemão a custo zero de crédito. O mapa em
  `tools/sincroniza-instalacao.mjs` já instala destino-italia nos dois worktrees.
- **Prioridade acompanha CONTEÚDO PRONTO, não ordem de chegada.** Banco de imagem sem
  curso é estoque parado; curso completo servindo arte do país errado é defeito em
  produção. A Grécia é o primeiro caso; a Itália era o segundo.

## Sobre texto nas imagens

Vale `CRITERIO-TEXTO.md`: texto **pode** existir, desde que esteja **na língua do país
visitado** e correto. Numa imagem de `destino-italia`, placa em espanhol é defeito. Na
dúvida sobre a grafia, prefira a superfície de costas, fora de foco ou sem escrita —
errar a língua é pior do que não ter texto.

_(Exceção documentada: `7-mexico-avancado` foi pedido com zero-texto estrito, por decisão
registrada no próprio pedido. Não é a regra geral.)_
