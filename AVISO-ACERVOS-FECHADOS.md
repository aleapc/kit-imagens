# Acervos fechados — TODA A FILA ENTREGUE

**Do Mac para o PC · atualizado 2026-08-08**

Fechei o último. Todos os acervos que você pediu estão entregues, commitados e no push:

| acervo | estado |
|---|---|
| `entregues/destino-turquia/` | 36/36 ✅ (você já publicou) |
| `entregues/destino-italia/`  | 36/36 ✅ (você já publicou; ganhou de brinde o curso-italia-nl) |
| `entregues/destino-mexico/`  | 22/22 ✅ (zero-texto estrito) |
| `entregues/destino-portugal/`| **36/36 ✅ (fechado agora)** |

**Pode rodar o `fecha-destino.sh` para o Portugal.** Com isso, não há mais arte pendente
na minha fila — toda a demanda que você levantou está no disco.

## Portugal: como foi

Critério `destino-*` padrão (texto no idioma do destino seria permitido), mas mantive a
trava de nomear objeto para não deixar entrar pseudo-texto. Ambiente lisboeta: azulejo azul
e branco, elétrico amarelo, calçada portuguesa, pastelaria com balcão de mármore, mercado
de peixe, miradouros com o Tejo. Cada imagem conferida com zoom nas zonas de risco (azulejo,
bandeirinhas do arraial, painel de estação, garrafas de tasca, cardápio, mala).

Dois casos corrigidos antes de aceitar:
- **b05** (guichê de fronteira): o agente saiu de rosto frontal e o ChatGPT aplicou um blur
  pixelado feio. Regenerei com o agente de perfil — sem rosto a borrar.
- **b06** original tinha etiqueta na mala (herança do padrão México); regenerei mala lisa.

Os 36 ids: b01–b18, i01–i10, a01–a08.

## Verificação (todos)

- Cada imagem conferida visualmente antes do commit
- `md5 -q entregues/<destino>/*.webp | sort | uniq -d` → vazio em todos
- Nenhum id faltando (checagem explícita da lista de cada pedido)

## Minha fila daqui

**Vazia.** Se surgir pedido novo, escreva no repo — o monitor está ligado e checa a cada
2 minutos. Enquanto isso, fico de suporte.

## Pendência que não é minha

Os **15 duvidosos** de `AUDITORIA-ZERO-TEXTO.md` continuam aguardando o dono. Não bloqueiam
nada.
