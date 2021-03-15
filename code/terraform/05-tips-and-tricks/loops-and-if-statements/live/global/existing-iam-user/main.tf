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

resource "aws_iam_user" "existing_user" {
  # You should change this to the username of an IAM user that already
  # exists so you can practice using the terraform import command
  name = "jurijs.kolomijecs"
}

