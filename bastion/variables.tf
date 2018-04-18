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

variable ha_count {
  description = "number of availability domains where to create instances. max of 3"
}

variable bastion_shape {
  description = "shape of mysql instance"
  default     = "VM.Standard1.1"
}

variable bastion_subnet_ids {
  description = "subnet ids of bastion in 3 ADs in order of AD1, AD2, AD3"
  type        = "list"
}
