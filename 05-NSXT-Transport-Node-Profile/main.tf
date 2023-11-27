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
}

data "vsphere_datacenter" "datacenter" {
  name = "VMware Datacenter"
}

data "vsphere_distributed_virtual_switch" "vds" {
  name          = "Managment-VDS"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "nsxt_policy_uplink_host_switch_profile" "hsw_profile1" {
  display_name = "1614-host-tep-profile"
}

data "nsxt_policy_ip_pool" "host_ip_pool" {
  display_name = "tep-host-ip-pool"
}

data "nsxt_policy_transport_zone" "overlay_transport_zone" {
  display_name = "host-overlay-tz"
}

data "nsxt_policy_transport_zone" "vlan_transport_zone" {
  display_name = "hosts-vlan-tz"
}

## Host Transport Node Profile
resource "nsxt_policy_host_transport_node_profile" "host_node_profile" {
  display_name = "host-node-profile"

  standard_host_switch {
    host_switch_id = data.vsphere_distributed_virtual_switch.vds.id
    host_switch_mode = "STANDARD"
    host_switch_type = "VDS"
    ip_assignment {
      assigned_by_dhcp = false
      static_ip_pool = data.nsxt_policy_ip_pool.host_ip_pool.path
    }
    transport_zone_endpoint {
      transport_zone = data.nsxt_policy_transport_zone.overlay_transport_zone.path
    }
    transport_zone_endpoint {
      transport_zone = data.nsxt_policy_transport_zone.vlan_transport_zone.path
    }
    host_switch_profile = [data.nsxt_policy_uplink_host_switch_profile.hsw_profile1.path]
    is_migrate_pnics    = false
    uplink {
      uplink_name = "uplink1"
      vds_uplink_name = "Uplink 1"
    }
    uplink {
      uplink_name = "uplink2"
      vds_uplink_name = "Uplink 2"
    }
  }
}