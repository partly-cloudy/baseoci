output "bastion_subnet_ids" {
  value = "${oci_core_subnet.bastion_subnets.*.id}"
}

output "nat_subnet_ids" {
  value = "${oci_core_subnet.nat_subnets.*.id}"
}

# output "redis_subnet_ids" {
#   value = "${oci_core_subnet.redis_subnets.*.id}"
# }

