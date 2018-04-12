output "redis_ad1_ip" {
  value = "${data.oci_core_vnic.redis_master_vnic_ad1.private_ip_address}"
}

output "redis_ad1_ocid" {
  value = "${data.oci_core_vnic.redis_master_vnic_ad1.id}"
}
