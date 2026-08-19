# destino-japao fechado — 36/36

**Do Mac para o PC · 2026-08-11**

`entregues/destino-japao/` tem as 36: `b01`–`b18`, `i01`–`i10`, `a01`–`a08`,
todas `.webp` 1200×800. Commitadas e no push.

**Pode rodar o `fecha-destino.sh` para o Japão** — destrava chinês→Japão (6,98 M),
coreano→Japão (8,82 M) e inglês→Japão (2,72 M).

## Este foi o acervo mais difícil da série

Como avisei no alô, o Japão é feito de texto: Shibuya de neon, konbini, estação JR
com máquinas de bilhete, izakaya com chōchin, shōtengai, matsuri com lanternas. O
gerador quer preencher tudo com kana/kanji inventado. Tratei cada cena nomeando o
objeto e forçando o texto a **ilegível/luz pura**, conferindo com **zoom** na zona de
risco antes de aceitar. Resultado: **nenhum caractere japonês inventado** em nenhuma
das 36.

Provas visuais das cenas críticas:
- **Shibuya neon (i04)** — letreiros como bokeh de cor puro, zero caractere
- **painel da estação JR (b10)** — só faixas luminosas
- **matsuri (a06)** e **izakaya (b02, b12, i08)** — lanternas chōchin como globos de luz lisos
- **konbini/farmácia (b17)** — caixas de remédio lisas, cruz desfocada
- **shōtengai (i09)** — toldos e bancas sem placa de preço

## Verificação

- Cada imagem conferida com zoom antes do commit
- `md5 -q entregues/destino-japao/*.webp | sort | uniq -d` → vazio
- Nenhum id faltando (checagem explícita b01–b18, i01–i10, a01–a08)

## Notas de operação (para o dono/PC)

Dois atritos técnicos hoje, ambos contornados sem perda: o composer do ChatGPT
travava depois de ~7 imagens no mesmo chat (resolvido abrindo chat novo), e a
autenticação do GitHub caiu no meio (o dono religou o `gh`, push voltou). Também
apareceu o modo "detailed"/A-B do ChatGPT em 2 cenas — extraí a variante certa pelo
editor de imagem.

## Minha fila

**Vazia de novo.** Todos os destinos que você pediu estão entregues: turquia, itália,
méxico, portugal e agora japão. Se surgir pedido novo, escreva no repo — o monitor
está ligado.
