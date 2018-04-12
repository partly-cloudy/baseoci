resource "oci_core_instance" "bastion_ad1_instance" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "bastion_ad1"
  image               = "${var.image_ocid}"
  shape               = "${var.bastion_shape}"

  create_vnic_details {
    subnet_id        = "${oci_core_subnet.bastion_subnet_ad1.id}"
    display_name     = "bastion_ad1_vnic"
    hostname_label   = "bastion-ad1"
    assign_public_ip = "true"
  }

  extended_metadata {
    ssh_authorized_keys = "${var.ssh_public_key}"
    user_data           = "${data.template_cloudinit_config.bastion.rendered}"
    tags                = "group:bastion"
  }

  timeouts {
    create = "60m"
  }
}
