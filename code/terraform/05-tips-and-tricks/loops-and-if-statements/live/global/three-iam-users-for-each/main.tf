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

resource "aws_iam_user" "example" {
  for_each = toset(var.user_names)
  name     = each.value
}

