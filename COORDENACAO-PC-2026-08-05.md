# Coordenação do PC para o Mac — 2026-08-05

Bem-vindo de volta. Enquanto o listener esteve fora, o lado do conteúdo andou muito, e
isso **reordenou a sua fila**. Leia antes de pegar o próximo pedido.

## O que aconteceu

Fecharam dois cursos de Itália, ambos 36/36 partes, com áudio gravado e build verde:

- `curso-italia-en` — 1.082 mp3
- `curso-italia-de` — 1.082 mp3, e é **o maior corredor individual da Europa** (Alemanha → Itália, 14,1 M de chegadas/ano)

Os dois estão prontos para publicar e **estão travados em você**: hoje mostram
**fotografia da Espanha em 17 dos 36 slots**, e 3 slots não têm imagem nenhuma.

## O que fazer primeiro

**`pedidos/8-destino-italia-parte-2.json` — 20 imagens.**

Cada slot traz dois campos, e a diferença importa:

- **`cena`** — a descrição visual, escrita para a câmera. **É essa que você usa como prompt.**
- `_cena_do_episodio` — a cena original do episódio, que descreve o que o **aluno sente**.
  Está ali só como contexto, para você entender o que a imagem precisa evocar. **Não use
  como prompt:** ela descreve estado interno, não enquadramento.

Depois dele, `pedidos/7-mexico-avancado.json` (7 imagens, A02–A08). México também está
completo e esperando.

## O que sai da frente da fila

**Grécia e Turquia.** A Grécia já tem 31 imagens entregues e **não existe curso de
Grécia** — as worktrees continuam clones intocados da Espanha, com zero mp3. Turquia
idem. Alemanha segue estacionada, sem curso nem previsão.

O trabalho não se perdeu; ele só vira produto quando houver curso, e enquanto isso há dois
cursos completos parados esperando arte. Se sobrar capacidade depois do 8 e do 7, aí sim
volte para a Grécia.

## O princípio, porque ele vai se repetir

Arte é **ativo de destino**, não de origem. As 20 imagens do pedido 8 servem os dois
cursos de Itália sem nenhuma variação — o `tools/sincroniza-instalacao.mjs` já instala
`destino-italia` nas duas worktrees.

Foi exatamente esse princípio que permitiu ao curso alemão reaproveitar os **551 clipes de
fala italiana** do curso inglês **a custo zero de crédito**: as frases-alvo, as vozes e as
chaves de áudio são idênticas entre SKUs do mesmo destino, então só a narração alemã foi
gravada. Vale ter isso em mente quando França e Grécia entrarem — cada banco de destino é
pago uma vez e serve todas as origens.

Consequência para a fila: **prioridade acompanha conteúdo pronto, não ordem de chegada.**

## Sobre texto

Vale `CRITERIO-TEXTO.md`, com um reforço. Texto pode aparecer **na língua do destino**.
Num banco `destino-italia`, placa em espanhol é defeito — e é um defeito que passou
despercebido antes, porque os cursos serviam arte da Espanha e ninguém tinha olhado. Na
dúvida sobre a grafia italiana, prefira a superfície de costas, fora de foco ou sem
escrita: errar a língua é pior do que não ter texto.

## Como me avisar

Escreva em `entregues/destino-italia/` e dê push. Eu rodo
`node tools/sincroniza-instalacao.mjs --aplicar`, que instala nos dois worktrees de Itália
de uma vez, e atualizo o `STATUS.md`.

Se algum slot do pedido 8 ficar ambíguo — cena que não fecha, ou dúvida sobre o que a
imagem deve mostrar — escreva a dúvida em `PERGUNTA-DO-MAC.md` e dê push, em vez de
adivinhar. Eu tenho os episódios completos aqui e respondo com a passagem exata.
