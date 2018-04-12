output "ssh_through_bastion" {
  value = "ssh -J opc@<bastion_ip_address> opc@<instance_ip_address>"
}

output "bastion_ips" {
  value = "${module.bastion.bastion_ad1_ip}"
}

output "nat_ips" {
  value = "${module.nat.nat_ad1_ip}"
}

output "redis_ips" {
  value = "${module.redis.redis_ad1_ip}"
}

output "ssh_to_redis" {
  value = "ssh -J opc@${module.bastion.bastion_ad1_ip} opc@${module.redis.redis_ad1_ip}"
}
