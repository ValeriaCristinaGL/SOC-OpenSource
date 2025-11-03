#!/bin/bash
# Script de instalação do Agente Wazuh no Debian

# Para o script se qualquer comando falhar
set -e

# Verifica se o IP do Manager foi passado como argumento
if [ -z "$1" ]; then
    echo "Erro: Forneça o endereço IP do Wazuh Manager como primeiro argumento."
    echo "Exemplo de uso: sudo ./debian-agent-setup.sh 192.168.1.100"
    exit 1
fi

WAZUH_MANAGER_IP="$1"
AGENT_NAME="Debian-Client-$(hostname)"

echo "--- Instalando dependências..."
apt-get update && apt-get install -y curl gpg

echo "--- Adicionando repositório Wazuh..."
curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | gpg --no-default-keyring --keyring /usr/share/keyrings/wazuh.gpg --import
echo "deb [signed-by=/usr/share/keyrings/wazuh.gpg] https://packages.wazuh.com/4.x/apt/ stable main" | tee /etc/apt/sources.list.d/wazuh.list

echo "--- Instalando o Agente Wazuh..."
apt-get update
apt-get install -y wazuh-agent

echo "--- Configurando e registrando o Agente no Manager: ${WAZUH_MANAGER_IP}"
# Configura o agente para apontar para o manager
sed -i "s/<address>MANAGER_IP<\/address>/<address>${WAZUH_MANAGER_IP}<\/address>/" /var/ossec/etc/ossec.conf

echo "--- Iniciando o serviço do Agente Wazuh..."
systemctl daemon-reload
systemctl enable wazuh-agent
systemctl start wazuh-agent

echo "--- Instalação do Agente Concluída! ---"
echo "Verifique o status com: systemctl status wazuh-agent"
echo "O agente deve aparecer no Dashboard do Wazuh em breve."