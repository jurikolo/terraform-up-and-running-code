terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
      version = "~> 2.0"
    }
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

