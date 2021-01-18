provider "aws" {
  region = "us-east-2"
}

module "database" {
  source = "../../../modules/data-stores/mysql/"

  database_name = "database_stage"
  # db_remote_state_bucket = "te-terraform-up-and-running-state"
  # db_remote_state_key = "stage/data-stores/mysql/terraform.tfstate"
  db_password = var.db_password
}

terraform {
  backend "s3" {
      bucket = "te-terraform-up-and-running-state"
      key = "stage/data-stores/mysql/terraform.tfstate"
      region = "us-east-2"

      dynamodb_table = "terraform_up_and_running_locks"
      encrypt = true
  }
}