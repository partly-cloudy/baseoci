module "vcn" {
  source           = "./vcn"
  compartment_ocid = "${var.compartment_ocid}"
  tenancy_ocid     = "${var.tenancy_ocid}"
  vcn_dns_name     = "${var.vcn_dns_name}"
  label_prefix     = "${var.label_prefix}"
  vcn_name         = "${var.vcn_name}"
  vcn_cidr         = "${var.vcn_cidr}"
  newbits          = "${var.newbits}"
  subnets          = "${var.subnets}"
  nat_ad1_ip_id    = "${module.nat.nat_ad1_ip_id}"
}

module "bastion" {
  source            = "./bastion"
  tenancy_ocid      = "${var.tenancy_ocid}"
  compartment_ocid  = "${var.compartment_ocid}"
  ssh_public_key    = "${var.public_key}"
  image_ocid        = "${var.imageocids[var.region]}"
  bastion_subnet_id = "${module.vcn.bastion_subnet_id}"
  bastion_shape     = "${var.bastion_shape}"
}

module "nat" {
  source           = "./nat"
  tenancy_ocid     = "${var.tenancy_ocid}"
  compartment_ocid = "${var.compartment_ocid}"
  ssh_public_key   = "${var.public_key}"
  image_ocid       = "${var.imageocids[var.region]}"
  nat_shape        = "${var.nat_shape}"
  nat_subnet_id    = "${module.vcn.nat_subnet_id}"
}

# sample redis 
module "redis" {
  source               = "./redis"
  tenancy_ocid         = "${var.tenancy_ocid}"
  compartment_ocid     = "${var.compartment_ocid}"
  ssh_public_key       = "${var.public_key}"
  ssh_private_key_path = "${var.private_key_path}"
  image_ocid           = "${var.imageocids[var.region]}"
  redis_shape          = "${var.redis_shape}"
  redis_subnet_id      = "${module.vcn.redis_subnet_id}"
  redis_password       = "${var.redis_password}"
  bastion_ip           = "${module.bastion.bastion_ad1_ip}"
}
