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

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.dou-vpc.id}"
}

resource "aws_eip" "eip" {
  count = local.subnet_count
  vpc = true

  tags = {
    Name = "eip-${count.index}"
  }
}

resource "aws_nat_gateway" "ngw" {
  count = local.subnet_count
  allocation_id = "${aws_eip.eip[count.index].id}"
  subnet_id = "${aws_subnet.private-subnet[count.index].id}"
  
  tags = {
    Name = "nat-gateway-${count.index}"
  }
}

# routing
resource "aws_route_table" "public-route-table" {
  vpc_id = "${aws_vpc.dou-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  } 

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public-rta" {
  count = local.subnet_count
  subnet_id = "${aws_subnet.public-subnet[count.index].id}"
  route_table_id = "${aws_route_table.public-route-table.id}"
}

resource "aws_route_table" "private-route-table" {
  count = local.subnet_count
  vpc_id = "${aws_vpc.dou-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.ngw[count.index].id}"
  }

  tags = {
    Name = "private-route-table-${count.index}"
  }
}

resource "aws_route_table_association" "private-rta" {
  count = local.subnet_count
  subnet_id = "${aws_subnet.private-subnet[count.index].id}"
  route_table_id = "${aws_route_table.private-route-table[count.index].id}"
}
