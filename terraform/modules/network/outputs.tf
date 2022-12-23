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