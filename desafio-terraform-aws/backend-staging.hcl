# Configuração do backend remoto e locking
bucket         = "meu-terraform-state-desafio"
key            = "state/staging/terraform.tfstate"
region         = "us-east-2"
dynamodb_table = "meu-terraform-lock-desafio"
encrypt        = true