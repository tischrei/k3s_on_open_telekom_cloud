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

module "compute" {
  source = "./modules/compute"

  vpc_id = module.network.vpc_id
  subnet_server = module.network.subnet_server.id
  subnet_worker = module.network.subnet_worker.id
  keypair = var.keypair
  image_id_servers = var.image_id_servers
  flavor_id_servers = var.flavor_id_servers
  image_id_workers = var.image_id_workers
  flavor_id_workers = var.flavor_id_workers
}

module "tunnel" {
  source = "./modules/tunnel"

  peer_conn_name = var.peer_conn_name
  k3s_vpc_id = module.network.vpc_id
  subnet_server_cidr = var.subnet_server_cidr
  controller_vpc_id = var.controller_vpc_id
  controller_subnet_cidr = var.controller_subnet_cidr
}

# module "lb" {
#   source = "./modules/lb"

#   subnet_server = module.network.subnet_server
# }