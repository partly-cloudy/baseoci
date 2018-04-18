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

variable nat_shape {
  description = "shape of nat instance"
  default     = "VM.Standard2.2"
}

variable "nat_subnet_ids" {
  description = "subnet ids of nat in 3 ADs in order of AD1, AD2, AD3"
  type        = "list"
}
