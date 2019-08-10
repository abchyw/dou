provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_vpc" "dou-vpc"{
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
      Name = "dou"
  }
}

resource "aws_subnet" "public-subnet" {
  count = local.subnet_count
  vpc_id = "${aws_vpc.dou-vpc.id}"
  cidr_block = cidrsubnet("${aws_vpc.dou-vpc.cidr_block}", 8, "${count.index}")
  availability_zone = local.availablility_zones[count.index]

  tags = {
    Name = "public-subnet-${count.index}"
  }
}

resource "aws_subnet" "private-subnet" {
  count = local.subnet_count
  vpc_id = "${aws_vpc.dou-vpc.id}"
  cidr_block = cidrsubnet("${aws_vpc.dou-vpc.cidr_block}", 8, 2 + "${count.index}")
  availability_zone = local.availablility_zones[count.index]

  tags = {
    Name = "private-subnet-${count.index}"
  }
}