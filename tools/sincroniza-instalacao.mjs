#!/usr/bin/env node
// SINCRONIZADOR DE INSTALAÇÃO — kit-imagens → cursos (lado PC)
//
// POR QUE ISTO EXISTE. Entrega no repositório-ponte NÃO instala nada. Em
// 2026-08-04 as 5 imagens regeneradas de `mexico-regen` estavam commitadas em
// `entregues/` havia horas e `static/img/` do curso ainda servia as versões
// REJEITADAS — catraca proibida, mesa sem acompanhante, tudo. O erro é
// silencioso por construção: o nome do arquivo não muda numa regeneração, então
// nada no curso indica que a arte envelheceu.
//
// O QUE ELE É, E O QUE ELE DELIBERADAMENTE NÃO É. É cópia de arquivo guiada por
// md5: detecta diferença de conteúdo e copia. Não há LLM no laço, não há decisão
// sobre conteúdo, não há geração. Isso é pedido explícito da estação Mac e o
// motivo está medido: um listener que operava o gerador sozinho colou prompts na
// janela errada por horas sem produzir nada aproveitável, e as imagens que
// prestaram exigiram conferência VISUAL humana — foi assim que se pegou a
// catraca da b09 e as 15 violações de pseudo-texto da auditoria. Automação cega
// em cima de geração reproduz defeito em escala. Cópia de arquivo é o oposto:
// determinística, verificável, sem julgamento.
//
// USO:
//   node tools/sincroniza-instalacao.mjs            → DRY-RUN, só mede
//   node tools/sincroniza-instalacao.mjs --aplicar  → copia de verdade
//
// O dry-run é o padrão de propósito: a primeira coisa que se quer saber é o
// TAMANHO do buraco, não fechá-lo às cegas.

import { readFileSync, writeFileSync, readdirSync, existsSync, copyFileSync, statSync, mkdirSync } from 'node:fs';
import { createHash } from 'node:crypto';
import { join, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';

const repo = join(dirname(fileURLToPath(import.meta.url)), '..');
const APLICAR = process.argv.includes('--aplicar');

// Raiz das worktrees dos cursos no PC.
const CURSOS = 'C:/Users/aapc_/Documents/Codex/kit-de-bordo-worktrees';

// ── O MAPA ────────────────────────────────────────────────────────────────────
// acervo em entregues/ → cursos que o consomem.
//
// UM ACERVO ALIMENTA VÁRIOS CURSOS, e assumir 1:1 deixa passivo para trás: a arte
// é do DESTINO, e as variantes de língua do comprador reusam a mesma imagem (um
// turista na Espanha não encontra placa em alemão, então a placa serve às três).
// Por isso `destino-X` abre em leque para todo `curso-X-*`.
//
// O mapa é EXPLÍCITO e não derivado por heurística de nome: um acervo sem entrada
// aqui é reportado como não mapeado em vez de ser adivinhado. Adivinhar destino de
// arte é como se instala imagem no curso errado.
const MAPA = {
  'curso-espanha': ['curso-espanha'],
  'curso-espanha-de': ['curso-espanha-de'],
  'curso-espanha-fr': ['curso-espanha-fr'],
  'destino-franca': ['curso-franca-de', 'curso-franca-en'],
  'destino-grecia': ['curso-grecia-de', 'curso-grecia-en'],
  'destino-italia': ['curso-italia-de', 'curso-italia-en'],
  'destino-turquia': ['curso-turquia-de', 'curso-turquia-en'],
  'destino-alemanha': [], // sem worktree de curso alemanha neste PC — ver relatório
  'mexico-regen': ['curso-mexico-en']
};

const md5 = (p) => createHash('md5').update(readFileSync(p)).digest('hex');
const ehImagem = (f) => /\.(webp|png|jpg|jpeg)$/i.test(f);

const entreguesDir = join(repo, 'entregues');
const relatorio = [];
let desatualizados = 0, ausentes = 0, iguais = 0, copiados = 0;
const naoMapeados = [], destinosAusentes = [];

for (const acervo of readdirSync(entreguesDir).filter((d) => statSync(join(entreguesDir, d)).isDirectory())) {
  const destinos = MAPA[acervo];
  if (destinos === undefined) { naoMapeados.push(acervo); continue; }

  const arquivos = readdirSync(join(entreguesDir, acervo)).filter(ehImagem);
  if (!arquivos.length) continue;

  for (const curso of destinos) {
    const imgDir = join(CURSOS, curso, 'static', 'img');
    if (!existsSync(imgDir)) { destinosAusentes.push(`${acervo} → ${curso}`); continue; }

    for (const f of arquivos) {
      const origem = join(entreguesDir, acervo, f);
      const destino = join(imgDir, f);
      let estado;
      if (!existsSync(destino)) { estado = 'AUSENTE'; ausentes++; }
      else if (md5(origem) !== md5(destino)) { estado = 'DESATUALIZADO'; desatualizados++; }
      else { iguais++; continue; }

      relatorio.push({ acervo, curso, arquivo: f, estado });
      if (APLICAR) {
        mkdirSync(dirname(destino), { recursive: true });
        copyFileSync(origem, destino);
        copiados++;
      }
    }
  }
}

console.log(`\nsincroniza-instalacao · ${APLICAR ? 'APLICANDO' : 'DRY-RUN (use --aplicar para copiar)'}\n`);
console.log(`  já em dia .......... ${iguais}`);
console.log(`  DESATUALIZADOS ..... ${desatualizados}   (mesmo nome, conteúdo diferente — o caso silencioso)`);
console.log(`  ausentes ........... ${ausentes}   (nunca instalados)`);
if (APLICAR) console.log(`  copiados ........... ${copiados}`);

if (relatorio.length) {
  console.log('\n  detalhe:');
  const porCurso = {};
  for (const r of relatorio) (porCurso[`${r.curso}`] ??= []).push(`${r.arquivo}${r.estado === 'AUSENTE' ? '*' : ''}`);
  for (const [curso, fs_] of Object.entries(porCurso))
    console.log(`    ${curso.padEnd(20)} ${fs_.length.toString().padStart(3)}  ${fs_.slice(0, 8).join(' ')}${fs_.length > 8 ? ' …' : ''}`);
  console.log('    (* = ausente, sem asterisco = desatualizado)');
}

if (naoMapeados.length) console.log(`\n  ⚠ acervos SEM destino no mapa: ${naoMapeados.join(', ')}`);
if (destinosAusentes.length) console.log(`  ⚠ destinos que não existem neste PC: ${[...new Set(destinosAusentes)].join(', ')}`);

// Log auditável. Grava sempre, inclusive em dry-run, com a marca do modo.
const log = {
  quando: new Date().toISOString(),
  modo: APLICAR ? 'aplicar' : 'dry-run',
  resumo: { iguais, desatualizados, ausentes, copiados: APLICAR ? copiados : 0 },
  itens: relatorio,
  naoMapeados,
  destinosAusentes: [...new Set(destinosAusentes)]
};
mkdirSync(join(repo, 'tools'), { recursive: true });
writeFileSync(join(repo, 'tools', 'ultima-sincronizacao.json'), JSON.stringify(log, null, 2) + '\n');
console.log(`\n  log: tools/ultima-sincronizacao.json\n`);
