locals {
  subnets = "${data.terraform_remote_state.vpc.outputs.private_subnets_ids}"
  vpc_id = "${data.terraform_remote_state.vpc.outputs.vpc_id}"
  health_check_path = "/actuator/health"
}
