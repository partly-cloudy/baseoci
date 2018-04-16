resource "oci_core_subnet" "redis_subnet_ad1" {
  availability_domain        = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block                 = "${cidrsubnet(var.vcn_cidr,var.newbits,lookup(var.subnets,"redis"))}"
  display_name               = "redis subnet ad1"
  compartment_id             = "${var.compartment_ocid}"
  vcn_id                     = "${oci_core_virtual_network.base_vcn.id}"
  route_table_id             = "${oci_core_route_table.nat_private_route_table.id}"
  security_list_ids          = ["${oci_core_security_list.redis_seclist.id}"]
  dhcp_options_id            = "${oci_core_virtual_network.base_vcn.default_dhcp_options_id}"
  prohibit_public_ip_on_vnic = "true"
  dns_label                  = "redis1"
}

# Protocols are specified as protocol numbers.
# http://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml

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
