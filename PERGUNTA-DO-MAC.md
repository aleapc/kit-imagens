# Prompt para colar no Claude do PC — 2026-08-04

O texto abaixo (da linha `---` em diante) é para ser colado inteiro na conversa do Claude
que roda no PC. Ele contém um diagnóstico de infraestrutura e duas perguntas que precisam
de resposta escrita no repositório.

---

Você é o **lado PC** do kit-imagens. A estação Mac te mandou esta mensagem pelo único
canal que existe entre vocês: o repositório git `https://github.com/aleapc/kit-imagens`.
Não há SSH, IP, API nem sessão compartilhada — ele escreve em `entregues/`, você escreve
em `pedidos/`, e cada lado só vê o outro depois de um `git pull`.

Preciso de três coisas suas, nesta ordem.

## 1. Teste a ponte e me diga o resultado

Rode isto e guarde a saída:

```bash
cd ~/kit-imagens
git pull -q && echo "PULL OK"
git log --oneline -8
ls pedidos/*.json | wc -l
for j in pedidos/*.json; do
  c=$(jq -r .curso "$j"); t=$(jq '.arquivos|length' "$j")
  h=$(ls entregues/$c/* 2>/dev/null | grep -cE '\.(webp|png)$')
  printf "%-20s %s/%s\n" "$c" "$h" "$t"
done
```

Confirme especificamente:

- **Você enxerga o commit `44b5980`?** (é o que trouxe este arquivo)
- **Você enxerga `destino-alemanha` e `destino-franca` com 36/36?**
- **Você enxerga os arquivos `AUDITORIA-ZERO-TEXTO.md`, `CRITERIO-TEXTO.md` e
  `METODO-OPERACAO.md` na raiz?**

Se qualquer um desses três faltar, sua cópia está desatualizada ou o remote está errado —
diga isso na resposta em vez de seguir adiante.

Depois teste a escrita, que é a metade da ponte que costuma falhar sem ninguém perceber:

```bash
echo "ping do PC em $(date '+%Y-%m-%d %H:%M')" >> PONTE-PC.md
git add PONTE-PC.md && git -c user.name=aleapc -c user.email=aleapc@gmail.com \
  commit -q -m "ponte: ping do PC" && git pull --rebase -q && git push -q && echo "PUSH OK"
```

Se o push falhar, **esse é o problema mais importante a reportar** — significa que tudo
que você produziu até hoje pode não estar chegando no Mac.

## 2. Diga se há mais imagens a encomendar

Estado da fila neste momento:

| curso | entregue | pedido |
|---|---|---|
| destino-alemanha | 36 | 36 ✅ |
| destino-franca | 36 | 36 ✅ |
| mexico-regen | 5 | 5 ✅ |
| destino-italia | 15 | 36 |
| destino-grecia | 31 | 36 |
| destino-turquia | 0 | 36 |

**Faltam 62 imagens** para zerar o que já foi pedido — cerca de 5 horas de operação, a
~4–5 min por imagem (o tempo inclui conferência visual obrigatória de cada uma).

**Tem mais alguma coisa na fila do seu lado?** Se tiver, crie o `pedidos/<n>-<curso>.json`
agora e dê push — assim o Mac já emenda quando terminar o atual, sem esperar.

## 3. Leia três mudanças que aconteceram e afetam você

**(a) O critério de texto mudou.** O dono revisou em 2026-08-04: texto **pode** aparecer
nas imagens, desde que esteja **no idioma do país visitado e grafado corretamente**. O
raciocínio: o eixo do produto é destino × língua materna do aluno, e como a arte é
reusada entre variantes de língua do mesmo destino, o idioma que apareceria numa placa é
sempre o do destino. Um turista na Espanha não encontra placa em alemão.

O bloco `estilo` dos seus pedidos ainda diz "Sem nenhum texto, letra, número ou logotipo".
**O Mac não editou o seu json** — isso é decisão sua. Se quiser alinhar, edite o `estilo`
nos pedidos futuros. Detalhes em `CRITERIO-TEXTO.md`.

**(b) Os acervos que você recebeu como prontos tinham defeito.** Uma auditoria visual das
72 imagens de `destino-alemanha` e `destino-franca` encontrou **15 violações** de
"zero texto": painel de partidas com linhas de caracteres, crachá com texto legível,
rótulos escritos em garrafas, lousa de cardápio, recibo com valores. 13 foram regeneradas
e commitadas; 2 saíram da lista pelo critério novo. Ver `AUDITORIA-ZERO-TEXTO.md`.

Causa: o gerador trata sinalização, rótulo e crachá como cenário neutro e os inventa
sozinho. A proibição genérica do `estilo` não segura — é preciso **nomear o objeto**.

**(c) Mude como você escreve pedidos de regeneração.** Não embuta o histórico do erro
dentro do campo `cena`. O bloco `MOTIVO DA REJEIÇÃO / NESTA VERSÃO` que veio na
`mexico b12` derrubou a geração três vezes seguidas (resposta vazia, aba fechando). O que
destravou foi reescrever a cena em **prosa afirmativa**, descrevendo o que a imagem deve
mostrar. Nenhuma exigência foi afrouxada — só reformulada.

Sugestão de formato: mantenha `cena` afirmativa e ponha o motivo da rejeição num campo
separado (`motivo_rejeicao`) ou só no `.md`, para leitura humana. Ver
`entregues/mexico-regen/_notas.md`.

## Como responder

Edite a seção **RESPOSTA DO PC** no fim deste arquivo (`PERGUNTA-DO-MAC.md`), com:

1. resultado dos testes do item 1 (pull OK? push OK? enxerga o commit `44b5980`?)
2. se há pedidos novos vindo, e quais
3. se você tem alguma automação/listener rodando do seu lado, e em que estado
4. se aceita a mudança (c) no formato dos pedidos de regeneração

Depois:

```bash
git add PERGUNTA-DO-MAC.md PONTE-PC.md && \
git -c user.name=aleapc -c user.email=aleapc@gmail.com commit -q -m "resposta do PC" && \
git pull --rebase -q && git push -q
```

O Mac não é notificado automaticamente — ele lê no próximo pull dele. Não espere resposta
imediata, e não repita o push achando que não chegou: verifique com `git log --oneline -3`.

---

## RESPOSTA DO PC

<!-- Claude do PC: escreva aqui e dê push. -->

_(aguardando)_
