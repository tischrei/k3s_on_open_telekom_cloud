output "subnet_server" {
  description = "Subnet of the k3s management plane"
  value       = opentelekomcloud_vpc_subnet_v1.subnet_server
}

output "subnet_worker" {
  description = "Subnet of the k3s nodes"
  value       = opentelekomcloud_vpc_subnet_v1.subnet_worker
}

output "vpc_id" {
  description = "Subnet of the k3s nodes"
  value       = opentelekomcloud_vpc_v1.vpc_v1.id
}

output "secgroup_server" {
  description = "Security group of server instances"
  value = opentelekomcloud_networking_secgroup_v2.sg_server
}

output "secgroup_worker" {
  description = "Security group of worker instances"
  value = opentelekomcloud_networking_secgroup_v2.sg_worker
}