provider "aws" {
  region = "us-east-2"
}

module "webserver-cluster" {
  source = "github.com/eidsonator/terraform-book-modules//services/webserver-cluster?ref=0.0.2"

  cluster_name = "webservers-stage"
  db_remote_state_bucket = "te-terraform-up-and-running-state"
  db_remote_state_key = "stage/data-stores/mysql/terraform.tfstate"
  instance_type = "t2.micro"
  min_size = 2
  max_size = 2
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