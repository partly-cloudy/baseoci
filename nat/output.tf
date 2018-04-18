output "nat_ips" {
  value = "${list(data.oci_core_vnic.nat_vnic_ad1.private_ip_address,data.oci_core_vnic.nat_vnic_ad2.private_ip_address)}"
}

output "nat_ip_ids" {
  value = "${list(oci_core_private_ip.nat_ad1_instance_private_ip.id,oci_core_private_ip.nat_ad2_instance_private_ip.id)}"
}
