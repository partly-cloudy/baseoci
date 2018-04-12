data "oci_identity_availability_domains" "ADs" {
  compartment_id = "${var.tenancy_ocid}"
}

# common master and slave files
data "template_file" "redis_xml" {
  template = "${file("${path.module}/resources/redis.xml")}"
}

data "template_file" "redis_sentinel_xml" {
  template = "${file("${path.module}/resources/redis-sentinel.xml")}"
}

data "template_file" "redis_sentinel_conf" {
  template = "${file("${path.module}/resources/redis-sentinel.conf")}"
}

# master
data "oci_core_vnic" "redis_master_vnic_ad1" {
  vnic_id = "${lookup(data.oci_core_vnic_attachments.redis_master_vnics_ad1.vnic_attachments[0],"vnic_id")}"
}

data "oci_core_vnic_attachments" "redis_master_vnics_ad1" {
  compartment_id      = "${var.compartment_ocid}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  instance_id         = "${oci_core_instance.redis_master_ad1.id}"
}

data "template_file" "redis_master_conf" {
  template = "${file("${path.module}/resources/redis-master.conf")}"
}

data "template_file" "setup_redis_master_template" {
  template = "${file("${path.module}/scripts/setup_redis_master.template.sh")}"

  vars = {
    redis_password = "${var.redis_password}"
  }
}

data "template_file" "setup_redis_master_sentinel_template" {
  template = "${file("${path.module}/scripts/setup_redis_master_sentinel.template.sh")}"

  vars = {
    redis_password = "${var.redis_password}"
  }
}

data "template_file" "redis_master_cloud_init_file" {
  template = "${file("${path.module}/cloudinit/redis_master.template.yaml")}"

  vars = {
    setup_redis_master_sh_content       = "${base64gzip(data.template_file.setup_redis_master_template.rendered)}"
    setup_redis_master_sentinel_content = "${base64gzip(data.template_file.setup_redis_master_sentinel_template.rendered)}"
    redis_master_conf_content           = "${base64gzip(data.template_file.redis_master_conf.rendered)}"
    redis_sentinel_conf_content         = "${base64gzip(data.template_file.redis_sentinel_conf.rendered)}"
    redis_xml_content                   = "${base64gzip(data.template_file.redis_xml.rendered)}"
    redis_sentinel_xml_content          = "${base64gzip(data.template_file.redis_sentinel_xml.rendered)}"
  }
}

data "template_cloudinit_config" "redis_master" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "redis.yaml"
    content_type = "text/cloud-config"
    content      = "${data.template_file.redis_master_cloud_init_file.rendered}"
  }
}
