terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      version = "~> 2.0"
    }
  }
  backend "s3" {
    bucket = "jurikolo-terraform"
    key = "prod/services/webserver-cluster/terraform.tfstate"
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
  source = "../../../../modules/services/webserver-cluster"

  cluster_name           = var.cluster_name
  db_remote_state_bucket = var.db_remote_state_bucket
  db_remote_state_key    = var.db_remote_state_key

  instance_type        = "t4g.micro"
  min_size             = 2
  max_size             = 10
  enable_autoscaling   = true
  enable_new_user_data = false

  custom_tags = {
    Owner       = "team-foo"
    DeployedBy  = "terraform"
    cost-center = "terraform-book"
  }

}

