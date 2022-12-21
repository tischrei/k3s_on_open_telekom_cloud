terraform {
  required_providers {
    opentelekomcloud = {
      source = "opentelekomcloud/opentelekomcloud"
      version = "1.32.0"
    }
  }
}

provider "opentelekomcloud" {
  user_name   = var.user_name
  password    = var.password
  domain_name = var.domain_name
  tenant_name = var.tenant_name
  auth_url    = "https://iam.eu-de.otc.t-systems.com/v3"
}

module "network" {
  source = "./modules/network"

  user_name = var.user_name
  password = var.password
  domain_name = var.domain_name
  tenant_name = var.tenant_name
  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr
  ntp_server = var.ntp_server
  subnet_server_name = var.subnet_server_name
  subnet_server_cidr = var.subnet_server_cidr
  subnet_server_gateway_ip = var.subnet_server_gateway_ip
  subnet_worker_name = var.subnet_worker_name
  subnet_worker_cidr = var.subnet_worker_cidr
  subnet_worker_gateway_ip = var.subnet_worker_gateway_ip
}