provider "aws" {
  region = "us-east-2"
}

module "webserver-cluster" {
  source = "../../../modules/services/webserver-cluster"

  cluster_name = "webservers-stage"
  db_remote_state_bucket = "te-terraform-up-and-running-state"
  db_remote_state_key = "stage/data-stores/mysql/terraform.tfstate"
}

terraform {
  backend "s3" {
    bucket = "te-terraform-up-and-running-state"
    key = "stage/services/webserver-cluster/terraform.tfstate"
    region = "us-east-2"

    dynamodb_table = "terraform_up_and_running_locks"
    encrypt = true
  }
}