# kit-imagens Listener

Daemon autônomo que monitora `pedidos/` e gera imagens via ChatGPT + clipboard.

## Requisitos

- `xdotool` (para automatizar cliques)
- `jq` (para parsear JSON)
- Navegador com ChatGPT aberto nesta URL:
  - `https://chatgpt.com/c/6a6d4215-5c78-83e9-9786-afa53ca1d4b8`

## Scripts

### 1. `listener.sh`
Monitora `pedidos/` e reporta o que falta fazer.
```bash
./listener.sh &
```
Roda indefinidamente, loga em `.listener.log`.

### 2. `auto-gen.sh`
Automatiza geração para um curso específico.
```bash
./auto-gen.sh pedidos/4-destino-grecia.json
```
- Envia prompts via xdotool
- Aguarda geração
- Captura via clipboard
- Salva + commit + push

### 3. `start-listener.sh`
Coordena listener + auto-gen para todos os cursos.
```bash
./start-listener.sh
```
- Para listener anterior
- Monitora `pedidos/` a cada 60s
- Dispara `auto-gen.sh` para cursos com imagens faltantes
- Mostra log contínuo

## Como usar

### Opção 1: Monitoramento automático contínuo
```bash
cd ~/kit-imagens
nohup ./start-listener.sh > .listener-main.log 2>&1 &
```
Roda em background indefinidamente, mesmo se fechar o terminal.

### Opção 2: Manual por curso
```bash
cd ~/kit-imagens
./auto-gen.sh pedidos/4-destino-grecia.json
./auto-gen.sh pedidos/2-destino-italia.json
```

## Logs

- `.listener.log` — listener principal
- `.auto-gen.log` — execuções de auto-gen
- `.listener-main.log` — nohup output (se usar Opção 1)

## Troubleshooting

**xdotool não encontra janela do ChatGPT**
- Confirme URL: `https://chatgpt.com/c/6a6d4215-5c78-83e9-9786-afa53ca1d4b8`
- Verifique título da janela: deve conter "ChatGPT" ou a string do chat ID

**Clipboard clobbered**
- Script detecta e reintenta
- Se persistir, outro processo está usando clipboard

**Imagem não aparece após 45s**
- Script aguarda $SLEEP_GEN = 45s padrão
- Pode ser aumentado em `auto-gen.sh` se ChatGPT estiver lento

## Parar o listener

```bash
# Opção 1: Kill pelo PID
kill $(cat ~/.kit-imagens/.listener.pid)

# Opção 2: Kill pelo processo
pkill -f monitor_and_autogen

# Opção 3: Ver e matar manualmente
ps aux | grep auto-gen
```

## Status

Destinado-grécia: **23/36** imagens (b01-b18, i01-i10, a01-a02)
- Restam: a03-a08 (6 imagens)

Destino-itália: **0/36** (não iniciado)
Destino-turquia: **0/36** (não iniciado)

Listener irá processar automaticamente assim que estiver rodando.
