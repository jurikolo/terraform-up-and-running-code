terraform {
  required_version = ">= 0.13"
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

resource "aws_instance" "app" {
  instance_type     = "t4g.micro"
  availability_zone = "eu-central-1a"
  ami               = "ami-016f4f002606a1417"

  user_data = <<-EOF
              #!/bin/bash
              sudo service apache2 start
              EOF
}

