provider "aws" {
  region = "ap-northeast-1"
  version = "2.23.0"
}

resource "aws_ecs_task_definition" "dou-api" {
  family = "dou-api"
  network_mode = "awsvpc"
  container_definitions = "${file("./container_definition.json")}"

  tags = {
      Name = "dou-api"
  }
}
