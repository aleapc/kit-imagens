# Método de operação da estação Mac — validado em 2026-08-04

Este documento existe para que qualquer sessão futura retome a produção sem repetir os
erros já cometidos. Leia junto com `CRITERIO-TEXTO.md` e `AUDITORIA-ZERO-TEXTO.md`.

## Descobrir a fila (não precisa perguntar a ninguém)

```bash
cd ~/kit-imagens && git pull -q
for j in pedidos/*.json; do
  c=$(jq -r .curso "$j"); t=$(jq '.arquivos|length' "$j")
  h=$(ls entregues/$c/* 2>/dev/null | grep -cE '\.(webp|png)$')
  [ "$h" -lt "$t" ] && echo "PENDENTE $c: $h/$t"
done
```

A próxima imagem de um curso é o primeiro id de `.arquivos[]` sem arquivo correspondente
em `entregues/<curso>/`.

## Como operar o ChatGPT

**Use o Chrome via extensão Claude in Chrome.** Não use AppleScript com `keystroke`: sem
enxergar a tela não há como confirmar onde o texto cai, e isso já colou prompts na janela
errada. Não há computer-use de desktop disponível.

Ciclo por imagem:

1. Clicar no campo de mensagem, `type` o prompt completo
2. Localizar o botão com `find` ("send prompt button") e clicar **por `ref`**, não por
   coordenada — a janela redimensiona e coordenada quebra
3. Esperar ~60–90 s (a geração leva isso)
4. Screenshot para **conferir visualmente** antes de aceitar
5. Extrair via canvas + clipboard (abaixo)
6. Salvar, checar md5 duplicado, commitar

**Abra um chat novo a cada ~30 imagens.** Um chat com 340+ imagens trava o renderer do
Chrome: aparecem timeouts de CDP e a aba fecha sozinha. Foi o gargalo da primeira metade
desta sessão e sumiu depois da troca.

## Extração

Clicar antes numa área neutra da página (o clipboard exige documento focado), depois:

```js
const gen=[...document.querySelectorAll('main img')]
  .filter(i=>i.alt&&i.alt.startsWith('Generated')&&i.naturalWidth>500);
const img=gen[gen.length-1];
const c=document.createElement('canvas');
c.width=1200;c.height=800;                        // bancos destino-* ; use 1536x1024 p/ mexico
c.getContext('2d').drawImage(img,0,0,1200,800);
const b64=c.toDataURL('image/webp',0.92).split(',')[1];   // png p/ mexico
await navigator.clipboard.writeText('KITIMG:'+b64);
```

E no terminal:

```bash
CLIP=$(pbpaste)
[[ "$CLIP" == KITIMG:* ]] && echo "$CLIP" | sed 's/^KITIMG://' | base64 -d > <destino>
```

O prefixo `KITIMG:` é a guarda contra clipboard clobbered por outra sessão. Se não
estiver lá, **não salve**.

Localizar a imagem certa pelo `alt` (`Generated image: <título>`) é mais robusto que
"a última do DOM" — o DOM carrega o histórico de forma imprevisível.

## Formatos

| acervo | dimensão | extensão | nome |
|---|---|---|---|
| `destino-*` | 1200×800 | `.webp` q=0.92 | `<id>.webp` |
| `mexico-regen` | 1536×1024 | `.png` | conforme campo `arquivo` do json |

## A trava anti-pseudo-texto (obrigatória)

Acrescente ao prompt, depois do bloco de `estilo` e antes da cena:

> REGRA DE TEXTO: nenhum texto inventado, nenhuma letra ilegível, nenhum pseudo-texto.

E **nomeie o objeto** que a cena traz. A proibição genérica não segura; nomear segura:

| objeto | o que escrever |
|---|---|
| painel de aeroporto/estação | "faixas luminosas e manchas de cor fora de foco, SEM linha de caracteres discernível" |
| garrafas | "LISAS, vidro colorido puro, sem papel, sem escrita e sem selo" |
| conta, recibo, comanda | "retângulo de papel LISO e em branco, sem linha impressa" |
| lousa / cardápio | "MUITO desfocada, lida apenas como superfície escura" |
| crachá | "cordão liso no pescoço, SEM crachá pendurado" |
| farda / uniforme | "lisa, sem emblema nem distintivo" |
| embalagem, caixa de remédio | "LISAS e sem rótulo" |
| táxi | "liso, sem letreiro no teto, sem numeração" |
| rua / fachada | "sem placa, letreiro, cartaz ou bandeira" |

Se a cena original já diz "desfocado", **reforce** — o gerador ignora e entrega legível.

## Conferência antes de aceitar (não pule)

Olhe a imagem e verifique:
- pseudo-texto em qualquer superfície
- bandeira nacional (nunca; monumento **pode** — a Torre Eiffel está aprovada em `franca/b06`)
- brasão em farda, crachá legível, logotipo de marca
- a ação da cena está correta (foi assim que se pegou a catraca proibida na `mexico b09`
  e a mão apontando para a comida na `mexico b12`)

Depois de salvar: `md5 -q entregues/<curso>/*.webp | sort | uniq -d` deve sair vazio.

## Commit

Uma imagem por commit, com push imediato — se a sessão cair, nada se perde e o PC já vê:

```bash
git add entregues/<curso>/ && \
git -c user.name=aleapc -c user.email=aleapc@gmail.com commit -q -m "imagens <curso>: +1 (<id>)" && \
git pull --rebase -q && git push -q
```

## Ritmo real

~4–5 min por imagem, contando geração, conferência e commit. Não prometa mais que isso.
