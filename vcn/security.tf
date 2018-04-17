# Protocols are specified as protocol numbers.
# http://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml

resource "oci_core_security_list" "bastion_seclist" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "Bastion Security List"
  vcn_id         = "${oci_core_virtual_network.base_vcn.id}"

  egress_security_rules = [
    {
      protocol    = "all"
      destination = "0.0.0.0/0"
    },
  ]

  ingress_security_rules = [
    {
      #ssh
      protocol = "6"
      source   = "0.0.0.0/0"

      tcp_options {
        "min" = 22
        "max" = 22
      }
    },
  ]
}

resource "oci_core_security_list" "nat_seclist" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "NAT Security List"
  vcn_id         = "${oci_core_virtual_network.base_vcn.id}"

  egress_security_rules = [
    {
      protocol    = "all"
      destination = "0.0.0.0/0"
    },
  ]

  ingress_security_rules = [
    {
      protocol = "all"
      source   = "${var.vcn_cidr}"
    },
  ]
}

resource "oci_core_security_list" "redis_seclist" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "redis Security List"
  vcn_id         = "${oci_core_virtual_network.base_vcn.id}"

  egress_security_rules = [{
    protocol    = "all"
    destination = "0.0.0.0/0"
  }]

  ingress_security_rules = [
    {
      # ssh
      protocol = "6"

      tcp_options {
        "max" = 22
        "min" = 22
      }

      source = "${var.vcn_cidr}"
    },
    {
      # redis
      protocol = "6"

      tcp_options {
        "max" = 6379
        "min" = 6379
      }

      source = "${var.vcn_cidr}"
    },
    {
      # sentinel
      protocol = "6"

      tcp_options {
        "max" = 26379
        "min" = 26379
      }

      source = "${var.vcn_cidr}"
    },
  ]
}