#!/bin/bash
# Script para iniciar o ambiente SOC (Wazuh SIEM)

echo "Verificando o Docker Compose..."
if ! command -v docker-compose &> /dev/null
then
    echo "Erro: docker-compose não encontrado. Instale-o primeiro."
    exit 1
fi

echo "Iniciando os serviços do Wazuh (Manager, Indexer, Dashboard)..."
docker-compose up -d

if [ $? -eq 0 ]; then
    echo "Serviços do Wazuh iniciados com sucesso!"
    echo "O Dashboard deve estar acessível em https://<IP_DO_HOST>:443 após alguns minutos."
    echo "Lembre-se de aceitar o certificado autoassinado."
else
    echo "Erro ao iniciar os serviços. Verifique os logs do docker."
fi