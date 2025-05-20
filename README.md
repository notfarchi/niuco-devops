# Desafio IaC AWS com Terraform

## Sobre o Projeto

Este projeto foi desenvolvido como parte de um desafio para provisionar infraestrutura na AWS usando Terraform, mesmo sendo iniciante em cloud.  
O objetivo é criar três recursos distintos na AWS (S3, DynamoDB, SNS), demonstrar a importação de recursos já existentes, separar ambientes (staging e produção) e garantir o uso de state remoto com locking.

---

## Recursos Criados

- **S3 Bucket:** Armazenamento de arquivos.
- **DynamoDB Table:** Banco NoSQL gerenciado.
- **SNS Topic:** Serviço de notificações para integração e automação.

---

## Pré-requisitos

- Conta na AWS (com permissões S3, SNS, DynamoDB)
- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) instalado
- AWS CLI configurado (`aws configure`)

---

## Como Usar

### 1. Clone o repositório
```bash
git clone https://github.com/seu-usuario/desafio-terraform-aws.git

cd desafio-terraform-aws
```
### 2. Inicialize o Terraform para o ambiente desejado
```base
terraform init -backend-config=backend-staging.hcl
```
### 3. Selecione ou crie o workspace
```base
terraform workspace new staging
terraform workspace select staging
```
### 4. Importe a tabela DynamoDB criada manualmente
```base
terraform import -var-file=envs/staging.tfvars aws_dynamodb_table.imported_table tabela-importada
```
### 5. Visualize o plano de execução
```bash
terraform plan -var-file=envs/staging.tfvars
```
### 6. Aplique as mudanças
```bash
terraform apply -var-file=envs/staging.tfvars
```
### 7. Repita para produção

Troque para o backend e variáveis de produção:
```bash
terraform init -backend-config=backend-prod.hcl
terraform workspace new prod
terraform workspace select prod
terraform plan -var-file=envs/prod.tfvars
terraform apply -var-file=envs/prod.tfvars
```
---

## Como funciona a separação de ambientes?

- Cada ambiente (staging/prod) tem seu próprio arquivo `.tfvars` com nomes de recursos e configurações específicas.
- O uso de workspaces e backends separados garante isolamento total entre ambientes.
- O locking via DynamoDB impede alterações simultâneas no state remoto.

---

## Sobre o Locking

O locking é feito usando uma tabela DynamoDB específica.  
Isso garante que apenas um comando do Terraform possa modificar o state por vez, evitando corrupção e conflitos.

---

## Dicas e Observações

- Os arquivos `.tf` estão cheios de comentários para facilitar o entendimento, já que o projeto também serve como tutorial.
- Caso precise destruir apenas um recurso, use:
terraform destroy -target=aws_s3_bucket.example -var-file=envs/staging.tfvars

- Sempre use `-var-file` para garantir que as variáveis corretas sejam usadas.

---

## Aprendizados

- Como criar infraestrutura na AWS usando código.
- Como separar ambientes de teste e produção.
- Como importar recursos já existentes para o Terraform.
- Como evitar conflitos usando state remoto e locking.

---

## Referências

- [Documentação oficial do Terraform](https://developer.hashicorp.com/terraform/docs)
- [AWS Free Tier](https://aws.amazon.com/free/)
- [Vídeo: Terraform para Iniciantes](https://www.youtube.com/watch?v=A4vsZIX6UKs)

---
