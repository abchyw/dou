variable "bucket_name" {
}

data "template_file" "codebuild_policy" {
  template = file("./codebuild_policy.json")
  vars = {
      front_bucket_arn = local.front_bucket_arn
  }
}

data "terraform_remote_state" "front_s3" {
    backend = "s3"
    config = {
        bucket = var.bucket_name
        key = "env:/${terraform.workspace}/state/aws/services/front/dou/s3.tfstate"
        region = "ap-northeast-1"
    }
}
