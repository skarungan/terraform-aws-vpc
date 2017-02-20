output "vpc_cidr" {
  value = "${aws_vpc.vpc.cidr_block}"
}

output "nat_eip" {
  value = "${aws_eip.nat_gw.public_ip}"
}

output "public_subnets" {
  value = "${join(",",aws_subnet.subnet_public.*.id)}"
}

output "private_subnets" {
  value = "${join(",",aws_subnet.subnet_private.*.id)}"
}

output "main_route_table" {
  value = "${aws_vpc.vpc.main_route_table_id}"
}

output "private_route_table" {
  value = "${aws_route_table.private.id}"
}
