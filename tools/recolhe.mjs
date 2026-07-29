#!/usr/bin/env node
// RECOLHE AS ENTREGAS e encadeia o próximo pedido. Roda no PC.
//
//   node tools/recolhe.mjs
//
// Para cada pedido em pedidos/*.json:
//  1. copia as imagens já entregues para D:/dev/_projects/<curso>/static/img/
//  2. regenera o outline do curso (a home passa a mostrar as fotos novas)
//  3. se o curso ficou COMPLETO, dispara o pedido do próximo curso da fila
//  4. atualiza o STATUS.md
//
// Não faz git — quem comita e empurra é o chamador, depois de ver o relatório.
// (Git em remoto compartilhado é passo consciente, não efeito colateral.)

import { readFileSync, writeFileSync, readdirSync, existsSync, copyFileSync, statSync } from 'node:fs';
import { join, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';
import { execSync } from 'node:child_process';

const bridge = join(dirname(fileURLToPath(import.meta.url)), '..');
const pedidosDir = join(bridge, 'pedidos');

// A fila de encadeamento é por DESTINO, não por comprador. A imagem é ativo do
// DESTINO: EN/DE/FR/IT da Espanha compartilham as MESMAS 47 imagens (byte-a-byte
// — o dono corrigiu isto em 2026-07-28). Uma variante de comprador NÃO gera nada:
// ela COPIA o set canônico do destino (`cp`, custo zero, sem Mac). Por isso as
// variantes -de/-fr/-it saíram da fila — só destinos NOVOS geram. Hoje só a
// Espanha existe; França-destino, Itália-destino etc. entram aqui quando nascerem.
const FILA = ['curso-espanha'];

const linhas = [];
let despachou = null;

for (const f of readdirSync(pedidosDir).filter((x) => x.endsWith('.json'))) {
  const spec = JSON.parse(readFileSync(join(pedidosDir, f), 'utf8'));
  const curso = spec.curso;
  const entregues = join(bridge, 'entregues', curso);
  const alvo = `D:/dev/_projects/${curso}/static/img`;

  let copiadas = 0;
  const presentes = new Set();
  for (const a of spec.arquivos) {
    const src = join(entregues, a.arquivo);
    if (existsSync(src) && statSync(src).size > 10000) {
      presentes.add(a.id);
      const dst = join(alvo, a.arquivo);
      if (existsSync(alvo) && (!existsSync(dst) || statSync(dst).size !== statSync(src).size)) {
        copyFileSync(src, dst);
        copiadas++;
      }
    }
  }

  const completo = presentes.size === spec.arquivos.length;
  linhas.push(
    `| ${curso} | ${spec.arquivos.length} | ${presentes.size} | ${completo ? '✅ completo' : 'em produção'}${copiadas ? ` · +${copiadas} copiadas` : ''} |`
  );

  // regenera o outline se copiou algo (a home passa a pedir as fotos novas)
  if (copiadas && existsSync(`D:/dev/_projects/${curso}/scripts/gera-outline.mjs`)) {
    try {
      execSync('node scripts/gera-outline.mjs', { cwd: `D:/dev/_projects/${curso}`, stdio: 'ignore' });
    } catch {}
  }

  // encadeia: se este fechou e o próximo da fila existe e ainda não tem pedido, dispara
  if (completo) {
    const i = FILA.indexOf(curso);
    const proximo = FILA[i + 1];
    if (proximo && existsSync(`D:/dev/_projects/${proximo}`) && !existsSync(join(pedidosDir, `${proximo}.json`))) {
      try {
        execSync(`node tools/pedido.mjs ${proximo}`, { cwd: bridge, stdio: 'inherit' });
        despachou = proximo;
      } catch (e) {
        linhas.push(`| ${proximo} | ? | — | ⚠ falha ao gerar pedido: ${e.message} |`);
      }
    }
  }
}

const status =
  `# Estado da fila\n\nAtualizado pelo PC a cada \`node tools/recolhe.mjs\`.\n\n` +
  `| curso | pedido | entregues | estado |\n|---|---:|---:|---|\n${linhas.join('\n')}\n` +
  (despachou ? `\n_Encadeado: pedido de **${despachou}** recém-criado._\n` : '');
writeFileSync(join(bridge, 'STATUS.md'), status);

console.log(status);
if (despachou) console.log(`\n→ despachei o pedido do próximo curso: ${despachou}`);
