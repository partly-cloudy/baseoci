# output "ssh_through_bastion" {
#   value = "ssh -J opc@${module.bastion.bastion_ad1_ip} opc@<instance_ip_address>"
# }
# output "bastion_ips" {
#   value = "${concat(module.bastion.bastion_ips)}"
# }
# output "nat_ips" {
#   value = "${module.nat.nat_ad1_ip}"
# }
# output "redis_ips" {
#   value = "${module.redis.redis_ad1_ip}"
# }
# output "ssh_to_redis" {
#   value = "ssh -J opc@${module.bastion.bastion_ad1_ip} opc@${module.redis.redis_ad1_ip}"
# }

output "bastion_ips" {
  value = "${module.bastion.bastion_ips}"
}

output "nat_ips" {
  value = "${module.nat.nat_ips}"
}
