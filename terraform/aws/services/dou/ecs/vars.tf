locals {
  cluster_id = "${data.terraform_remote_state.ecs_cluster.outputs.app_cluster_id}"
  target_group_arn = "${data.terraform_remote_state.nlb.outputs.dou-api-tg-arn}"
  subnets = "${data.terraform_remote_state.vpc.outputs.private_subnets_ids}"
}
