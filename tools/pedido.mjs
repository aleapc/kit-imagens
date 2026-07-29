#!/usr/bin/env node
// GERA UM PEDIDO DE IMAGENS a partir do código de um curso.
//
//   node tools/pedido.mjs <curso>
//   ex.: node tools/pedido.mjs curso-espanha
//
// Roda no PC. Lê os episódios do curso em D:/dev/_projects/<curso>, descobre
// quais cards ainda não têm imagem, e escreve dois arquivos no repo-ponte:
//
//   pedidos/<curso>.md         → o briefing legível, para o Claude do Mac colar
//   pedidos/<curso>.json       → a lista MÁQUINA de arquivos esperados
//
// O .json é o contrato entre os dois lados: "o pedido está pronto" ⟺ todo id
// listado existe em entregues/<curso>/. Sem flag, sem status separado — o próprio
// disco responde. Isso torna o processo idempotente: se o Mac cair no meio, ele
// retoma só o que falta, e nenhum dos dois lados precisa lembrar de nada.

import { readFileSync, writeFileSync, readdirSync, existsSync, mkdirSync } from 'node:fs';
import { join, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';

const curso = process.argv[2];
if (!curso) {
  console.error('uso: node tools/pedido.mjs <curso>   (ex.: curso-espanha)');
  process.exit(1);
}

const bridge = join(dirname(fileURLToPath(import.meta.url)), '..');
const cursoDir = `D:/dev/_projects/${curso}`;
const courseCode = join(cursoDir, 'src', 'lib', 'course');
if (!existsSync(courseCode)) {
  console.error(`não achei ${courseCode} — o curso existe?`);
  process.exit(1);
}

// ── ambiente do destino, por curso ──────────────────────────────────────────
// O bloco de estilo é IDÊNTICO entre cursos; só o ambiente muda. É o que mantém
// as ~600 imagens parecendo uma família só.
const AMBIENTE = {
  'curso-espanha': 'Espanha peninsular (Madri, Barcelona, Sevilha, Valência, San Sebastián): bar de bairro, mercado, metrô, praça.',
  'curso-espanha-de': 'Espanha peninsular (Madri, Barcelona, Sevilha, Valência, San Sebastián): bar de bairro, mercado, metrô, praça.',
  'curso-espanha-fr': 'Espanha peninsular (Madri, Barcelona, Sevilha, Valência, San Sebastián): bar de bairro, mercado, metrô, praça.',
  'curso-espanol': 'rioplatense (Montevidéu, Colonia, Buenos Aires).',
  'curso-mandarim': 'China urbana (Xangai, Pequim, Chengdu): rua movimentada, mercado, metrô, casa de chá.',
  'curso-tailandes': 'Tailândia (Bangkok, Chiang Mai): mercado noturno, templo, tuk-tuk, barraca de comida de rua.'
};

const ESTILO =
  'Pintura digital cinematográfica, luz de fim de tarde (golden hour), cores quentes e saturadas, ' +
  'atmosfera acolhedora e convidativa, estilo das ilustrações de viagem. Sem nenhum texto, letra, ' +
  'número ou logotipo na imagem. Enquadramento horizontal 3:2 (1200×800), profundidade de campo ' +
  'suave, composição com um ponto focal claro. Pessoas de costas, de perfil ou a média distância — ' +
  'nenhum rosto reconhecível em primeiro plano.';

// ── lê o contrato e os episódios ────────────────────────────────────────────
const contrato = JSON.parse(readFileSync(join(courseCode, 'slots.json'), 'utf8'));
const ordem = new Map(contrato.slots.map((s, i) => [s.id, i]));
const funcao = new Map(contrato.slots.map((s) => [s.id, s.funcao]));

const partes = [];
for (const f of readdirSync(courseCode).filter((x) => /^ep-.*\.json$/.test(x))) {
  const j = JSON.parse(readFileSync(join(courseCode, f), 'utf8'));
  // Só parte ESCRITA entra no pedido: uma parte `aguardaNarracao` ainda tem a
  // `cena` do scaffold (língua/gag do curso-base) — pedir a imagem dela agora
  // manda o Mac gerar uma cena que vai ser reescrita. O pedido é idempotente:
  // quando a parte ganha narração, um novo `pedido.mjs` a inclui.
  if (j.slot && !j.aguardaNarracao) partes.push(j);
}
partes.sort((a, b) => (ordem.get(a.slot) ?? 999) - (ordem.get(b.slot) ?? 999));

// agrupa como a home: id legado (e01a) por prefixo, id de slot (b06) sozinho
const legado = (id) => /^[a-z]\d{2}[a-z]$/.test(id);
const grupos = new Map();
for (const p of partes) {
  const g = legado(p.id) ? p.id.slice(0, -1) : p.id;
  if (!grupos.has(g)) grupos.set(g, p);
}

const imgDir = join(cursoDir, 'static', 'img');
const tem = new Set(
  existsSync(imgDir)
    ? readdirSync(imgDir).filter((f) => /\.(webp|png|jpg|jpeg)$/i.test(f)).map((f) => f.replace(/\.[^.]+$/, ''))
    : []
);
const entregues = join(bridge, 'entregues', curso);
const jaEntregue = new Set(
  existsSync(entregues)
    ? readdirSync(entregues).filter((f) => /\.webp$/i.test(f)).map((f) => f.replace(/\.webp$/i, ''))
    : []
);

const faltam = [...grupos.entries()].filter(([g]) => !tem.has(g) && !jaEntregue.has(g));

// ── escreve o pedido máquina ────────────────────────────────────────────────
mkdirSync(join(bridge, 'pedidos'), { recursive: true });
mkdirSync(entregues, { recursive: true });

const idioma = curso.endsWith('-de') ? 'de' : /espanol|espanha/.test(curso) && !curso.endsWith('-de') ? 'es' : 'pt';
const spec = {
  curso,
  ambiente: AMBIENTE[curso] || '(defina o ambiente em tools/pedido.mjs)',
  estilo: ESTILO,
  entregar_em: `entregues/${curso}/`,
  arquivos: faltam.map(([g, p]) => ({
    id: g,
    arquivo: `${g}.webp`,
    titulo: p.titulo || funcao.get(p.slot) || g,
    cena: (p.cena || funcao.get(p.slot) || '').replace(/\s+/g, ' ').trim()
  }))
};
writeFileSync(join(bridge, 'pedidos', `${curso}.json`), JSON.stringify(spec, null, 2) + '\n');

// ── escreve o briefing legível ──────────────────────────────────────────────
let md = `# Pedido de imagens — ${curso}\n\n`;
md += `**${faltam.length} imagens.** Ambiente: ${spec.ambiente}\n\n`;
md += `Entregar em \`entregues/${curso}/\`, cada arquivo com o **id exato** abaixo, \`.webp\`, 1200×800, sem nenhum texto na imagem.\n\n`;
md += `## Bloco de estilo — cole ANTES de cada prompt, sem editar\n\n> ${ESTILO} Ambiente: ${spec.ambiente}\n\n`;
md += `## As imagens\n\nCada linha: \`id\` — título do card — a cena (é o seu briefing).\n\n`;
for (const [g, p] of faltam) {
  const cena = (p.cena || funcao.get(p.slot) || '').replace(/\s+/g, ' ').trim();
  md += `### ${g}.webp\n**${p.titulo || g}**\n\n${cena}\n\n`;
}
md += `---\n\nQuando terminar este curso, o pedido está completo assim que **todo id acima existir em \`entregues/${curso}/\`**. É o \`pedidos/${curso}.json\` que define a lista fechada.\n`;
writeFileSync(join(bridge, 'pedidos', `${curso}.md`), md);

console.log(`pedido escrito: ${faltam.length} imagens para ${curso}`);
console.log(`  pedidos/${curso}.md   (briefing)`);
console.log(`  pedidos/${curso}.json (${faltam.length} arquivos esperados)`);
