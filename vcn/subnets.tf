resource "oci_core_subnet" "bastion_subnet_ad1" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block          = "${cidrsubnet(var.vcn_cidr,var.newbits,var.subnets["bastion"])}"
  display_name        = "bastion subnet ad1"
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.base_vcn.id}"
  route_table_id      = "${oci_core_route_table.ig_route.id}"
  security_list_ids   = ["${oci_core_security_list.bastion_seclist.id}"]
  dhcp_options_id     = "${oci_core_virtual_network.base_vcn.default_dhcp_options_id}"
  dns_label           = "bastion1"
}

resource "oci_core_subnet" "nat_subnet_ad1" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block          = "${cidrsubnet(var.vcn_cidr,var.newbits,var.subnets["nat"])}"
  display_name        = "nat subnet ad1"
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.base_vcn.id}"
  route_table_id      = "${oci_core_route_table.ig_route.id}"
  security_list_ids   = ["${oci_core_security_list.nat_seclist.id}"]
  dhcp_options_id     = "${oci_core_virtual_network.base_vcn.default_dhcp_options_id}"
  dns_label           = "nat1"
}

resource "oci_core_subnet" "redis_subnet_ad1" {
  availability_domain        = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block                 = "${cidrsubnet(var.vcn_cidr,var.newbits,var.subnets["redis"])}"
  display_name               = "redis subnet ad1"
  compartment_id             = "${var.compartment_ocid}"
  vcn_id                     = "${oci_core_virtual_network.base_vcn.id}"
  route_table_id             = "${oci_core_route_table.nat_private_route_table.id}"
  security_list_ids          = ["${oci_core_security_list.redis_seclist.id}"]
  dhcp_options_id            = "${oci_core_virtual_network.base_vcn.default_dhcp_options_id}"
  prohibit_public_ip_on_vnic = "true"
  dns_label                  = "redis1"
}
