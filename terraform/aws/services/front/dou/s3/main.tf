provider "aws" {
  region = "ap-northeast-1"
  version = "2.23.0"
}

terraform {
  backend "s3" {
  }
}

resource "aws_s3_bucket" "front" {
   bucket = local.front_bucket_name 
   acl = "private"
   policy = data.template_file.cf_origin_access_identity_policy.rendered

   website {
     index_document = "index.html"
     error_document = "index.html"
   }

   versioning {
     enabled = local.versioning
   }

   tags = {
       Names = "dou-front"
   }
}
