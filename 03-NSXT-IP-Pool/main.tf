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

# Create TEP Host IP Pools
resource "nsxt_policy_ip_pool" "tep_host_ip_pool" {
    display_name = "tep-host-ip-pool"
}

# Create TEP Edge IP Pools
resource "nsxt_policy_ip_pool" "tep_edge_ip_pool" {
    display_name = "tep-edge-ip-pool"
}

# Create TEP Host Static Subnet
resource "nsxt_policy_ip_pool_static_subnet" "tep_host_ip_pool" {
    display_name = "tep-host-ip-pool"
    pool_path = nsxt_policy_ip_pool.tep_host_ip_pool.path
    cidr                = "172.16.14.0/24"
    gateway             = "172.16.14.1"

    allocation_range {
        start = "172.16.14.100"
        end   = "172.16.14.200"
  }
}
# Create TEP Edge Static Subnet
resource "nsxt_policy_ip_pool_static_subnet" "tep_edge_ip_pool" {
    display_name = "tep-edge-ip-pool"
    pool_path = nsxt_policy_ip_pool.tep_edge_ip_pool.path
    cidr                = "172.16.15.0/24"
    gateway             = "172.16.15.1"

    allocation_range {
        start = "172.16.15.100"
        end   = "172.16.15.200"
  }
}