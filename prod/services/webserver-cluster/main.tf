provider "aws" {
  region = "us-east-2"
}

module "webserver_cluster" {
  source = "github.com/eidsonator/terraform-book-modules//services/webserver-cluster"

  cluster_name = "webservers-prod"
  db_remote_state_bucket = "te-terraform-up-and-running-state"
  db_remote_state_key = "prod/data-stores/mysql/terraform.tfstate"

  instance_type = "t2.micro"
  min_size = 2
  max_size = 2

  ami = "ami-0c55b159cbfafe1f0"
  server_text = "hello nobody"

  custom_tags = {
    Owner = "team-foo"
    DeployedBy = "terraform"
  }
}

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  scheduled_action_name = "scale-out-during-business-hours"
  min_size = 2
  max_size = 10
  desired_capacity = 3
  recurrence = "0 9 * * *"

  autoscaling_group_name = module.webserver_cluster.asg_name
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  scheduled_action_name = "scale-in-at-night"
  min_size = 2
  max_size = 10
  desired_capacity = 2
  recurrence = "0 17 * * *"

  autoscaling_group_name = module.webserver_cluster.asg_name
}