data "oci_identity_availability_domains" "ADs" {
  compartment_id = "${var.tenancy_ocid}"
}

data "template_cloudinit_config" "bastion" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "bastion.yaml"
    content_type = "text/cloud-config"
    content      = "${data.template_file.bastion_cloud_init_file.rendered}"
  }
}

data "template_file" "bastion_cloud_init_file" {
  template = "${file("${path.module}/cloudinit/bastion.template.yaml")}"
}

data "oci_core_vnic" "bastion_vnic_ad1" {
  vnic_id = "${lookup(data.oci_core_vnic_attachments.bastion_vnics_ad1.vnic_attachments[0],"vnic_id")}"
}

data "oci_core_vnic_attachments" "bastion_vnics_ad1" {
  compartment_id      = "${var.compartment_ocid}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  instance_id         = "${oci_core_instance.bastion_ad1_instance.id}"
}
