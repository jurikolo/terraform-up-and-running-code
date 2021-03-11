terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      version = "~> 2.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "jurikolo-terraform"
    key = "stage/data-stores/mysql/terraform.tfstate"
    region = "eu-central-1"
    dynamodb_table = "jurikolo-terraform"
    encrypt = true
    profile = "terraform"
  }
}

provider "aws" {
  region = "eu-central-1"
  profile = "terraform"
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-up-and-running"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"

  username            = "admin"

  name                = var.db_name
  skip_final_snapshot = true

  password            = var.db_password

  tags = {
    cost-center = "terraform-book"
  }
}

