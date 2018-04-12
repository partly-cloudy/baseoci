resource "oci_core_instance" "redis_master_ad1" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "redis master ad1"
  image               = "${var.image_ocid}"
  shape               = "${var.redis_shape}"

  create_vnic_details {
    subnet_id        = "${oci_core_subnet.redis_subnet_ad1.id}"
    display_name     = "redis_master_ad1_vnic"
    hostname_label   = "redis-master-ad1"
    assign_public_ip = "false"
  }

  extended_metadata {
    ssh_authorized_keys = "${var.ssh_public_key}"
    user_data           = "${data.template_cloudinit_config.redis_master.rendered}"
    tags                = "group:redis"
  }

  timeouts {
    create = "60m"
  }
}

resource "null_resource" "delay_master" {
  triggers {
    instance_id = "${oci_core_instance.redis_master_ad1.id}"
  }

  connection {
    type        = "ssh"
    host        = "${data.oci_core_vnic.redis_master_vnic_ad1.private_ip_address}"
    user        = "opc"
    private_key = "${file(var.ssh_private_key_path)}"
    timeout     = "40m"

    bastion_host        = "${var.bastion_ip}"
    bastion_user        = "opc"
    bastion_private_key = "${file(var.ssh_private_key_path)}"
  }

  #  https://github.com/hashicorp/terraform/issues/4668
  provisioner "remote-exec" {
    inline = [
      "while [ ! -f /home/opc/redis.finish ]; do sleep 10; done",
    ]
  }
}

resource null_resource "configure_redis_bind_master_ip" {
  depends_on = ["null_resource.delay_master"]

  connection {
    type        = "ssh"
    host        = "${data.oci_core_vnic.redis_master_vnic_ad1.private_ip_address}"
    user        = "opc"
    private_key = "${file(var.ssh_private_key_path)}"
    timeout     = "40m"

    bastion_host        = "${var.bastion_ip}"
    bastion_user        = "opc"
    bastion_private_key = "${file(var.ssh_private_key_path)}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo sed -i s/127.0.0.1/${data.oci_core_vnic.redis_master_vnic_ad1.private_ip_address}/ /root/redis/redis.conf",
      "sudo sed -i  s/127.0.0.1/${data.oci_core_vnic.redis_master_vnic_ad1.private_ip_address}/ /root/redis/redis-sentinel.conf",
      "sudo cp /root/redis/redis.conf /etc/redis.conf",
      "sudo cp /root/redis/redis-sentinel.conf /etc/redis-sentinel.conf",
      "sudo systemctl enable redis redis-sentinel",
      "sudo systemctl start redis redis-sentinel",
    ]
  }
}
