variable tenancy_ocid {
  description = "tenancy id where to create the vcn"
}

variable compartment_ocid {
  description = "compartment ocid which the vcn belongs to"
}

variable "vcn_dns_name" {
  description = ""
}

variable "label_prefix" {
  description = ""
}

variable "vcn_cidr" {
  description = "cidr block of vcn"
}
