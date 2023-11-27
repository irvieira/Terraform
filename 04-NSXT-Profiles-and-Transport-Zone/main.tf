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
}
##### Profile Host
resource "nsxt_policy_uplink_host_switch_profile" "uplink_host_switch_profile" {
  description  = "Uplink host switch profile provisioned by Terraform"
  display_name = "1614-host-tep-profile"

  mtu            = 1500
  transport_vlan = 1614
  overlay_encap  = "GENEVE"

  teaming {
    active {
      uplink_name = "uplink1"
      uplink_type = "PNIC"
    }
    active {
      uplink_name = "uplink2"
      uplink_type = "PNIC"
    }
    policy = "LOADBALANCE_SRCID"
  }
  named_teaming {
    active {
      uplink_name = "uplink1"
      uplink_type = "PNIC"
    }
    standby {
      uplink_name = "uplink2"
      uplink_type = "PNIC"
    }
    policy = "FAILOVER_ORDER"
    name   = "uplink1"
  }
  named_teaming {
    active {
      uplink_name = "uplink2"
      uplink_type = "PNIC"
    }
    standby {
      uplink_name = "uplink1"
      uplink_type = "PNIC"
    }
    policy = "FAILOVER_ORDER"
    name   = "uplink2"
  }
}
### Profile Edge
resource "nsxt_policy_uplink_host_switch_profile" "uplink_edge_switch_profile" {
  description  = "Uplink Edge switch profile provisioned by Terraform"
  display_name = "1614-edge-tep-profile"

  mtu            = 9000
  transport_vlan = 1615
  overlay_encap  = "GENEVE"

  teaming {
    active {
      uplink_name = "edge-up1"
      uplink_type = "PNIC"
    }
    active {
      uplink_name = "edge-up2"
      uplink_type = "PNIC"
    }
    policy = "LOADBALANCE_SRCID"
  }
  named_teaming {
    active {
      uplink_name = "edge-up1"
      uplink_type = "PNIC"
    }
    standby {
      uplink_name = "edge-up2"
      uplink_type = "PNIC"
    }
    policy = "FAILOVER_ORDER"
    name   = "edge-up1"
  }
  named_teaming {
    active {
      uplink_name = "edge-up2"
      uplink_type = "PNIC"
    }
    standby {
      uplink_name = "edge-up1"
      uplink_type = "PNIC"
    }
    policy = "FAILOVER_ORDER"
    name   = "edge-up2"
  }
}

#### Host Transport Zones
resource "nsxt_policy_transport_zone" "vlan_host_transport_zone" {
  display_name                = "hosts-vlan-tz"
  description                 = "Host VLAN transport zone"
  transport_type              = "VLAN_BACKED"
  is_default                  = false
  uplink_teaming_policy_names = ["uplink1","uplink2"]
}

resource "nsxt_policy_transport_zone" "overlay_host_transport_zone" {
  display_name                = "host-overlay-tz"
  description                 = "Host Overlay transport zone"
  transport_type              = "OVERLAY_BACKED"
  is_default                  = true
}

### Edge Tranport Zones
resource "nsxt_policy_transport_zone" "vlan_edge_transport_zone" {
  display_name                = "edge-vlan-tz"
  description                 = "Edge VLAN transport zone"
  transport_type              = "VLAN_BACKED"
  is_default                  = false
  uplink_teaming_policy_names = ["edge-up1","edge-up2"]
}