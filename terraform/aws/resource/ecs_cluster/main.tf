provider "aws" {
  region = "ap-northeast-1"
  version = "2.23.0"
}

terraform {
  backend "s3" {
  }
}
resource "aws_ecs_cluster" "app_cluster" {
  name = "app_cluster"
}
