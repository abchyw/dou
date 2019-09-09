locals {
  source_repository = "https://github.com/abchyw/dou"
  assume_role_policy = file("./assume_role_policy.json")
  codebuild_policy = data.template_file.codebuild_policy.rendered
  front_bucket_arn = data.terraform_remote_state.front_s3.outputs.front_dou_bucket_arn
}
