provider "aws" {
  region = "ap-northeast-1"
  version = "2.23.0"
}

terraform {
  backend "s3" {
  }
}

resource "aws_iam_role" "code-build-dou-front-deploy-role" {
  name = "code-build-dou-front-deploy"
  assume_role_policy = local.assume_role_policy

  tags = {
    Name = "code-build-dou-front-deploy"
  }
}

resource "aws_iam_role_policy" "code-build-dou-front-deploy-policy" {
  name = "code-build-dou-front-deploy-policy"
  role = "${aws_iam_role.code-build-dou-front-deploy-role.id}"
  policy = local.codebuild_policy
}


resource "aws_codebuild_project" "dou-front-deploy" {
  name = "dou-front"
  description = "deploy front end."
  service_role = "${aws_iam_role.code-build-dou-front-deploy-role.arn}"

// what is this?
  artifacts {
    type = "NO_ARTIFACTS"
  } 

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image = "aws/codebuild/docker:18.09.0"
    type = "LINUX_CONTAINER"
    privileged_mode = true

    environment_variable {
      name = "BUCKET_NAME"
      value = local.front_bucket_name
    }
  }

  source {
      type = "GITHUB"
      location = local.source_repository
      git_clone_depth = 1
      buildspec = "front/buildspec.yml"
  }

  tags = {
      Name = "code-build-dou-front-deploy"
  }
}
