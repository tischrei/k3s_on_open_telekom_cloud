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

# VPC

resource "opentelekomcloud_vpc_v1" "vpc_v1" {
  name = var.vpc_name
  cidr = var.vpc_cidr
  shared = true
}

# Subnets

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

# SG Worker

resource "opentelekomcloud_networking_secgroup_v2" "sg_worker" {
  name        = "sg_worker"
  description = "Security group for k3s worker"
}

resource "opentelekomcloud_networking_secgroup_rule_v2" "sg_worker_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = opentelekomcloud_networking_secgroup_v2.sg_worker.id
}

resource "opentelekomcloud_networking_secgroup_rule_v2" "sg_worker_rule_2" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  port_range_min    = 8472
  port_range_max    = 8472
  remote_group_id = opentelekomcloud_networking_secgroup_v2.sg_server.id
  security_group_id = opentelekomcloud_networking_secgroup_v2.sg_worker.id
}

resource "opentelekomcloud_networking_secgroup_rule_v2" "sg_worker_rule_3" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  port_range_min    = 8472
  port_range_max    = 8472
  remote_group_id = opentelekomcloud_networking_secgroup_v2.sg_worker.id
  security_group_id = opentelekomcloud_networking_secgroup_v2.sg_worker.id
}

resource "opentelekomcloud_networking_secgroup_rule_v2" "sg_worker_rule_4" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 10250
  port_range_max    = 10250
  remote_group_id = opentelekomcloud_networking_secgroup_v2.sg_server.id
  security_group_id = opentelekomcloud_networking_secgroup_v2.sg_worker.id
}

resource "opentelekomcloud_networking_secgroup_rule_v2" "sg_worker_rule_5" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 10250
  port_range_max    = 10250
  remote_group_id = opentelekomcloud_networking_secgroup_v2.sg_worker.id
  security_group_id = opentelekomcloud_networking_secgroup_v2.sg_worker.id
}

resource "opentelekomcloud_networking_secgroup_rule_v2" "sg_worker_rule_6" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  port_range_min    = 51820
  port_range_max    = 51821
  remote_group_id = opentelekomcloud_networking_secgroup_v2.sg_server.id
  security_group_id = opentelekomcloud_networking_secgroup_v2.sg_worker.id
}

resource "opentelekomcloud_networking_secgroup_rule_v2" "sg_worker_rule_7" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  port_range_min    = 51820
  port_range_max    = 51821
  remote_group_id = opentelekomcloud_networking_secgroup_v2.sg_worker.id
  security_group_id = opentelekomcloud_networking_secgroup_v2.sg_worker.id
}

# SG Server

resource "opentelekomcloud_networking_secgroup_v2" "sg_server" {
  name        = "sg_server"
  description = "Security group for k3s management plane"
}

resource "opentelekomcloud_networking_secgroup_rule_v2" "sg_server_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = opentelekomcloud_networking_secgroup_v2.sg_server.id
}

resource "opentelekomcloud_networking_secgroup_rule_v2" "sg_server_rule_2" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 2379
  port_range_max    = 2380
  remote_group_id = opentelekomcloud_networking_secgroup_v2.sg_server.id
  security_group_id = opentelekomcloud_networking_secgroup_v2.sg_server.id
}

resource "opentelekomcloud_networking_secgroup_rule_v2" "sg_server_rule_3" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 6443
  port_range_max    = 6443
  remote_group_id = opentelekomcloud_networking_secgroup_v2.sg_worker.id
  security_group_id = opentelekomcloud_networking_secgroup_v2.sg_server.id
}

resource "opentelekomcloud_networking_secgroup_rule_v2" "sg_server_rule_4" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  port_range_min    = 8472
  port_range_max    = 8472
  remote_group_id = opentelekomcloud_networking_secgroup_v2.sg_server.id
  security_group_id = opentelekomcloud_networking_secgroup_v2.sg_server.id
}

resource "opentelekomcloud_networking_secgroup_rule_v2" "sg_server_rule_5" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  port_range_min    = 8472
  port_range_max    = 8472
  remote_group_id = opentelekomcloud_networking_secgroup_v2.sg_worker.id
  security_group_id = opentelekomcloud_networking_secgroup_v2.sg_server.id
}

resource "opentelekomcloud_networking_secgroup_rule_v2" "sg_server_rule_6" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 10250
  port_range_max    = 10250
  remote_group_id = opentelekomcloud_networking_secgroup_v2.sg_server.id
  security_group_id = opentelekomcloud_networking_secgroup_v2.sg_server.id
}

resource "opentelekomcloud_networking_secgroup_rule_v2" "sg_server_rule_7" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 10250
  port_range_max    = 10250
  remote_group_id = opentelekomcloud_networking_secgroup_v2.sg_worker.id
  security_group_id = opentelekomcloud_networking_secgroup_v2.sg_server.id
}

resource "opentelekomcloud_networking_secgroup_rule_v2" "sg_server_rule_8" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  port_range_min    = 51820
  port_range_max    = 51821
  remote_group_id = opentelekomcloud_networking_secgroup_v2.sg_server.id
  security_group_id = opentelekomcloud_networking_secgroup_v2.sg_server.id
}

resource "opentelekomcloud_networking_secgroup_rule_v2" "sg_server_rule_9" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  port_range_min    = 51820
  port_range_max    = 51821
  remote_group_id = opentelekomcloud_networking_secgroup_v2.sg_worker.id
  security_group_id = opentelekomcloud_networking_secgroup_v2.sg_server.id
}