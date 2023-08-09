provider "aws" {
  region     = var.access[2]
}

variable "access" {
  type = list(string)
}

resource "aws_s3_bucket" "tfstatus-bucket-2" {
  bucket = "tfstatus-bucket"

  tags = {
    Name        = "Status Bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_versioning" "bucket-versioning-2" {
  bucket = aws_s3_bucket.tfstatus-bucket-2.id
  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_dynamodb_table" "terraform_loks-2" {
  hash_key = "LockID"
  name = "terraform_locks-m"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
}