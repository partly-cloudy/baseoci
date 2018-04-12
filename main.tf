module "vcn" {
  source           = "./vcn"
  compartment_ocid = "${var.compartment_ocid}"
  tenancy_ocid     = "${var.tenancy_ocid}"
  vcn_dns_name     = "${var.vcn_dns_name}"
  label_prefix     = "${var.label_prefix}"
  vcn_cidr         = "${var.vcn_cidr}"
}

module "bastion" {
  source           = "./bastion"
  tenancy_ocid     = "${var.tenancy_ocid}"
  compartment_ocid = "${var.compartment_ocid}"
  ssh_public_key   = "${var.public_key}"
  image_ocid       = "${var.imageocids[var.region]}"
  base_vcn_id      = "${module.vcn.vcn_id}"
  vcn_dhcp_id      = "${module.vcn.vcn_dhcp_id}"
  bastion_shape    = "${var.bastion_shape}"
  bastion_cidr_ad1 = "${cidrsubnet(var.vcn_cidr,8,1)}"
  ig_route_id      = "${module.vcn.ig_route_id}"
}

module "nat" {
  source           = "./nat"
  tenancy_ocid     = "${var.tenancy_ocid}"
  compartment_ocid = "${var.compartment_ocid}"
  ssh_public_key   = "${var.public_key}"
  image_ocid       = "${var.imageocids[var.region]}"
  vcn_cidr         = "${var.vcn_cidr}"
  base_vcn_id      = "${module.vcn.vcn_id}"
  vcn_dhcp_id      = "${module.vcn.vcn_dhcp_id}"
  nat_shape        = "${var.nat_shape}"
  nat_cidr_ad1     = "${cidrsubnet(var.vcn_cidr,8,2)}"
  ig_route_id      = "${module.vcn.ig_route_id}"
}

# sample redis 
module "redis" {
  source               = "./redis"
  tenancy_ocid         = "${var.tenancy_ocid}"
  compartment_ocid     = "${var.compartment_ocid}"
  ssh_public_key       = "${var.public_key}"
  ssh_private_key_path = "${var.private_key_path}"
  image_ocid           = "${var.imageocids[var.region]}"
  vcn_cidr             = "${var.vcn_cidr}"
  base_vcn_id          = "${module.vcn.vcn_id}"
  vcn_dhcp_id          = "${module.vcn.vcn_dhcp_id}"
  redis_shape          = "${var.redis_shape}"
  redis_password       = "${var.redis_password}"
  redis_cidr_ad1       = "${cidrsubnet(var.vcn_cidr,8,3)}"
  nat_instance_ip_id   = "${module.nat.nat_instance_ad1_ip_id}"
  bastion_ip           = "${module.bastion.bastion_ad1_ip}"
  nat_route_id         = "${module.nat.nat_private_route_id}"
}
