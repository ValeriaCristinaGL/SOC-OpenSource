Início Rápido
Pré-requisitos:

Docker

Docker Compose

1. Clone o Repositório

Bash

git clone [https://github.com/ValeriaCristinaGL/SOC-OpenSource.git]
cd SOC-OPENSOURCE
2. Crie os Arquivos de Senha

Bash

# Navegue para o diretório correto
cd infrastructure/docker-compose/
Crie uma senha forte para o usuário admin
echo "SuaSenhaSuperForteAqui" > wazuh-indexer-password.txt

Crie uma chave de criptografia
openssl rand -hex 32 > wazuh-indexer-key.txt


**3. Gere os Certificados TLS (Apenas na primeira vez)**
Bash

docker-compose -f docker-compose.certs.yml run --rm wazuh-certs-generator
4. Inicie o Ambiente SOC

Bash

docker-compose up -d
5. Acesse o Dashboard Abra seu navegador e acesse https://localhost.

Usuário: admin

Senha: A senha que você definiu no arquivo wazuh-indexer-password.txt.