terraform {
  required_providers {
    nsxt = {
      source = "vmware/nsxt"
    }
  }
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