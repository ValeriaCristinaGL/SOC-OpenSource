#!/bin/bash
# Script para parar e remover contêineres, redes e opcionalmente volumes do Wazuh

echo "--- Parando e removendo contêineres do Wazuh..."

# Navega para o diretório do script
cd "$(dirname "$0")"

# Carrega o .env para ter acesso às variáveis se necessário
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

WAZUH_PATH="infrastructure/wazuh"

# Usa o arquivo docker-compose correto para derrubar o ambiente
docker compose -f ${WAZUH_PATH}/docker-compose.yml down

read -r -p "Deseja remover também os volumes de dados persistentes? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo "--- Removendo volumes de dados..."
    docker volume rm wazuh_indexer_data wazuh_manager_data wazuh_dashboard_data || true
fi

read -r -p "Deseja remover os certificados e senhas gerados? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo "--- Removendo certificados e segredos..."
    rm -rf ${WAZUH_PATH}/config/wazuh-certs
    rm -rf ${WAZUH_PATH}/secrets
fi

echo "--- Limpeza concluída."