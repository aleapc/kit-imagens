#!/usr/bin/env node
// BANCO DE IMAGENS POR DESTINO — gera pedidos ANTECIPADOS para o Mac.
//
//   node tools/banco-destinos.mjs
//
// A estrutura das 36 situações de sobrevivência é UNIVERSAL (chegar, pedir,
// pagar, táxi, ler a sala). Então escrevemos 36 CENAS VISUAIS universais UMA vez
// (scratchpad/cenas-universais.json) e as instanciamos em cada AMBIENTE de
// destino. O Mac renderiza a mesma cena em cada cidade. É o banco que o dono
// pediu: usar o crédito de imagem enquanto está fresco, acumular para uso
// posterior — as imagens ficam em entregues/<destino>/ até o curso existir.
//
// SÓ destinos de gramática europeia/mediterrânea (café/balcão/praça/estação
// transferem). EUA/México/Japão têm gramática própria (diner/izakaya) e ganham
// um conjunto de cenas separado quando o curso se aproximar — não aqui.

import { readFileSync, writeFileSync, mkdirSync } from 'node:fs';
import { join, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';

const bridge = join(dirname(fileURLToPath(import.meta.url)), '..');
const CENAS = join(dirname(fileURLToPath(import.meta.url)), 'cenas-universais.json');

// Ordem de valor do mapa de corredores: França (35,2M) > Itália (13,4) > Türkiye
// (11,0) > Grécia (5,4) > Alemanha (especulativo — não vira SKU no ranking, mas
// o dono pediu e o crédito seria ocioso; banco barato).
const DESTINOS = {
  'destino-franca':   'França (Paris, Lyon, Nice, Provence): café de bairro com zinc e terrasse, boulangerie, mercado a céu aberto, estação de metrô, praça de vila com plátanos.',
  'destino-italia':   'Itália (Roma, Florença, Veneza, Nápoles): bar de espresso ao balcão, trattoria, piazza com fonte, mercato coberto, ruela com roupa no varal.',
  'destino-turquia':  'Türkiye (Istambul, Capadócia, Antália): café com copo-tulipa de chá, grande bazar coberto, balsa no Bósforo, praça com mesquita ao fundo, barraca de comida de rua.',
  'destino-grecia':   'Grécia (Atenas, ilhas do Egeu): taverna à beira-mar, kafeneio, praça com mesas sob toldo, porto com balsa, ruela caiada de branco e azul.',
  'destino-alemanha': 'Alemanha (Berlim, Munique, Hamburgo): Café/Konditorei, Biergarten de mesas compridas, mercado ao ar livre, estação de U-Bahn, praça da Altstadt com casas enxaimel.',
};

const ESTILO =
  'Pintura digital cinematográfica, luz de fim de tarde (golden hour), cores quentes e saturadas, ' +
  'atmosfera acolhedora e convidativa, estilo das ilustrações de viagem. Sem nenhum texto, letra, ' +
  'número ou logotipo na imagem. Enquadramento horizontal 3:2 (1200×800), profundidade de campo ' +
  'suave, composição com um ponto focal claro. Pessoas de costas, de perfil ou a média distância — ' +
  'nenhum rosto reconhecível em primeiro plano.';

const cenas = JSON.parse(readFileSync(CENAS, 'utf8'));
if (!Array.isArray(cenas) || cenas.length !== 36) {
  console.error(`esperava 36 cenas universais em ${CENAS}, achei ${Array.isArray(cenas) ? cenas.length : 'não-array'}`);
  process.exit(1);
}

mkdirSync(join(bridge, 'pedidos'), { recursive: true });
const feitos = [];
for (const [curso, ambiente] of Object.entries(DESTINOS)) {
  mkdirSync(join(bridge, 'entregues', curso), { recursive: true });
  const spec = {
    curso,
    banco: true,
    ambiente,
    estilo: ESTILO,
    entregar_em: `entregues/${curso}/`,
    arquivos: cenas.map((c) => ({
      id: c.slot.toLowerCase(),
      arquivo: `${c.slot.toLowerCase()}.webp`,
      titulo: c.slot,
      cena: String(c.cena).replace(/\s+/g, ' ').trim(),
    })),
  };
  writeFileSync(join(bridge, 'pedidos', `${curso}.json`), JSON.stringify(spec, null, 2) + '\n');

  let md = `# Banco de imagens — ${curso}\n\n`;
  md += `**${spec.arquivos.length} imagens.** Ambiente: ${ambiente}\n\n`;
  md += `BANCO ANTECIPADO: cenas universais das 36 situações, instanciadas neste destino. Entregar em \`entregues/${curso}/\`, id exato \`.webp\`, 1200×800, sem texto.\n\n`;
  md += `## Bloco de estilo — cole ANTES de cada prompt\n\n> ${ESTILO} Ambiente: ${ambiente}\n\n## As imagens\n\n`;
  for (const a of spec.arquivos) md += `### ${a.id}.webp\n**${a.titulo}**\n\n${a.cena}\n\n`;
  writeFileSync(join(bridge, 'pedidos', `${curso}.md`), md);
  feitos.push(`${curso} (${spec.arquivos.length})`);
}
console.log('pedidos de banco escritos:\n  ' + feitos.join('\n  '));
console.log('\ncomite e empurre o repo-ponte para o Mac começar.');
