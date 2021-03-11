terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      version = "~> 2.0"
    }
  }
  backend "s3" {
    bucket = "jurikolo-terraform"
    key = "global/s3/terraform.tfstate"
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

resource "aws_instance" "example" {
  ami           = "ami-016f4f002606a1417"
  instance_type = "t4g.micro"

  tags = {
    Name = "terraform-example"
  }
}

