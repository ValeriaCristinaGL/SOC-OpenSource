#  MouraTech - Projeto SOC (Security Operations Center) Open Source

![Banner do projeto SOC Opensource](https://raw.githubusercontent.com/ValeriaCristinaGL/SOC-OpenSource/refs/heads/main/assets/arquiteturaSOC.jpg)

Este repositório contém o projeto de desenvolvimento de um Centro de Operações de Segurança (SOC) funcional e de baixo custo, utilizando exclusivamente ferramentas _open source_. [cite_start]O projeto é parte da disciplina de Engenharia de Software e visa simular um ambiente real de monitoramento, detecção e resposta a incidentes de segurança[cite: 42, 45].

## 🎯 Objetivo do Projeto

O objetivo principal é desenvolver e validar um ambiente de SOC capaz de:
* [cite_start]Coletar, correlacionar e visualizar logs de eventos de diferentes fontes[cite: 166].
* [cite_start]Detectar e facilitar a resposta a incidentes de segurança simulados[cite: 167].
* [cite_start]Integrar inteligência de ameaças (*Threat Intelligence*) para enriquecer as detecções[cite: 168].
* [cite_start]Demonstrar um modelo resiliente, escalável e acessível para pequenas e médias organizações[cite: 169, 170].

---

## 🛠️ Tecnologias Utilizadas

* **SIEM:** [Wazuh](https://wazuh.com/) - Para coleta, correlação e análise de eventos de segurança.
* **IDS/IPS:** [Suricata](https://suricata.io/) - Para monitoramento de tráfego de rede e detecção de intrusão (a ser implementado).
* **Threat Intelligence:** [MISP](https://www.misp-project.org/) - Plataforma para compartilhamento de Indicadores de Comprometimento (IoCs) (a ser implementado).
* **Contêineres:** [Docker](https://www.docker.com/) & [Docker Compose](https://docs.docker.com/compose/) - Para orquestrar e gerenciar os serviços do SOC.

---

## ✅ Pré-requisitos

Antes de começar, garanta que você tenha os seguintes softwares instalados na sua máquina real (Host):

* [Git](https://git-scm.com/)
* [Docker Desktop](https://www.docker.com/products/docker-desktop/) (utilizando o backend WSL2 no Windows)
* Software de Virtualização (ex: [VirtualBox](https://www.virtualbox.org/) ou [VMware Workstation Player](https://www.vmware.com/products/workstation-player.html))
* VMs de clientes preparadas:
    * Uma VM com **Debian 11**.
    * Uma VM com **Windows 11**.

---

## 🚀 Guia de Instalação e Configuração

Siga estes passos para clonar, configurar e executar o ambiente SOC em sua máquina local.

### **Passo 1: Clonar o Repositório**

```bash
git clone [https://github.com/ValeriaCristinaGL/SOC-OpenSource.git](https://github.com/ValeriaCristinaGL/SOC-OpenSource.git)
cd SOC-OpenSource

### **Passo 2: Instalar as dependências:**

Antes de iniciar o ambiente pela primeira vez, siga estes passos para configurar as credenciais locais.

Execute o script de setup para garantir que você tem o Docker e o Docker Compose instalados.

```bash
cd scripts/
./setup.sh