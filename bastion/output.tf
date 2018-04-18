output "bastion_ips" {
  value = "${list(data.oci_core_vnic.bastion_vnic_ad1.public_ip_address,data.oci_core_vnic.bastion_vnic_ad2.public_ip_address)}"
}
