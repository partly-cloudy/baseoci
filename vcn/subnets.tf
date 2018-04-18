resource "oci_core_subnet" "bastion_subnets" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[count.index],"name")}"
  cidr_block          = "${cidrsubnet(var.vcn_cidr,var.newbits,var.subnets[format("bastion_ad%d",count.index+1)])}"
  display_name        = "${format("bastion subnet ad%d",count.index+1)}"
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.base_vcn.id}"
  route_table_id      = "${oci_core_route_table.ig_route.id}"
  security_list_ids   = ["${oci_core_security_list.bastion_seclist.id}"]
  dhcp_options_id     = "${oci_core_virtual_network.base_vcn.default_dhcp_options_id}"
  dns_label           = "${format("bastion%d",count.index+1)}"
  count               = "${var.ha_count}"
}

resource "oci_core_subnet" "nat_subnets" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[count.index],"name")}"
  cidr_block          = "${cidrsubnet(var.vcn_cidr,var.newbits,var.subnets[format("nat_ad%d",count.index+1)])}"
  display_name        = "${format("nat subnet ad%d",count.index+1)}"
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.base_vcn.id}"
  route_table_id      = "${oci_core_route_table.ig_route.id}"
  security_list_ids   = ["${oci_core_security_list.nat_seclist.id}"]
  dhcp_options_id     = "${oci_core_virtual_network.base_vcn.default_dhcp_options_id}"
  dns_label           = "${format("nat%d",count.index+1)}"
  count               = "${var.ha_count}"
}

# resource "oci_core_subnet" "redis_subnets" {
#   availability_domain        = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[count.index],"name")}"
#   cidr_block                 = "${cidrsubnet(var.vcn_cidr,var.newbits,var.subnets["redis_ad1"])}"
#   display_name               = "${format("redis subnet ad",count.index+1)}"
#   compartment_id             = "${var.compartment_ocid}"
#   vcn_id                     = "${oci_core_virtual_network.base_vcn.id}"
#   route_table_id             = "${oci_core_route_table.nat_private_route_table.id}"
#   security_list_ids          = ["${oci_core_security_list.redis_seclist.id}"]
#   dhcp_options_id            = "${oci_core_virtual_network.base_vcn.default_dhcp_options_id}"
#   prohibit_public_ip_on_vnic = "true"
#   dns_label                  = "${format("redis",count.index+1)}"
# }

