resource "oci_core_subnet" "bastion_subnet_ad1" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block          = "${cidrsubnet(var.vcn_cidr,var.newbits,lookup(var.subnets,"bastion"))}"
  display_name        = "bastion subnet ad1"
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.base_vcn.id}"
  route_table_id      = "${oci_core_route_table.ig_route.id}"
  security_list_ids   = ["${oci_core_security_list.bastion_seclist.id}"]
  dhcp_options_id     = "${oci_core_virtual_network.base_vcn.default_dhcp_options_id}"
  dns_label           = "bastion1"
}

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
