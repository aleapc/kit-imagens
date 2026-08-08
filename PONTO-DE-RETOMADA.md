# Ponto de retomada — 2026-08-07, fim do dia

Pausa combinada com o dono. Leia junto com `METODO-OPERACAO.md` (o como) e
`CRITERIO-TEXTO.md` (o critério).

## Estado do acervo

| curso | estado |
|---|---|
| destino-alemanha | 36/36 ✅ (PARADO — não há curso) |
| destino-franca | 36/36 ✅ |
| destino-grecia | 36/36 ✅ |
| destino-turquia | 36/36 ✅ (publicado pelo PC) |
| destino-italia | 36/36 ✅ (publicado pelo PC; ganhou de brinde o SKU curso-italia-nl) |
| destino-mexico | 22/22 ✅ (zero-texto estrito) |
| mexico-regen | 5/5 ✅ |
| **destino-portugal** | **33/36 ← retomar aqui** |

## O que falta: 3 imagens no Portugal

`a06, a07, a08` — cenas em `pedidos/10-destino-portugal.md`:
- **a06** — festa que toma a rua estreita ao anoitecer, luzes penduradas, cortejo, viajante
  encostado à parede. (Trava: luzes só como lâmpadas SEM letra, nenhuma faixa escrita.)
- **a07** — anfitrião pousa a mão nas costas do viajante junto à porta, gesto de "é hora".
- **a08** — abraço de despedida numa esquina ao fim da tarde, mala ao lado, luz dourada.

Blocos B (b01–b18) e I (i01–i10), mais a01–a05, já fechados e conferidos hoje.

## Critério do Portugal

Padrão `destino-*` (NÃO zero-texto estrito): texto no idioma do destino seria permitido,
mas continuo evitando pseudo-texto com a trava de nomear objeto. Ambiente: azulejo azul e
branco, elétrico amarelo, calçada portuguesa, pastelaria com balcão de mármore, esplanada,
mercado de peixe. O azulejo é decorativo (padrão floral, sem letra) — sempre conferir.

## Ao fechar (36/36)

Avisar o PC em `AVISO-ACERVOS-FECHADOS.md` (já lista turquia/itália/mexico) que Portugal
fechou e pode rodar `fecha-destino.sh`. Com isso, TODA a fila do PC estará entregue.

## Aprendizado novo de hoje

Cena de guichê de fronteira (b05): o gerador põe o agente de rosto frontal e o ChatGPT
aplica um blur pixelado feio sobre o rosto. Correção: pedir o agente **de perfil ou de
cabeça baixa**, nunca frontal — aí não há rosto a borrar. Vale para qualquer cena com uma
segunda pessoa atrás de balcão/guichê olhando para a câmera.

## Infra

- `monitor-ponte.sh` DESLIGADO para a noite (religar ao retomar:
  `cd ~/kit-imagens && nohup ./monitor-ponte.sh >/dev/null 2>&1 &`).
- Chat do ChatGPT em uso: `6a769092-12b8-83e9-bc23-ea61e255ec35`. Abrir chat novo ao retomar.
- Nada pendente de resposta minha ao PC. Última coordenação: `RESPOSTA-DO-PC-2.md`.
- Pendência do dono: os 15 duvidosos de `AUDITORIA-ZERO-TEXTO.md` (não bloqueiam nada).
