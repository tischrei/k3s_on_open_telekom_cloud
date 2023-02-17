terraform {
  required_providers {
    opentelekomcloud = {
      source = "opentelekomcloud/opentelekomcloud"
      version = "1.32.0"
    }
  }
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

resource "opentelekomcloud_networking_floatingip_v2" "fip_1" {}

resource "opentelekomcloud_nat_gateway_v2" "this" {
  name                = "k3s_gw"
  description         = "K3S NAT Gateway"
  spec                = "1"
  router_id           = opentelekomcloud_vpc_v1.vpc_v1.id
  internal_network_id = opentelekomcloud_vpc_subnet_v1.subnet_server.network_id
}

resource "opentelekomcloud_nat_snat_rule_v2" "snat_subnet_server" {
  nat_gateway_id = opentelekomcloud_nat_gateway_v2.this.id
  floating_ip_id = opentelekomcloud_networking_floatingip_v2.fip_1.id
  cidr           = var.subnet_server_cidr
  source_type    = 0
}

resource "opentelekomcloud_nat_snat_rule_v2" "snat_subnet_worker" {
  nat_gateway_id = opentelekomcloud_nat_gateway_v2.this.id
  floating_ip_id = opentelekomcloud_networking_floatingip_v2.fip_1.id
  cidr           = var.subnet_worker_cidr
  source_type    = 0
}