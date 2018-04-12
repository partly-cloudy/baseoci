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

variable redis_password {
  description = "new redis password"
}

variable "vcn_cidr" {
  description = "cidr block of vcn"
}

variable redis_cidr_ad1 {
  description = "cidr block of redis in ad1"
}

variable vcn_dhcp_id {
  description = "id of default dhcp options for vcn"
}

variable base_vcn_id {
  description = "id of gitlab vcn"
}

# variable base_ig_id {
#   description = "id of gitlab InternetGateway"
# }

variable nat_instance_ip_id {
  description = "id of nat instance ip"
}

variable bastion_ip {
  description = "bastion public ip address"
}

variable nat_route_id {
  description = "id of nat private route"
}
