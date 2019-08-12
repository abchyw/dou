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

  default_action {
    target_group_arn = "${aws_lb_target_group.dou-api-tg.arn}"
    type = "forward"
  }
}

resource "aws_lb_target_group" "dou-api-tg" {
  name = "dou-api-tg"
  vpc_id = local.vpc_id
  port = 8080
  protocol = "TCP"
  tags = {
    Name = "dou-api-tg"
  } 

  health_check {
    enabled = true
    interval = 30
    port = "traffic-port"
    protocol = "HTTP"
    healthy_threshold = 3
    unhealthy_threshold = 3
    path = local.health_check_path
  }
}

