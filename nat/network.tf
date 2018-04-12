resource "oci_core_subnet" "nat_subnet_ad1" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block          = "${var.nat_cidr_ad1}"
  display_name        = "nat subnet ad1"
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${var.base_vcn_id}"
  route_table_id      = "${var.ig_route_id}"
  security_list_ids   = ["${oci_core_security_list.nat_seclist.id}"]
  dhcp_options_id     = "${var.vcn_dhcp_id}"
  dns_label           = "nat1"
}

resource "oci_core_route_table" "nat_private_route_table" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${var.base_vcn_id}"
  display_name   = "nat private route"

  route_rules {
    cidr_block        = "0.0.0.0/0"
    network_entity_id = "${oci_core_private_ip.nat_ad1_instance_private_ip.id}"
  }
}
