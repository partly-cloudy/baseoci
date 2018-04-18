resource "oci_core_instance" "nat_instance" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[count.index],"name")}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "${format("nat ad%d",count.index+1)}"
  image               = "${var.image_ocid}"
  shape               = "${var.nat_shape}"

  create_vnic_details {
    subnet_id              = "${element(var.nat_subnet_ids,count.index)}"
    display_name           = "${format("bastion ad%d",count.index+1)}_vnic"
    hostname_label         = "${format("bastion-ad%d",count.index+1)}"
    skip_source_dest_check = true
  }

  extended_metadata {
    ssh_authorized_keys = "${var.ssh_public_key}"
    user_data           = "${data.template_cloudinit_config.nat.rendered}"
    tags                = "group:nat"
  }

  timeouts {
    create = "60m"
  }

  count = "${var.ha_count}"
}

# Create PrivateIP
resource "oci_core_private_ip" "nat_ad1_instance_private_ip" {
  vnic_id      = "${lookup(data.oci_core_vnic_attachments.nat_vnics_attachments_ad1.vnic_attachments[0],"vnic_id")}"
  display_name = "nat AD 1 Instance Private IP"
}

# Create PrivateIP
resource "oci_core_private_ip" "nat_ad2_instance_private_ip" {
  vnic_id      = "${lookup(data.oci_core_vnic_attachments.nat_vnics_attachments_ad2.vnic_attachments[0],"vnic_id")}"
  display_name = "nat AD 2 Instance Private IP"
}
