output "vpc_id" {
  value = "${aws_vpc.dou-vpc.id}"
}

output "private_subnets_ids" {
  value = "${aws_subnet.private-subnet.*.id}"
}