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