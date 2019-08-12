provider "aws" {
  region = "ap-northeast-1"
  version = "2.23.0"
}

terraform {
  backend "s3" {
  }
}
resource "aws_lb" "dou-nlb" {
  name = "dou-nlb"
  internal = true
  load_balancer_type = "network"
  subnets = local.subnets
  
  tags = {
      Name = "dou-nlb"
  }
}

resource "aws_lb_listener" "dou-api" {
  load_balancer_arn = "${aws_lb.dou-nlb.arn}"
  port = 80
  protocol = "TCP"
}

# resource "aws_lb_target_group" "dou-api-tg" {
#   port = 8080
#   protocol = "TCP"
#   tags = {
#     Name = "dou-api-tg"
#   } 
# }

