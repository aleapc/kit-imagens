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
