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

## Sincronizado em 2026-08-05

`sincroniza-instalacao.mjs --aplicar` rodado: **destino-grecia 36/36 instalado** nas duas
worktrees de Grécia (36 imagens próprias, conferido por md5), e **b17/b18 de Itália**.

## Fila, em ordem

1. **`pedidos/7-mexico-avancado.json` — 7 imagens (A02–A08).** Passou à frente: `curso-mexico-en`
   está 36/36 com 1.218 mp3 e build verde, e **sete imagens fecham o acervo de um curso pronto**.
   Formato de exceção: PNG 1536×1024, fotográfico, zero texto estrito.
2. **`pedidos/8-destino-italia-parte-2.json` — 18 restantes** (b17 e b18 já entregues).**
   Dois cursos completos, com áudio gravado e build verde, estão prontos para publicar e
   hoje mostram **foto da Espanha em 17 slots** e nada em 3. Um deles, DE→Itália, é o
   **maior corredor individual da Europa** (14,1 M de chegadas/ano).
   Uma entrega destrava os dois.
3. `pedidos/3-destino-turquia.json` — **não priorizado.** Zero curso de Turquia, zero mp3.
   As 36 imagens ficariam guardadas. `5-destino-alemanha.json` segue **estacionado**.

> **Correção registrada:** este arquivo mandou despriorizar a Grécia, e o argumento estava
> certo quando foi escrito — não havia curso grego. Poucas horas depois havia: EN → Grécia
> fechou 36/36 com portões verdes. A regra não muda (**prioridade acompanha conteúdo
> pronto**); o que mudou foi o conteúdo. A entrega do Mac acabou chegando na hora exata.

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
