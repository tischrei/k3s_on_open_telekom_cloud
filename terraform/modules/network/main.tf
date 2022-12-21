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

resource "opentelekomcloud_vpc_v1" "vpc_v1" {
  name = var.vpc_name
  cidr = var.vpc_cidr
  shared = true
}

resource "opentelekomcloud_vpc_subnet_v1" "subnet_server" {
  name   = var.subnet_server_name
  cidr   = var.subnet_server_cidr
  vpc_id = opentelekomcloud_vpc_v1.vpc_v1.id
  gateway_ip    = var.subnet_server_gateway_ip
  ntp_addresses = var.ntp_server
}


resource "opentelekomcloud_vpc_subnet_v1" "subnet_worker" {
  name   = var.subnet_worker_name
  cidr   = var.subnet_worker_cidr
  vpc_id = opentelekomcloud_vpc_v1.vpc_v1.id
  gateway_ip    = var.subnet_worker_gateway_ip
  ntp_addresses = var.ntp_server
}