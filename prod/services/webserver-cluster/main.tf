provider "aws" {
  region = "us-east-2"
}

module "webserver-cluster" {
  source = "../../../modules/services/webserver-cluster"

  cluster_name = "webservers-prod"
  db_remote_state_bucket = "te-terraform-up-and-running-state"
  db_remote_state_key = "prod/data-store/mysql/terraform.tfstate"
}