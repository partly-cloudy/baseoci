output "bastion_ad1_ip" {
  value = "${data.oci_core_vnic.bastion_vnic_ad1.public_ip_address}"
}
