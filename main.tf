resource "aws_vpc" "vpc" {
    cidr_block = "${var.vpc_cidr}"
    tags {
        Name = "${var.vpc_tag}"
    }
}

resource "aws_subnet" "subnet_public" {
    vpc_id = "${aws_vpc.vpc.id}"
    count = "${length(data.aws_availability_zones.available.names)}"
    cidr_block = "${cidrsubnet(var.vpc_cidr, 4, count.index)}"
    availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
    map_public_ip_on_launch = true
    tags {
        Name = "${var.vpc_tag} Public"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.vpc.id}"
    tags {
        Name = "${var.vpc_tag}"
    }
}

resource "aws_route" "public_route" {
    route_table_id         = "${aws_vpc.vpc.main_route_table_id}"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = "${aws_internet_gateway.igw.id}"
}

resource "aws_subnet" "subnet_private" {
    vpc_id = "${aws_vpc.vpc.id}"
    count = "${length(data.aws_availability_zones.available.names)}"
    cidr_block = "${cidrsubnet(var.vpc_cidr, 4, count.index)}"
    availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
    map_public_ip_on_launch = false
    tags {
        Name = "${var.vpc_tag} Private"
    }
}

resource "aws_eip" "nat_gw" {
  vpc      = true
}

resource "aws_nat_gateway" "nat_gw" {
    allocation_id = "${aws_eip.nat_gw.id}"
    subnet_id = "${aws_subnet.subnet_public.0.id}"
}

resource "aws_route_table" "private" {
    vpc_id = "${aws_vpc.vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.nat_gw.id}"
    }
    tags {
        Name = "${var.vpc_tag} Private"
    }
}

resource "aws_route_table_association" "private_subnet" {
    count = "${length(data.aws_availability_zones.available.names)}"
    subnet_id = "${element(aws_subnet.subnet_private.*.id, count.index)}"
    route_table_id = "${aws_route_table.private.id}"
}
