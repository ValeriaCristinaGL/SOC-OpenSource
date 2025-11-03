#!/bin/bash
# Script unificado para configurar e iniciar o ambiente Wazuh SOC

# Para o script se qualquer comando falhar
set -e

# --- ETAPA 0: Verificação de Pré-requisitos ---
echo "--- Verificando pré-requisitos (Docker, Docker Compose)..."
if ! command -v docker &> /dev/null; then
    echo "ERRO: Docker não encontrado. Por favor, instale o Docker."
    exit 1
fi
if ! docker compose version &> /dev/null; then
    echo "ERRO: Docker Compose V2 não encontrado. Por favor, instale/atualize o Docker Compose."
    exit 1
fi

# Navega para o diretório do script para que os caminhos funcionem de forma consistente
cd "$(dirname "$0")"

# --- ETAPA 1: Configuração do Ambiente (.env) ---
if [ ! -f .env ]; then
    echo "--- Arquivo .env não encontrado. Copiando de .env.example..."
    cp .env.example .env
    echo "--- Arquivo .env criado. Por favor, edite-o com suas configurações e execute o script novamente."
    exit 0
fi

echo "--- Carregando variáveis de ambiente do arquivo .env..."
export $(grep -v '^#' .env | xargs)

# Define o caminho para a infraestrutura do Wazuh
WAZUH_PATH="infrastructure/wazuh"

# --- ETAPA 2: Geração de Certificados TLS ---
if [ ! -d "${WAZUH_PATH}/config/wazuh-certs" ]; then
    echo "--- Certificados não encontrados. Gerando novos certificados..."
    mkdir -p ${WAZUH_PATH}/config/wazuh-certs

    # Executa o gerador de certificados
    docker compose -f ${WAZUH_PATH}/docker-compose.certs.yml run --rm wazuh-certs-generator
    echo "--- Certificados gerados com sucesso."
else
    echo "--- Certificados já existentes encontrados."
fi

# --- ETAPA 3: Geração de Senhas (Secrets) ---
SECRETS_PATH="${WAZUH_PATH}/secrets"
mkdir -p ${SECRETS_PATH}

if [ ! -f "${SECRETS_PATH}/wazuh_indexer_password.txt" ]; then
    echo "--- Gerando senha para o Wazuh Indexer..."
    echo "${WAZUH_INDEXER_PASSWORD}" > "${SECRETS_PATH}/wazuh_indexer_password.txt"
else
    echo "--- Senha do Wazuh Indexer já existe."
fi

# --- ETAPA 4: Definindo Senha do Admin do Dashboard ---
# Esta senha será injetada diretamente no compose file
echo "--- Definindo a senha do usuário 'admin' do Dashboard..."
# A senha do admin será passada via variável de ambiente para o docker-compose.yml

# --- ETAPA 5: Iniciando a Stack do Wazuh ---
echo "--- Iniciando os contêineres do Wazuh (Indexer, Manager, Dashboard)..."
docker compose -f ${WAZUH_PATH}/docker-compose.yml up -d

echo ""
echo "--- Ambiente Wazuh iniciado com sucesso! ---"
echo "Aguarde alguns minutos para que os serviços sejam totalmente inicializados."
echo "Acesse o Dashboard em: https://localhost:${DASHBOARD_PORT}"
echo "Usuário: admin"
echo "Senha:   (a que você definiu em seu arquivo .env)"