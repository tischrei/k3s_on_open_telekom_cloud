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

# Keypair

variable "keypair" {
  type = string
  description = "Keypair to access the server"
}

# Compute

variable "image_id_servers" {
  type = string
  description = "Image ID for the servers"
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