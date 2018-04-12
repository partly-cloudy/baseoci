data "oci_identity_availability_domains" "ADs" {
  compartment_id = "${var.tenancy_ocid}"
}

data "template_cloudinit_config" "nat" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "nat.yaml"
    content_type = "text/cloud-config"
    content      = "${data.template_file.nat_cloud_init_file.rendered}"
  }
}

data "template_file" "nat_cloud_init_file" {
  template = "${file("${path.module}/cloudinit/nat.template.yaml")}"
}

# Gets a list of VNIC attachments on the nat instance
data "oci_core_vnic_attachments" "nat_vnics_ad1" {
  compartment_id      = "${var.compartment_ocid}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  instance_id         = "${oci_core_instance.nat_ad1_instance.id}"
}

data "oci_core_vnic" "nat_vnic_ad1" {
  vnic_id = "${lookup(data.oci_core_vnic_attachments.nat_vnics_ad1.vnic_attachments[0],"vnic_id")}"
}