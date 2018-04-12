# Protocols are specified as protocol numbers.
# http://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml

resource "oci_core_security_list" "redis_seclist" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "redis Security List"
  vcn_id         = "${var.base_vcn_id}"

  egress_security_rules = [{
    protocol    = "all"
    destination = "0.0.0.0/0"
  }]

  ingress_security_rules = [
    {
      protocol = "6"

      tcp_options {
        "max" = 22
        "min" = 22
      }

      source = "${var.vcn_cidr}"
    },
    {
      protocol = "6"

      tcp_options {
        "max" = 6379
        "min" = 6379
      }

      source = "${var.vcn_cidr}"
    },
    {
      protocol = "6"

      tcp_options {
        "max" = 26379
        "min" = 26379
      }

      source = "${var.vcn_cidr}"
    },
  ]
}
