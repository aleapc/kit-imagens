# Estado da fila — atualizado pelo PC (sessão [guias]) · 2026-08-20

> A revisão anterior (05/ago) descrevia a fila dos CURSOS e não conhecia os pedidos
> novos de GUIA DE CIDADE. Esta é a fila real agora.

## 🎯 Fila ATIVA de imagens (o que produzir, em ordem)

| # | pedido | pasta de entrega | imagens | estado | prioridade |
|---|---|---|---:|---|---|
| 1 | `14-guia-istambul` | `entregues/guia-istambul/` | **123** | pasta vazia | **produzir agora** |
| 2 | `15-guia-paris` | `entregues/guia-paris/` | **111** | pasta vazia | depois de Istambul |
| 3 | `16-guia-londres` | `entregues/guia-londres/` | **114** | pasta vazia | depois de Paris |
| 4 | `17-guia-roma` | `entregues/guia-roma/` | **108** | pasta vazia | depois de Londres |
| 5 | `18-guia-bangkok` | `entregues/guia-bangkok/` | **108** | pasta vazia | depois de Roma |
| 6 | `19-guia-singapura` | `entregues/guia-singapura/` | **108** | pasta vazia | depois de Bangkok |
| 7 | `20-guia-antalya` | `entregues/guia-antalya/` | **107** | pasta vazia | depois de Singapura |
| 8 | `21-guia-pattaya` | `entregues/guia-pattaya/` | **108** | pasta vazia | depois de Antalya |
| 9 | `22-guia-novayork` | `entregues/guia-novayork/` | **108** | pasta vazia | depois de Pattaya |
| 10 | `23-guia-lasvegas` | `entregues/guia-lasvegas/` | **108** | pasta vazia | depois de Nova York |
| 11 | `24-guia-edirne` | `entregues/guia-edirne/` | **71** | pasta vazia | depois de Las Vegas |
| 12 | `25-guia-miami` | `entregues/guia-miami/` | **108** | pasta vazia | depois de Edirne |
| 13 | `26-guia-losangeles` | `entregues/guia-losangeles/` | **109** | pasta vazia | depois de Miami |
| 14 | `27-guia-orlando` | `entregues/guia-orlando/` | **108** | pasta vazia | depois de Los Angeles |
| 15 | `28-guia-bodrum` | `entregues/guia-bodrum/` | **107** | pasta vazia | depois de Orlando |
| 16 | `29-guia-sydney` | `entregues/guia-sydney/` | **108** | pasta vazia | depois de Bodrum |
| 17 | `30-guia-melbourne` | `entregues/guia-melbourne/` | **107** | pasta vazia | depois de Sydney |
| 18 | `31-guia-saofrancisco` | `entregues/guia-saofrancisco/` | **107** | pasta vazia | depois de Melbourne |
| 19 | `32-guia-edimburgo` | `entregues/guia-edimburgo/` | **105** | pasta vazia | depois de San Francisco |
| 20 | `33-guia-okinawa` | `entregues/guia-okinawa/` | **106** | pasta vazia | depois de Edimburgo |
| 21 | `34-guia-izmir` | `entregues/guia-izmir/` | **103** | pasta vazia | depois de Okinawa |
| 17 | `30-guia-melbourne` | `entregues/guia-melbourne/` | **107** | pasta vazia | depois de Sydney |

Nada mais está pendente de imagem. A sessão [cursos] avisou no `guias-mapa/COORDENACAO.md`
que **não tem pedido de imagem no momento** (KO/ZH→Japão reusam 100% o acervo
`entregues/destino-japao/` já fechado — zero arte nova). Os pedidos antigos de curso
(`destino-*`, `mexico-regen`) já foram entregues ou não são prioridade.

## ⚠️ FORMATO NOVO — guia de cidade ≠ curso

Os pedidos `guia-*` **não usam a grade de 36 cenas** dos cursos (b01–b18 / i01–i10 / a01–a08).
São **guias de cidade**: cada `id` é um **LOCAL específico e real** (`ist_santa_sofia.webp`,
`par_tour_eiffel.webp`…), e **cada um tem o seu próprio prompt** no `.md`, descrevendo
aquele monumento/restaurante/mercado. Não há bloco de estilo único aplicado a cenas
genéricas — há um bloco de estilo geral + um prompt por local.

- **Entregar:** `<id>.webp`, **1200×800** (3:2 horizontal), na pasta indicada em `pasta`.
- **Contrato / completude:** todo `id` de `pedidos/<n>.json` (campo `ids`) existe em `pasta`.
  Idempotente: só gerar o que falta.
- **Texto (mesma disciplina do Japão):** o bloco de estilo de cada `.md` manda deixar
  **ilegível** toda placa/letreiro/cardápio/menu — Istambul tem caligrafia árabe
  (decorativa, não-legível), Paris/Londres têm placas de loja, pub, café e menu. Nada de
  pseudo-escrita; nenhuma bandeira, nenhum brasão. Onde a cena pedir superfície escrita e o
  prompt não ditar as palavras, deixe fora de foco / em ângulo / cortada / encoberta.

## Recomendação de rota

Comece por **guia-istambul** (123), depois **guia-paris** (111). Os dois guias já estão
PUBLICADOS e no ar (aleapc.github.io/guia-istambul e /guia-paris) — a arte é a última
camada que falta; enquanto não chega, o app mostra gradiente+emoji, então cada `.webp`
que você entrega já melhora um app vivo. Sem pressa de lote: empurre em blocos, o PC
recolhe parcial.

> Dúvida ou bloqueio? Escreva em `ALO-DO-MAC.md` (ou um `PERGUNTA-DO-MAC-<data>.md`) e
> `git push` — a sessão [guias] do PC lê no próximo pull.
