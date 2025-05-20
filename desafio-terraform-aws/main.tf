# Provedor AWS, parametrizado para facilitar uso em diferentes ambientes
provider "aws" {
  region = var.aws_region
}

# Bucket S3 para armazenar arquivos (um por ambiente)
resource "aws_s3_bucket" "example" {
  bucket = var.s3_bucket_name
}

# Exemplo de política para tornar o bucket privado
resource "aws_s3_bucket_policy" "example" {
  bucket = aws_s3_bucket.example.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource  = "${aws_s3_bucket.example.arn}/*"
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })
}

# Tópico SNS para notificações (um por ambiente)
resource "aws_sns_topic" "example" {
  name = var.sns_topic_name
}

# Tabela DynamoDB importada (criada manualmente e agora gerenciada pelo Terraform)
resource "aws_dynamodb_table" "imported_table" {
  name           = "tabela-importada"
  hash_key       = "id"
  attribute {
    name = "id"
    type = "S"
  }
  billing_mode   = "PAY_PER_REQUEST"
}