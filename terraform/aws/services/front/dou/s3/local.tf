locals {
  front_bucket_name = "dou-front"

  versioning = lookup(local.env_versioning, terraform.workspace, local.env_versioning["default"])
  env_versioning = {
      default = false
      dev = false
      prd = true
  }
}
