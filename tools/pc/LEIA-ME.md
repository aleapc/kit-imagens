# Ferramentas do lado PC — do fim da entrega até o site no ar

Estes dois scripts fecham o ciclo que a ponte abre. Vivem aqui, e não no
repositório de cada curso, porque descrevem a coordenação entre as duas
máquinas — que é o assunto deste repositório.

## `fecha-destino.sh <destino> [--seco]`

Da entrega de arte até o site publicado, num comando. A sequência é sempre a
mesma e vinha sendo feita à mão:

1. `git pull` na ponte e conta o que foi entregue contra o `pedidos/*.json`.
   **Se faltar uma imagem, ele sai sem tocar em nada** — meio destino instalado
   é pior que nenhum, porque mistura dois países no mesmo curso.
2. Instala nos SKUs daquele destino. **Todos de uma vez**: arte é ativo de
   destino, e EN→Türkiye e DE→Türkiye mostram a mesma Türkiye.
3. Roda `valida-arte.mjs --estrito`. O portão decide, não o operador.
4. Constrói, commita, empurra a `main`, publica a `gh-pages`.
5. **Abre o site e lê o `<title>`.** Este passo não é opcional e não é zelo: em
   2026-08-05 quatro cursos foram publicados e a aba do navegador dizia o nome
   do país errado, porque a casca do app ainda era a do SKU de origem. Declarar
   publicado sem abrir a página é como declarar build verde sem rodar o portão.
   O `?cb=` no fim da URL existe porque o CDN devolve a versão velha por um
   tempo e engana quem confere rápido demais.

`--seco` faz tudo até o passo 3 e para. Use antes de fechar um destino pela
primeira vez.

## `publica.sh <curso>`

Publica um curso só. Roda `npm run publicar` antes — que inclui
`valida-arte --estrito` — e **recusa** se o curso estiver servindo arte de outro
destino. Empurra o `build/` para a `gh-pages` como branch órfã, porque o build
tem ~1.400 mp3 e mantê-lo na `main` dobraria o repositório a cada deploy.

## O que ainda é manual, de propósito

Atualizar o Mapa. A cobertura e os cards são texto editorial, não derivam
mecanicamente do disco, e escrever isso à mão é o momento em que se olha o
número e se pergunta se ele faz sentido.
