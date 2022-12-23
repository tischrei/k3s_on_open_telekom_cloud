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

# Compute

variable "image_id_servers" {
  type = string
  description = "Image ID for the servers"
  default = "d91805fd-0eae-4de1-9d51-9cd24d2a32c1"
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