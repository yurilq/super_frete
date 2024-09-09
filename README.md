# Pipeline de Dados - Super Frete

## Visão Geral

Este projeto implementa um pipeline de dados escalável para a **Super Frete**, utilizando o **Airflow** para orquestração de dados e serviços gerenciados da **AWS** para processamento e armazenamento. O pipeline segue o padrão **ETL** (Extract, Transform, Load), processando dados de fontes externas e armazenando-os para análises futuras.

A arquitetura foi projetada com foco em **escalabilidade**, **confiabilidade** e **facilidade de manutenção**, utilizando o **EMR** para processamento de grandes volumes de dados e **RDS**/**Redshift** para armazenar os resultados.

## Arquitetura do Pipeline

O pipeline é dividido em três etapas principais:

1. **Ingestão de Dados**: Os dados são extraídos de fontes externas e carregados no **S3** como dados brutos.
2. **Processamento de Dados**: O cluster **EMR** processa os dados brutos utilizando o **Spark**, transformando-os em dados processados.
3. **Entrega de Dados**: Os dados processados são enviados para o **RDS** (para consultas transacionais) e para o **Redshift** (para consultas analíticas).

## Estrutura do Repositório

```bash
├── dags/
│   ├── ingestao_dados.py         # DAG responsável pela ingestão de dados no S3
│   ├── processamento_dados.py    # DAG responsável pelo processamento no EMR
│   └── entrega_dados.py          # DAG responsável pela entrega de dados para RDS/Redshift
├── terraform/
│   ├── main.tf                   # Provisionamento de recursos AWS
│   ├── variables.tf              # Definição de variáveis para o projeto
│   ├── outputs.tf                # Outputs gerados pelo Terraform
│   └── provider.tf               # Configuração do provedor AWS
├── docker-compose.yml            # Arquivo para rodar Airflow localmente com Docker
├── requirements.txt              # Dependências do projeto
└── README.md                     # Documentação do projeto
```

## Fluxo do Pipeline

O pipeline segue um fluxo **ETL** clássico e é dividido em três **DAGs** (Directed Acyclic Graphs) no Airflow:

### Ingestão de Dados:
- Extrai dados de fontes externas e os armazena no bucket S3 da **Super Frete**.
- **Arquivo responsável**: `dags/ingestao_dados.py`

### Processamento de Dados:
- Processa os dados brutos no **EMR** utilizando **Spark**.
- **Arquivo responsável**: `dags/processamento_dados.py`

### Entrega de Dados:
- Transfere os dados processados para o **RDS** e **Redshift**.
- **Arquivo responsável**: `dags/entrega_dados.py`

## Configuração do Ambiente

### Pré-requisitos

- **Docker**: Para rodar o **Airflow** localmente. [Instalar Docker](https://docs.docker.com/get-docker/)
- **AWS CLI**: Para configurar suas credenciais AWS. [Instalar AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- **Terraform**: Para provisionar a infraestrutura na AWS. [Instalar Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)

### Instalação

1. Clone o repositório:
```bash
   git clone https://github.com/seu-usuario/superfrete-pipeline.git
   cd superfrete-pipeline
```
## Instalação das Dependências e Inicialização

### Instale as dependências do Python:
```bash
pip install -r requirements.txt
```
## Inicie o Airflow utilizando o Docker:
```bash
docker-compose up
```

## Acesse o Airflow em http://localhost:8080 com as credenciais padrão:
- **Usuário: airflow**
- **Senha: airflow**
  

# Provisionamento da Infraestrutura na AWS
## O Terraform é utilizado para provisionar todos os recursos da AWS necessários para o pipeline.

## Inicialize e configure o Terraform:
```bash
cd terraform/
terraform init
terraform plan
terraform apply
```

## Isso provisionará:

- **Um bucket S3 para armazenamento de dados brutos.**
- **Um cluster EMR para processamento de dados.**
- **Um RDS PostgreSQL para dados transacionais.**
- **Um Redshift para consultas analíticas.**
  
# Execução dos DAGs no Airflow

## Na interface do Airflow, ative os seguintes DAGs:
- **ingestao_dados.py: Para extrair e armazenar os dados brutos no S3.**
- **processamento_dados.py: Para processar os dados brutos no EMR.**
- **entrega_dados.py: Para transferir os dados processados para o RDS e Redshift.**

  
## Acompanhe a execução de cada DAG e visualize os logs na interface do Airflow.

# Validação
- **S3: Verifique se os dados brutos foram armazenados no bucket S3 no caminho raw_data/.**
- **EMR: Verifique no console AWS o status do cluster EMR e seus logs de execução.**
- **RDS e Redshift: Acesse os bancos de dados para validar se os dados processados foram carregados corretamente.**

# Limpeza dos Recursos
## Para evitar cobranças desnecessárias, destrua os recursos provisionados na AWS com o Terraform:
```bash
cd terraform/
terraform destroy
```
# Considerações Finais
## Este pipeline foi projetado para ser escalável e eficiente. Utiliza serviços gerenciados da AWS para garantir alta disponibilidade e facilidade de manutenção. O Airflow gerencia todo o fluxo de dados, garantindo a automação e orquestração de tarefas complexas com facilidade.
