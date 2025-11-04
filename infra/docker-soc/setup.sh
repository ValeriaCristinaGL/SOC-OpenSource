#!/bin/bash
# Script para configurar o ambiente Host (Instalação de Docker e Docker Compose)

echo "--- Verificação e Instalação de Dependências (Host) ---"

# Verifica e instala Docker (Exemplo para sistemas baseados em Debian/Ubuntu)
if ! command -v docker &> /dev/null
then
    echo "Docker não encontrado. Instalando..."
    # Comandos de instalação do Docker (exemplo simplificado, requer sudo)
    # sudo apt update
    # sudo apt install docker.io -y
    # sudo usermod -aG docker $USER
    # echo "Por favor, faça logoff e login para aplicar as permissões do grupo docker."
else
    echo "Docker já instalado."
fi

# Verifica e instala Docker Compose (V2)
if ! command -v docker compose &> /dev/null
then
    echo "Docker Compose (V2) não encontrado. Sugira a instalação manual se necessário."
    # Comandos de instalação do Docker Compose
else
    echo "Docker Compose (V2) já instalado."
fi

echo "--- Setup do Ambiente Concluído ---"