data "template_file" "cf_origin_access_identity_policy" {
    template = file("./policies/front-bucket-policy.json")

    vars = {
        bucket_name  = local.front_bucket_name
        // no origin access identity at this moment
    }
}