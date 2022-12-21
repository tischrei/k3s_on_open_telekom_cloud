# Provider

variable "user_name" {
  type = string
  description = "User name"
}

variable "password" {
  type = string
  description = "Password"
}

variable "domain_name" {
  type = string
  description = "Domain name"
}

variable "tenant_name" {
  type = string
  description = "Tenant / Project name"
}

# VPC

variable "vpc_name" {
  type = string
  description = "Name of the VPC / Router"
}

variable "vpc_cidr" {
  type = string
  description = "CIDR of the VPC"
}

variable "ntp_server" {
  type = string
  description = "NTP server"
}

# Subnets

variable "subnet_server_name" {
  type = string
  description = "Subnet name for the k3s management plane."
}

variable "subnet_server_cidr" {
  type = string
  description = "CIDR for the management plane subnet."
}

variable "subnet_server_gateway_ip" {
  type = string
  description = "Gateway IP for the management plane subnet"
}

variable "subnet_worker_name" {
  type = string
  description = "Subnet name for the k3s workers."
}

variable "subnet_worker_cidr" {
  type = string
  description = "CIDR for the workers subnet"
}

variable "subnet_worker_gateway_ip" {
  type = string
  description = "Gateway IP for the "
}
