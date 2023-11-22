terraform {
  required_providers {
    nsxt = {
      source = "vmware/nsxt"
    }
  }
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

data "nsxt_compute_manager" "vcenter" {
}

resource "nsxt_compute_manager" "test" {
  description  = "Terraform provisioned Compute Manager"
  display_name = "MTLVC50001"
  #tag {
  #  scope = "scope1"
  #  tag   = "tag1"
  #}

  server = "mtlvc50001.vmware.cloud"

  credential {
    username_password_login {
      thumbprint = var.vsphere_thumbprint
      username = var.vsphere_user
      password = var.vsphere_password
    }
  }
  origin_type = "vCenter"
}