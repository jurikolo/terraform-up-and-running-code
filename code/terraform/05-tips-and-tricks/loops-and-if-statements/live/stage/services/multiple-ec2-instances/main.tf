terraform {
  required_version = ">= 0.13"
}

provider "aws" {
  region = "eu-central-1"

  # Allow any 2.x version of the AWS provider
  version = "~> 2.0"
}

resource "aws_instance" "example_1" {
  count         = 3
  ami           = "ami-016f4f002606a1417"
  instance_type = "t2.micro"
}

resource "aws_instance" "example_2" {
  count             = length(data.aws_availability_zones.all.names)
  availability_zone = data.aws_availability_zones.all.names[count.index]
  ami               = "ami-016f4f002606a1417"
  instance_type     = "t2.micro"
}

data "aws_availability_zones" "all" {}

