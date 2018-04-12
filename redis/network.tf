resource "oci_core_subnet" "redis_subnet_ad1" {
  availability_domain        = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block                 = "${var.redis_cidr_ad1}"
  display_name               = "redis subnet ad1"
  compartment_id             = "${var.compartment_ocid}"
  vcn_id                     = "${var.base_vcn_id}"
  route_table_id             = "${var.nat_route_id}"
  security_list_ids          = ["${oci_core_security_list.redis_seclist.id}"]
  dhcp_options_id            = "${var.vcn_dhcp_id}"
  prohibit_public_ip_on_vnic = "true"
  dns_label                  = "redis1"
}
