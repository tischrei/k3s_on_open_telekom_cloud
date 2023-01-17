terraform {
  required_providers {
    opentelekomcloud = {
      source = "opentelekomcloud/opentelekomcloud"
      version = "1.32.0"
    }
  }
}

resource "opentelekomcloud_vpc_peering_connection_v2" "peering" {
  name        = var.peer_conn_name
  vpc_id      = var.k3s_vpc_id
  peer_vpc_id = var.controller_vpc_id
}

resource "opentelekomcloud_vpc_route_v2" "vpc_route_1" {
  type        = "peering"
  nexthop     = opentelekomcloud_vpc_peering_connection_v2.peering.id
  destination = var.controller_subnet_cidr
  vpc_id      = var.controller_vpc_id
}

resource "opentelekomcloud_vpc_route_v2" "vpc_route_2" {
  type        = "peering"
  nexthop     = opentelekomcloud_vpc_peering_connection_v2.peering.id
  destination = var.subnet_server_cidr
  vpc_id      = var.k3s_vpc_id
}