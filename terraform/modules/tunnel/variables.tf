# Peering

variable "peer_conn_name" {
  type = string
  description = "k3s peering name"
}

variable "k3s_vpc_id" {
  type = string
  description = "k3s vpc id"
}

variable "subnet_server_cidr" {
  type = string
  description = "CIDR for the management plane subnet."
}

variable "controller_vpc_id" {
  type = string
  description = "VPC where the remote control takes place"
}

variable "controller_subnet_cidr" {
  type = string
  description = "Subnet where the remote control takes place."
}
