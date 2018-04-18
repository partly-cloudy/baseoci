variable "tenancy_ocid" {
  description = "tenancy id where to create the vcn"
}

variable "compartment_ocid" {
  description = "compartment ocid which the vcn belongs to"
}

variable "vcn_name" {
  description = "name of vcn"
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

variable "newbits" {
  description = "new mask for the subnet within the virtual network. use as newbits parameter for cidrsubnet function"
}

variable "subnets" {
  description = "zero-based index of the subnet when the network is masked with the newbit."
  type        = "map"
}

variable "ha_count" {
  description = "number of availability domains where to create instances. max of 3"
}

variable "nat_ip_ids" {
  description = "id of nat private ip"
  type        = "list"
}
