provider "aws" {
  region = "ap-northeast-1"
  version = "2.23.0"
}

terraform {
  backend "s3" {
  }
}
resource "aws_ecs_task_definition" "dou-api" {
  family = "dou-api"
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu = 512
  memory = 1024
  container_definitions = "${file("./container_definition.json")}"

  tags = {
      Name = "dou-api"
  }
}
