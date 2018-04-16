output "nat_ad1_ip_id" {
  value = "${oci_core_private_ip.nat_ad1_instance_private_ip.id}"
}

output "nat_ad1_ip" {
  value = "${data.oci_core_vnic.nat_vnic_ad1.private_ip_address}"
}

