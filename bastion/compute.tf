resource "oci_core_instance" "bastion_instance" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[count.index],"name")}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "${format("bastion ad%d",count.index+1)}"
  image               = "${var.image_ocid}"
  shape               = "${var.bastion_shape}"

  create_vnic_details {
    subnet_id        = "${element(var.bastion_subnet_ids,count.index)}"
    display_name     = "${format("bastion ad%d",count.index+1)}_vnic"
    hostname_label   = "${format("bastion-ad%d",count.index+1)}"
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

  count = "${var.ha_count}"
}
