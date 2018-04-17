variable tenancy_ocid {
  description = "tenancy id where to create the vcn"
}

variable compartment_ocid {
  description = "compartment ocid which the vcn belongs to"
}

variable ssh_private_key_path {
  description = "/the/path/to/the/privatekey"
}

variable ssh_public_key {
  description = "the public key that matches the private key"
}

variable image_ocid {
  description = "ocid of image"
}

variable redis_shape {
  description = "shape of redis instance"
  default     = "VM.Standard1.1"
}

variable redis_subnet_id {
  description = "subnet id of redis subnet"
}

variable redis_password {
  description = "new redis password"
}

variable bastion_ip {
  description = "bastion public ip address"
}
