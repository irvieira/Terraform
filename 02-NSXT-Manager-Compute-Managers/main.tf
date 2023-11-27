terraform {
  required_providers {
    nsxt = {
      source = "vmware/nsxt"
    }
  }
}

provider "vsphere" {
  vsphere_server       = var.vsphere_server
  user                 = var.vsphere_user
  password             = var.vsphere_password
  allow_unverified_ssl = true
}

provider "nsxt" {
  host                 = var.nsxt_host
  username             = var.nsxt_username
  password             = var.nsxt_password
  allow_unverified_ssl = true
  max_retries          = 10
  global_manager  = true
  retry_min_delay = 500
  retry_max_delay = 1000
}

#data "nsxt_compute_manager" "test_vcenter" {
#}

data "vsphere_host_thumbprint" "thumbprint_vcenter" {
  address = "vcsa.vmware.local"
  insecure = true
}

resource "nsxt_compute_manager" "vcenter" {
  description  = "Terraform provisioned Compute Manager"
  display_name = "vCenter"
  #tag {
  #  scope = "scope1"
  #  tag   = "tag1"
  #}
  access_level_for_oidc = "FULL"
  server = "vcsa.vmware.local"

  credential {
    username_password_login {
      thumbprint = var.vsphere_thumbprint
      username = var.vsphere_user
      password = var.vsphere_password
    }
  }
  origin_type = "vCenter"
}