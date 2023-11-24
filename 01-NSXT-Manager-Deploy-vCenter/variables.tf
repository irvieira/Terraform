# variables.tf 
 
# vSphere Infrastructure Details 
variable "data_center" { default = "Datacenter" } 
variable "cluster" { default = "Cluster" } 
variable "vds" { default = "Earthrealm-DSwitch" } 
variable "workload_datastore" { default = "reptile-datastore1" } 
variable "compute_pool" { default = "Cluster" } 
variable "compute_host" {default = "reptile.earthrealm.local"} 
variable "vsphere_server" {default = "vcenter.earthrealm.local"} 
 
# vCenter Credential Variables 
variable "vsphere_user" {} 
variable "vsphere_password" {} 
 
# NSX-T Manager Deployment 
variable "mgmt_pg" { default = "VM Network" } 
variable "vm_name" { default = "07-NSX1" }
variable "vm_folder" { default = "Terraform VMware" } 
variable "local_ovf_path" { default = "C:\\OVA\\nsx-unified-appliance-4.1.0.2.0.21761723-le.ova" }
#variable "local_ovf_path" { default = "/OVA/nsx-unified-appliance-4.1.0.2.0.21761723-le.ova" } 
variable "deployment_option" { default = "small" } # valid deployments are: extra_small, small, medium, large 
variable "nsx_role" { default = "NSX Manager" } # valid roles are NSX Manager, NSX Global Manager 
variable "nsx_ip_0" { default = "172.16.11.71" } 
variable "nsx_netmask_0" { default = "255.255.255.0" } 
variable "nsx_gateway_0" { default = "172.16.11.1" } 
variable "nsx_dns1_0" { default = "172.16.11.10" } 
variable "nsx_domain_0" { default = "vmware.local" } 
variable "nsx_ntp_0" { default = "172.16.11.10" } 
variable "nsx_isSSHEnabled" { default = "True" } 
variable "nsx_allowSSHRootLogin" { default = "True" } 
variable "nsx_passwd_0" { default = "VMw@re1!VMw@re1!" } 
variable "nsx_cli_passwd_0" { default = "VMw@re1!VMw@re1!" } 
variable "nsx_cli_audit_passwd_0" { default = "VMw@re1!VMw@re1!" } 
variable "nsx_hostname" { default = "nsx1.vmware.local" }