variable tenancy_ocid {
  description = "tenancy id where to create the vcn"
}

variable compartment_ocid {
  description = "compartment ocid which the vcn belongs to"
}

variable ssh_public_key {
  description = "the public key that matches the private key"
}

variable image_ocid {
  description = "ocid of image"
}

variable bastion_shape {
  description = "shape of mysql instance"
  default     = "VM.Standard1.1"
}

variable bastion_cidr_ad1 {
  description = "cidr block of bastion in ad1"
}

variable vcn_dhcp_id {
  description = "id of default dhcp options for vcn"
}

variable base_vcn_id {
  description = "id of OCIBase vcn"
}

variable ig_route_id {
  description = "ig route id"
}
