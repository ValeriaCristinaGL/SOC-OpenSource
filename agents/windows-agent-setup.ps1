# Script de instalação e configuração do Agente Wazuh no Windows 11

# --- MODIFICADO ---
# Define um parâmetro obrigatório para o IP do Manager
param (
    [Parameter(Mandatory=$true)]
    [string]$ManagerIP
)
# --- FIM DA MODIFICAÇÃO ---

# Remove a linha antiga: $WazuhManagerIP = "<IP_DO_MANAGER>"
$AgentName = "Windows-Client-$((Get-CimInstance -ClassName Win32_ComputerSystem).Name)"

# 1. Download do instalador (Altere a URL da versão se necessário)
Write-Host "Baixando o Agente Wazuh..."
$InstallerUrl = "https://packages.wazuh.com/4.x/windows/wazuh-agent-4.7.4-1.msi"
$InstallerPath = "$env:TEMP\wazuh-agent.msi"
Invoke-WebRequest -Uri $InstallerUrl -OutFile $InstallerPath

# 2. Instalação silenciosa
Write-Host "Iniciando a instalação..."
# --- MODIFICADO ---
# Usa a variável $ManagerIP vinda do parâmetro
Start-Process msiexec -ArgumentList "/i `"$InstallerPath`" /qn WAZUH_MANAGER=`"$ManagerIP`" WAZUH_AGENT_NAME=`"$AgentName`"" -Wait
# --- FIM DA MODIFICAÇÃO ---

# 3. Verificação do serviço (pode ser necessário um breve atraso)
Start-Sleep -Seconds 5
Write-Host "Iniciando o serviço do Agente Wazuh..."
Set-Service -Name wazuh -StartupType Automatic
Start-Service wazuh

Write-Host "Instalação concluída. Verifique no Dashboard do Wazuh."