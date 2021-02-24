provider "aws" {
  region = "us-east-2"
}

module "database" {
  source = "github.com/eidsonator/terraform-book-modules//data-stores/mysql?ref=0.0.2"

  database_name = "database_prod"
  db_password = var.db_password
}

terraform {
  backend "s3" {
      bucket = "te-terraform-up-and-running-state"
      key = "prod/data-stores/mysql/terraform.tfstate"
      region = "us-east-2"

      dynamodb_table = "terraform_up_and_running_locks"
      encrypt = true
  }
}