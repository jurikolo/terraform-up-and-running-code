terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      version = "~> 2.0"
    }
  }
  backend "s3" {
    bucket = "jurikolo-terraform"
    key = "stage/services/webserver-cluster/terraform.tfstate"
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

module "webserver_cluster" {

  # Since the terraform-up-and-running-code repo is open source, we're using an HTTPS URL here. If it was a private
  # repo, we'd instead use an SSH URL (git@github.com:brikis98/terraform-up-and-running-code.git) to leverage SSH auth
  source = "github.com/brikis98/terraform-up-and-running-code//code/terraform/04-terraform-module/module-example/modules/services/webserver-cluster?ref=v0.1.0"

  cluster_name           = var.cluster_name
  db_remote_state_bucket = var.db_remote_state_bucket
  db_remote_state_key    = var.db_remote_state_key

  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 2
}

resource "aws_security_group_rule" "allow_testing_inbound" {
  type              = "ingress"
  security_group_id = module.webserver_cluster.alb_security_group_id

  from_port   = 12345
  to_port     = 12345
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
