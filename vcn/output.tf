output "bastion_subnet_id" {
  value = "${oci_core_subnet.bastion_subnet_ad1.id}"
}

output "nat_subnet_id" {
  value = "${oci_core_subnet.nat_subnet_ad1.id}"
}

output "nat_private_route_id" {
  value = "${oci_core_route_table.nat_private_route_table.id}"
}

output "redis_subnet_id" {
  value = "${oci_core_subnet.redis_subnet_ad1.id}"
}
