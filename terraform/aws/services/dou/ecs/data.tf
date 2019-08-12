variable "bucket_name" {
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = var.bucket_name
    key    = "env:/${terraform.workspace}/state/aws/resource/vpc.tfstate"
    region = "ap-northeast-1"
  }
}

data "terraform_remote_state" "ecs_cluster" {
  backend = "s3"

  config = {
    bucket = var.bucket_name
    key    = "env:/${terraform.workspace}/state/aws/resource/ecs_cluster.tfstate"
    region = "ap-northeast-1"
  }
}

data "terraform_remote_state" "nlb" {
  backend = "s3"

  config = {
    bucket = var.bucket_name
    key    = "env:/${terraform.workspace}/state/aws/services/dou/nlb.tfstate"
    region = "ap-northeast-1"
  }
}