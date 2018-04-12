resource "oci_core_virtual_network" "base_vcn" {
  cidr_block     = "${var.vcn_cidr}"
  compartment_id = "${var.compartment_ocid}"
  display_name   = "OCIBase VCN"
  dns_label      = "${var.vcn_dns_name}"
}

resource "oci_core_internet_gateway" "base_ig" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "OCIBase IG"
  vcn_id         = "${oci_core_virtual_network.base_vcn.id}"
}

resource "oci_core_route_table" "ig_route" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_virtual_network.base_vcn.id}"
  display_name   = "ig route"

  route_rules {
    cidr_block        = "0.0.0.0/0"
    network_entity_id = "${oci_core_internet_gateway.base_ig.id}"
  }
}
