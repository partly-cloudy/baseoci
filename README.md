# baseoci
[oci]: https://cloud.oracle.com/cloud-infrastructure
[oci provider]: https://github.com/oracle/terraform-provider-oci/releases
[API signing]: https://docs.us-phoenix-1.oraclecloud.com/Content/API/Concepts/apisigningkey.htm
[terraform]: https://www.terraform.io

# Terraform Base Module for [Oracle Cloud Infrastructure][oci]

## About

The Terraform Base Module Installer for Oracle Cloud Infrastructure provides a Terraform module that provisions a VCN, Bastion and NAT host as 
well as some basic routing.

## Pre-reqs

1. Download and install [Terraform][terraform] (v0.11+). Check latest compatibility [here][oci provider].
2. Download and install the [OCI Terraform Provider][oci provider]

## Quickstart

```
$ git clone https://github.com/hyder/baseoci.git
$ cp terraform.example.tfvars terraform.tfvars
```
* Set mandatory variables tenancy_ocid, user_ocid, compartment_ocid, fingerprint

* Override other variables urls, hostnames, passwords, shapes etc.

### Deploy gitlab

Initialize Terraform:
```
$ terraform init
```

View what Terraform plans do before actually doing it:
```
$ terraform plan
```

Create gitlab:
```
$ terraform apply
```
