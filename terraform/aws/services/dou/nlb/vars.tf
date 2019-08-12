locals {
  subnets = "${data.terraform_remote_state.vpc.outputs.private_subnets_ids}"
}
