terraform {
  required_providers {
    opentelekomcloud = {
      source = "opentelekomcloud/opentelekomcloud"
      version = "1.32.0"
    }
  }
}

# resource "opentelekomcloud_lb_loadbalancer_v2" "lb_1" {
#   vip_subnet_id = opentelekomcloud_vpc_subnet_v1.subnet_server.subnet_id
# }
