# Provider

variable "user_name" {
    default = "user_name"
}

variable "password" {
    default = "password"
}

variable "domain_name" {
    default = "domain_name"
}

variable "tenant_name" {
    default = "tenant_name"
}

# VPC

variable "vpc_name" {
  default = "vpc_k3s"
  type = string
  description = "Name of the VPC / Router"
}

variable "vpc_cidr" {
  default = "192.168.0.0/16"
  type = string
  description = "CIDR of the VPC"
}

variable "ntp_server" {
  default = "100.125.4.25,8.8.8.8"
  type = string
  description = "NTP server"
}

# Subnets

variable "subnet_server_name" {
  default = "subnet_server"
  type = string
  description = "Subnet name for the k3s management plane."
}

variable "subnet_server_cidr" {
  default = "192.168.1.0/24"
  type = string
  description = "CIDR for the management plane subnet."
}

variable "subnet_server_gateway_ip" {
  default = "192.168.1.1"
  type = string
  description = "Gateway IP for the management plane subnet"
}

variable "subnet_worker_name" {
  default = "subnet_worker"
  type = string
  description = "Subnet name for the k3s workers."
}

variable "subnet_worker_cidr" {
  default = "192.168.2.0/24"
  type = string
  description = "CIDR for the workers subnet"
}

variable "subnet_worker_gateway_ip" {
  default = "192.168.2.1"
  type = string
  description = "Gateway IP for the "
}

# Keypair

variable "keypair" {
  type = string
  description = "Keypair to access the server"
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
  default = "d91805fd-0eae-4de1-9d51-9cd24d2a32c1"
}

variable "flavor_id_workers" {
  type = string
  description = "Flavor ID for the workers"
  default = "s3.large.4"
}