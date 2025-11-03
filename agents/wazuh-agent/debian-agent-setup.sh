#!/bin/bash
# Script de instalação do Agente Wazuh no Debian 13

# Verifica se o IP do Manager foi passado como argumento
if [ -z "$1" ]; then
    echo "Erro: Forneça o endereço IP do Wazuh Manager como argumento."
    echo "Exemplo de uso: ./debian-agent-setup.sh 192.168.1.15"
    exit 1
fi

WAZUH_MANAGER_IP="$1" # Usa o primeiro argumento como o IP do Manager
AGENT_NAME="Debian-Client-$(hostname)"

echo "Instalando dependências..."

WAZUH_MANAGER_IP="<IP_DO_MANAGER>" # Ex: 192.168.1.10
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