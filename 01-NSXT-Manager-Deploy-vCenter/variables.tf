# variables.tf 
 
# vSphere Infrastructure Details 
variable "data_center" { default = "VMware Datacenter" } 
variable "cluster" { default = "Management" } 
variable "vds" { default = "Management-DSwitch" } 
variable "workload_datastore" { default = "Datastore1" } 
variable "compute_pool" { default = "Management" } 
variable "compute_host" {default = "mtlesx50001.vmware.cloud"} 
variable "vsphere_server" {default = "mtlvc50001.vmware.cloud"} 
 
# vCenter Credential Variables 
variable "vsphere_user" {} 
variable "vsphere_password" {} 
 
# NSX-T Manager Deployment 
variable "mgmt_pg" { default = "vSphere Management" } 
variable "vm_name" { default = "MTLNSX50002" } 
#variable "local_ovf_path" { default = "Z:\\Files\\OVA\\VMWare\\NSX\\nsx-unified-appliance-4.1.0.2.0.21761723-le.ova" }## SMB
variable "local_ovf_path" { default = "/OVA/nsx-unified-appliance-4.1.0.2.0.21761723-le.ova" } 
variable "deployment_option" { default = "extra_small" } # valid deployments are: extra_small, small, medium, large 
variable "nsx_role" { default = "NSX Manager" } # valid roles are NSX Manager, NSX Global Manager 
variable "nsx_ip_0" { default = "172.16.11.72" } 
variable "nsx_netmask_0" { default = "255.255.255.0" } 
variable "nsx_gateway_0" { default = "172.16.11.1" } 
variable "nsx_dns1_0" { default = "172.16.11.10" } 
variable "nsx_domain_0" { default = "vmware.cloud" } 
variable "nsx_ntp_0" { default = "172.16.11.10" } 
variable "nsx_isSSHEnabled" { default = "True" } 
variable "nsx_allowSSHRootLogin" { default = "True" } 
variable "nsx_passwd_0" { default = "VMw@re1!VMw@re1!" } 
variable "nsx_cli_passwd_0" { default = "VMw@re1!VMw@re1!" } 
variable "nsx_cli_audit_passwd_0" { default = "VMw@re1!VMw@re1!" } 
variable "nsx_hostname" { default = "mtlnsx50002.vmware.cloud" }