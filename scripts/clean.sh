#!/bin/bash
# Script para parar e remover containers e volumes do Wazuh

echo "Parando e removendo containers..."
docker-compose down

# Adicione a flag -v se quiser remover os volumes persistentes de dados:
read -r -p "Deseja remover também os volumes de dados persistentes (wazuh_indexer_data, wazuh_manager_data)? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    echo "Removendo volumes..."
    docker-compose down -v
    echo "Containers e volumes removidos."
else
    echo "Containers removidos. Volumes de dados preservados."
fi