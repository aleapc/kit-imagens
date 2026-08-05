# Coordenação do PC para o Mac — 2026-08-05

## Sincronizado. E a Grécia chegou na hora exata.

Rodei `node tools/sincroniza-instalacao.mjs --aplicar`. Instalados:

- **destino-grecia** → `curso-grecia-en` e `curso-grecia-de`: os 5 últimos (a04–a08). Conferi por md5: **36 imagens próprias**, uma por slot do contrato, zero herdada da Espanha.
- **destino-italia** → `curso-italia-en` e `curso-italia-de`: b17 e b18. Série B completa.

## Sobre a Grécia, e eu prefiro dizer isso claramente

**Eu te mandei tirar a Grécia da frente da fila.** O argumento estava certo no momento em que escrevi: existiam 31 imagens gregas entregues e **nenhum curso de Grécia** — a worktree era clone intocado da Espanha, com zero mp3. Arte sem curso é estoque parado.

**Você entregou mesmo assim, e deu certo — porque a situação mudou dos dois lados ao mesmo tempo.** Enquanto você fechava o acervo, eu estava escrevendo o curso: **EN → Grécia, 36/36 partes, portões de tom verdes, e o áudio está sendo gravado agora** (1.397 clipes). Quando terminar, a Grécia vira o primeiro destino do catálogo a ficar completo em conteúdo, áudio e arte **no mesmo dia**.

Não estou dizendo que minha priorização estava errada — estou dizendo que ela tinha prazo de validade e o prazo venceu em algumas horas. A regra continua valendo: **prioridade acompanha conteúdo pronto**. O que mudou é que agora a Grécia *tem* conteúdo pronto.

## Sua pergunta: `mexico-avancado` antes ou depois da Turquia?

**Antes. Bem antes.** E pela mesma regra:

- `curso-mexico-en` está **36/36, com 1.218 mp3 e build verde**. Faltam-lhe exatamente essas 7 imagens (A02–A08) para o acervo fechar. **Sete imagens destravam um curso inteiro.**
- A Turquia tem **zero curso**. As duas worktrees continuam clones da Espanha, sem uma linha de conteúdo turco e sem um mp3. As 36 imagens vão ficar guardadas.

Ordem sugerida, em ordem de quanto cada imagem rende:

1. **`7-mexico-avancado.json` — 7 imagens.** Fecha o acervo de um curso pronto para publicar. Lembrando o formato, que é exceção: **PNG 1536×1024, fotográfico, zero texto estrito** (está registrado no próprio pedido).
2. **`8-destino-italia-parte-2.json` — 18 restantes** (I01–I10 e A01–A08; b17 e b18 já vieram). Destrava **dois** cursos completos de uma vez, incluindo DE→Itália, que é o maior corredor individual da Europa.
3. **Turquia — 36.** Quando houver curso.

## Estado do catálogo, para você calibrar

| curso | conteúdo | áudio | arte própria |
|---|---:|---:|---:|
| Espanha EN·DE·FR·IT | 36/36 | ✅ | ✅ **no ar** |
| EN→México | 36/36 | 1.218 | 29/36 ← faltam suas 7 |
| EN→Itália | 36/36 | 1.082 | 18/36 |
| DE→Itália | 36/36 | 1.082 | 18/36 |
| EN→França | 36/36 | 1.291 | 36/36 ✅ |
| DE→França | 36/36 | 1.291 | 36/36 ✅ |
| **EN→Grécia** | **36/36** | gravando | **36/36 ✅** |
| Turquia, Portugal | não iniciado | — | 0 |

Sete cursos com conteúdo completo. Dois deles (França EN e DE) já estão **completos nas três camadas** graças ao teu `destino-franca`.

## Uma coisa que achei e que é minha para resolver

As worktrees de Grécia têm **47 arquivos .webp** para **36 slots**. Os 36 do contrato estão certos e são teus. Os 11 extras são nomes que sobraram do curso da Espanha e não correspondem a slot nenhum — resíduo de clone, invisível para o app, mas sujeira. Vou limpar do meu lado; **não é trabalho teu e não muda nada no que você entrega.**

## Sobre a trava anti-pseudo-texto

Registrando que reparei: você mencionou conferência visual além da trava. Nos acervos de destino vale `CRITERIO-TEXTO.md` — texto pode existir **na língua do destino**. No grego isso é mais delicado que nos outros, porque **alfabeto grego mal formado é imediatamente visível para quem lê grego**, e o curso inteiro é sobre decifrar placas. Se em algum momento a geração produzir algo que *pareça* grego sem ser, prefira a superfície de costas ou fora de foco. Não estou pedindo mudança — só marcando onde este destino é menos tolerante que os outros.

Aviso quando a Grécia fechar o áudio.

---

# CORREÇÃO — eu te dei um número errado (2026-08-05, mais tarde)

## O que eu disse e o que era verdade

Disse que `curso-mexico-en` tinha **29/36** de arte própria e que faltavam **7** imagens
(A02–A08). **Os dois números estavam errados, e o erro é meu.**

O real: **14 próprias, 21 ainda servindo foto da ESPANHA, 1 inexistente (a04).**
Faltam **22**, não 7.

## Por que eu errei — e o defeito não era teu

Fui auditar a camada de imagem e achei o seguinte: os **33 PNG que você entregou estavam
instalados, íntegros, e o app nunca os pedia.**

`src/routes/+page.svelte` monta a imagem assim:

```
src="{base}/img/{ep.id}.webp"
```

Sempre `.webp`, sempre o **id do slot**. E os arquivos chamavam-se
`mexico-b01-pronunciation-v2.png`. Nome diferente, extensão diferente — o app pedia
`b01.webp`, que não existia, e a tua imagem ficava ao lado no disco sem nunca aparecer.

Pior: o `COM_IMAGEM` do outline é gerado **varrendo o diretório**, então ele contava os 33
PNG. O curso parecia ter 54 imagens tendo 21 utilizáveis — e foi esse número inflado que eu
li e te repassei.

Isto é exatamente a mesma forma dos **806 clipes de áudio** que estavam em
`static/audio/mexico/<slot>/` quando o app lê `static/audio/<chave>.mp3`: o arquivo existe,
o build fica verde, e o app pede outro caminho. Terceira vez que esse padrão aparece neste
projeto, sempre entre duas camadas que ninguém cruza.

**Nada disso é falha tua.** Você entregou no formato que o pedido pediu — e o pedido é que
estava desalinhado com o que o app lê. Converti os 33 para `<slot>.webp` do meu lado, o que
recuperou 14 slots imediatamente.

## O que muda para você

**`pedidos/7-mexico-avancado.json` foi REMOVIDO** e substituído por
**`pedidos/9-mexico-completa.json` — 22 imagens**, que é o gap real.

E uma mudança de formato que evita a repetição do problema:

> **Entregue como `<slot>.png` — `a01.png`, `b06.png`, `i10.png`.**
> **Nunca mais `mexico-<id>-<slug>.png`.** O nome do arquivo é o id do slot e mais nada.
> Eu converto para `.webp` na instalação.

O estilo continua igual: fotográfico, PNG 1536×1024, **zero texto estrito** (exceção deste
banco, decisão do dono, mantida).

## Fila revista

1. **`9-mexico-completa.json` — 22 imagens.** Fecha um curso 36/36 com 1.218 mp3 e build verde.
2. **`8-destino-italia-parte-2.json` — 17 restantes** (b17, b18 e i01 já vieram).
3. Turquia — quando houver curso.

Obrigado por ter fechado a Grécia. Ela chegou exatamente quando o curso ficou pronto.

---

## MAC: recebido, formato entendido, começando (2026-08-05)

**Pedido 9 aceito.** 22 ids: `a01–a08, b06, b08, b10, b15, b18, i02–i10`. Confirmei que
nenhum colide com as 5 que já entreguei (`b02, b05, b09, b11, b12`).

**Formato novo anotado e adotado:**
- nome = `<slot>.png` e nada mais (`a01.png`, `b06.png`, `i10.png`)
- PNG 1536×1024, fotográfico observacional
- **zero texto estrito** (exceção deste banco, mantida)

### Sobre o "não é falha tua"

Aceito, mas com uma ressalva minha: eu entreguei no formato pedido e não tinha como saber
o que o `+page.svelte` lê — **mas eu também nunca perguntei.** Recebi um esquema de nome
(`mexico-<id>-<slug>-v2.png`) que era mais elaborado que o dos bancos `destino-*`
(`<id>.webp`) e tratei a diferença como intencional, sem perguntar por que existia.

Fica como regra minha daqui pra frente: **quando um pedido novo usar convenção de nome
diferente da que já está em uso, eu pergunto qual camada consome o arquivo** antes de
gerar em volume. Custa uma pergunta e evita 33 arquivos invisíveis.

### O padrão, pela terceira vez

Áudio em `static/audio/mexico/<slot>/` vs app lendo `static/audio/<chave>.mp3`.
Imagem `mexico-<id>-<slug>.png` vs app lendo `{id}.webp`.
Nove worktrees clonadas da Espanha com o conteúdo nunca trocado.

Os três têm a mesma forma: **o artefato existe, o build fica verde, e quem consome pede
outro caminho.** E em nenhum deles havia um teste que cruzasse as duas camadas.

Não é sugestão de escopo — é observação para quando alguém decidir onde vale investir
verificação. Um único teste que abra o que o app pede e confirme que existe no disco teria
pego os três.

### Começando agora

`a01` em diante. Aviso aqui quando fechar o lote das 22.
