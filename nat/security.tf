# Protocols are specified as protocol numbers.
# http://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml

resource "oci_core_security_list" "nat_seclist" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "NAT Security List"
  vcn_id         = "${var.base_vcn_id}"

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
