#Identity and access parameters
variable "tenancy_ocid" {
  description = "tenancy id"
}

variable "user_ocid" {
  description = "user ocid"
}

variable "compartment_ocid" {
  description = "compartment ocid"
}

variable "fingerprint" {
  description = "ssh fingerprint"
}

variable "private_key_path" {
  description = "/the/path/to/the/privatekey"
}

variable "public_key" {
  description = "the public key that matches the private key"
}

# general oci parameters

variable "region" {
  description = "region"
  default     = "us-ashburn-1"

  # List of regions: https://docs.us-phoenix-1.oraclecloud.com/Content/General/Concepts/regions.htm
}

variable "disable_auto_retries" {
  default = true
}

# network parameters
variable "label_prefix" {
  type    = "string"
  default = ""
}

variable "vcn_dns_name" {
  default = "baseoci"
}

variable "vcn_name" {
  description = "name of vcn"
}

variable "vcn_cidr" {
  description = "cidr block of VCN"
  default     = "10.0.0.0/16"
}

variable "newbits" {
  description = "new mask for the subnet within the virtual network. use as newbits parameter for cidrsubnet function"
  default     = 8
}

variable "subnets" {
  description = "zero-based index of the subnet when the network is masked with the newbit."
  type        = "map"

  default = {
    bastion_ad1 = 11
    bastion_ad2 = 21
    bastion_ad3 = 31
    nat_ad1     = 12
    nat_ad2     = 22
    nat_ad3     = 32
    redis_ad1   = 13
    redis_ad2   = 23
    redis_ad3   = 33
  }
}

# compute
variable "imageocids" {
  type = "map"

  default = {
    # https://docs.us-phoenix-1.oraclecloud.com/Content/Resources/Assets/OracleProvidedImageOCIDs.pdf

    us-phoenix-1   = "ocid1.image.oc1.phx.aaaaaaaaupbfz5f5hdvejulmalhyb6goieolullgkpumorbvxlwkaowglslq"
    us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaajlw3xfie2t5t52uegyhiq2npx7bqyu4uvi2zyu3w3mqayc2bxmaa"
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt1.aaaaaaaa7d3fsb6272srnftyi4dphdgfjf6gurxqhmv6ileds7ba3m2gltxq"
    uk-london-1    = "ocid1.image.oc1.uk-london1.aaaaaaaaa6h6gj6v4n56mqrbgnosskq63blyv2752g36zerymy63cfkojiiq"
  }
}

variable "bastion_shape" {
  description = "shape of bastion instance"
  default     = "VM.Standard1.1"
}

variable "nat_shape" {
  description = "shape of bastion instance"
  default     = "VM.Standard1.1"
}

# redis

variable "redis_shape" {
  description = "shape of redis instance"
  default     = "VM.Standard1.1"
}

variable "redis_volume_size" {
  description = "size of redis volume in GB"
  default     = 50
}

variable "redis_password" {
  description = "redis password"
  default     = "use_a_strong_password"
}

# ha

variable "ha_count" {
  description = "number of availability domains where to create instances. max of 3"
  default     = 2
}
