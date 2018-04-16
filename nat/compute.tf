resource "oci_core_instance" "nat_ad1_instance" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "nat_ad1"
  image               = "${var.image_ocid}"
  shape               = "${var.nat_shape}"

  create_vnic_details {
    subnet_id              = "${var.nat_subnet_id}"
    display_name           = "nat_ad1_vnic"
    hostname_label         = "nat-ad1"
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
}

# Create PrivateIP
resource "oci_core_private_ip" "nat_ad1_instance_private_ip" {
  vnic_id      = "${lookup(data.oci_core_vnic_attachments.nat_vnics_ad1.vnic_attachments[0],"vnic_id")}"
  display_name = "Nat AD 1 Instance Private IP"
}
