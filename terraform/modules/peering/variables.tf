# Peering

variable "k3s_vpc_id" {
  type = string
  description = "k3s vpc id"
}

variable "subnet_server_cidr" {
  type = string
  description = "CIDR for the management plane subnet."
}

variable "peer_conn_name" {
  type = string
  description = "k3s peering name"
  default = "peering_k3s"
}

variable "controller_vpc_id" {
  type = string
  description = "VPC where the remote control takes place"
  default = "34573073-5cbf-4345-a26a-4f7f31ea8e7b"
}

variable "controller_subnet_cidr" {
  type = string
  description = "Subnet where the remote control takes place."
  default = "192.168.0.0/24"
}
