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

variable nat_shape {
  description = "shape of nat instance"
  default     = "VM.Standard2.2"
}

variable "nat_subnet_id" {
  description = "subnet id of nat"
}
