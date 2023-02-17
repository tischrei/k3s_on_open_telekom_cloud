# Keypair

variable "keypair" {
  type = string
  description = "Keypair to access the server"
}

# Network

variable "vpc_id" {
  description = "Subnet for k3s worker"
  type        = string
}

variable "subnet_server" {
  description = "Subnet for k3s management plane"
  type        = string
}

variable "subnet_worker" {
  description = "Subnet for k3s worker"
  type        = string
}

variable "secgroup_server" {
  type = string
  description = "Security group id of server instances"
}

variable "secgroup_worker" {
  type = string
  description = "Security group id of worker instances"
}

# Compute

variable "image_id_servers" {
  type = string
  description = "Image ID for the servers"
  default = "b2bd79fe-4696-41aa-bc0d-49a0e5df0fdf"
}

variable "flavor_id_servers" {
  type = string
  description = "Flavor ID for the servers"
  default = "s3.large.4"
}

variable "image_id_workers" {
  type = string
  description = "Image ID for the workers"
}

variable "flavor_id_workers" {
  type = string
  description = "Flavor ID for the workers"
}