# Ponto de retomada — estação Mac (kit-imagens)

**Atualizado: 2026-08-20** (pausa por queda de sessão do Chrome)

## Onde parei

Produzindo **guia-istambul** (123 imagens). **28/123 entregues, conferidas e no push.**

A imagem **29 (ist_cagaloglu_hamami)** teve o prompt enviado mas a aba do Chrome fechou
antes de renderizar — **refazer na retomada**. Nada foi perdido no disco.

### Por que pausei
A extensão do Chrome caiu no meio da operação e reconectou numa **aba deslogada** do
ChatGPT ("Log in / Sign up"). A sessão Pro (alex correa) precisa ser restabelecida —
**login é ação que o assistente não executa**. Para retomar: abrir o Chrome do Mac,
garantir que o ChatGPT está logado na conta Pro, e reconectar a extensão (switch_browser).

## Método provado (NÃO esquecer)

**Gerar SÓ pelo modo "+ → Create image"** — ver memória [[kit-imagens-modo-create-image]].
O campo de chat normal usa modelo "thinking" que ignora o prompt (gerou Rio de Janeiro no
lugar de Santa Sofia). O chip azul "Create image" força a ferramenta de imagem direta.

### Ciclo por imagem
1. Fechar editor (X, canto sup. esq.) → New chat → clicar "+" → "Create image"
2. Digitar prompt (bloco de estilo condensado + descrição do local do pedido 14) → Enter
3. Aguardar ~70-90s (modo "detailed" é lento; às vezes gera 2 variantes)
4. Clicar na imagem para abrir editor (resolução 1536×1024)
5. Conferir texto com zoom nas zonas de risco (bazares, lojas, mesquitas)
6. Extrair via canvas → clipboard `KITIMG:` → salvar 1200×800 webp q0.92 → md5 dedup → commit+push

### Extração (javascript_tool, await no topo, NÃO IIFE async)
```js
const imgs = [...document.querySelectorAll('img')].filter(i => i.naturalWidth >= 1200);
imgs.sort((a,b)=>b.naturalWidth*b.naturalHeight - a.naturalWidth*a.naturalHeight);
const img = imgs[0];
const c = document.createElement('canvas'); c.width=1200; c.height=800;
c.getContext('2d').drawImage(img,0,0,1200,800);
const b64 = c.toDataURL('image/webp',0.92).split(',')[1];
await navigator.clipboard.writeText('KITIMG:'+b64);
```

### Salvar+commit
```bash
CLIP=$(pbpaste)
f=entregues/guia-istambul/<id>.webp
echo "$CLIP" | sed 's/^KITIMG://' | base64 -d > "$f"
# verificar 1200x800, md5 dedup, então:
git add entregues/guia-istambul/ && git -c user.name=aleapc -c user.email=aleapc@gmail.com \
  commit -q -m "imagens guia-istambul: +1 (<id>)" && git pull --rebase -q && git push -q
```

## Fila restante (ordem do pedido 14, a partir de onde parei)

**Próxima: ist_cagaloglu_hamami** (refazer). Depois seguir a ordem do
`pedidos/14-guia-istambul.md`: ist_four_seasons_sultanahmet, ist_ibrahim_pasha_hotel,
ist_pera_muzesi, ist_istanbul_modern, ist_salt_galata, ist_kilic_ali_pasa_camii,
ist_mandabatmaz, ... até fechar 123. Depois **guia-paris (111)** pelo `pedidos/15-guia-paris.md`.

## 28 ids já entregues
ist_santa_sofia, ist_mesquita_azul, ist_topkapi, ist_cisterna_basilica, ist_grande_bazar,
ist_bazar_egipcio, ist_torre_galata, ist_istiklal, ist_dolmabahce, ist_ortakoy,
ist_torre_donzela, ist_cruzeiro_bosforo, ist_buyukada, ist_cemberlitas_hamami,
ist_karakoy_gulluoglu, ist_ciya_sofrasi, ist_kucuk_ayasofya, ist_sokollu_mehmet_pasa,
ist_hipodromo, ist_museu_arqueologico, ist_museu_mosaico_grande_palacio,
ist_museu_artes_turcas_islamicas, ist_arasta_bazaar, ist_sultanahmet_koftecisi,
ist_balikci_sabahattin, ist_deraliye, ist_set_ustu_cay_bahcesi,
ist_ayasofya_hurrem_sultan_hamami

## Coordenação com o PC
PC pediu Istambul primeiro (guias já no ar em aleapc.github.io; cada webp melhora o app
vivo). Entregas parciais OK. Grade 123/111 fechada. Dúvidas → escrever no repo.
