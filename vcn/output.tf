output "vcn_id" {
  value = "${oci_core_virtual_network.base_vcn.id}"
}

output "vcn_dhcp_id" {
  value = "${oci_core_virtual_network.base_vcn.default_dhcp_options_id}"
}

output "base_ig_id" {
  value = "${oci_core_internet_gateway.base_ig.id}"
}

output "ig_route_id" {
  value = "${oci_core_route_table.ig_route.id}"
}
