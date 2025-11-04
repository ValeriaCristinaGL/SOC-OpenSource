#!/bin/bash
# Script de instalação do Agente Wazuh no Debian 11

# --- MODIFICADO ---
# Verifica se o IP do Manager foi passado como argumento
if [ -z "$1" ]; then
    echo "Erro: Você deve fornecer o IP do Wazuh Manager como argumento."
    echo "Uso: $0 <IP_DO_MANAGER>"
    exit 1
fi

WAZUH_MANAGER_IP="$1" # Usa o primeiro argumento da linha de comando
# --- FIM DA MODIFICAÇÃO ---

AGENT_NAME="Debian-Client-$(hostname)"

echo "Instalando dependências..."
apt update && apt install curl lsb-release -y

echo "Adicionando repositório Wazuh..."
curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | gpg --no-default-keyring --keyring /usr/share/keyrings/wazuh.gpg --import
echo "deb [signed-by=/usr/share/keyrings/wazuh.gpg] https://packages.wazuh.com/4.x/apt/ stable main" | tee /etc/apt/sources.list.d/wazuh.list

apt update
apt install wazuh-agent -y

echo "Configurando e registrando Agente no Manager: ${WAZUH_MANAGER_IP}"
# Utiliza o comando de linha para definir o Manager e o nome do agente
/var/ossec/bin/agent-auth -m ${WAZUH_MANAGER_IP} -A ${AGENT_NAME}

echo "Iniciando o serviço do Agente Wazuh..."
systemctl daemon-reload
systemctl enable wazuh-agent
systemctl start wazuh-agent

echo "Verifique o status com: systemctl status wazuh-agent"