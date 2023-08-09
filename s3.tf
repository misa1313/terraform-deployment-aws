provider "aws" {
  region     = var.access[2]
}

variable "access" {
  type = list(string)
}

resource "aws_vpc" "vpc-2" {
  cidr_block       = "10.245.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = "true"
  tags = {
    Name = "vpc-2"
  }
}

resource "aws_s3_bucket" "webserver-config-2" {
  bucket = "webserver-config-bucket"

  tags = {
    Name        = "Webserver Bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_object" "playbook-2" {
  bucket = aws_s3_bucket.webserver-config-2.id
  key    = "webserver-play.yaml"
  source = "webserver-play.yaml"
}

resource "aws_s3_object" "index-2" {
  bucket = aws_s3_bucket.webserver-config-2.id
  key    = "index.html"
  source = "index.html"
}

resource "aws_sns_topic" "sns_updates-2" {
  name = "sns-updates-topic"
}



