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

resource "aws_ecs_service" "dou-api" {
    name = "dou-api"
    cluster = local.cluster_id
    task_definition = "${aws_ecs_task_definition.dou-api.arn}"
    desired_count = 2

    network_configuration {
        subnets = local.subnets
    }

    load_balancer {
        target_group_arn = local.target_group_arn
        ## todo a variable would be better?
        container_name = "dou-api"
        ## todo a variable would be better?
        container_port = 8080
    }
}
