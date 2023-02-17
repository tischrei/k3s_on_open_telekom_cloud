terraform {
  required_providers {
    opentelekomcloud = {
      source = "opentelekomcloud/opentelekomcloud"
      version = "1.32.0"
    }
  }
}

resource "opentelekomcloud_compute_keypair_v2" "k3s_keypair" {
  name       = "k3s_keypair"
  public_key = var.keypair
}

# Instances

resource "opentelekomcloud_ecs_instance_v1" "server_1" {
  name     = "server_1"
  image_id = var.image_id_servers
  flavor   = var.flavor_id_servers
  vpc_id   = var.vpc_id

  system_disk_type            = "SAS"
  system_disk_size            = "20"

  nics {
    network_id = var.subnet_server
  }

  security_groups = [var.secgroup_server]
  availability_zone = "eu-nl-01"
  key_name          = opentelekomcloud_compute_keypair_v2.k3s_keypair.name
}

resource "opentelekomcloud_ecs_instance_v1" "server_2" {
  name     = "server_2"
  image_id = var.image_id_servers
  flavor   = var.flavor_id_servers
  vpc_id   = var.vpc_id

  system_disk_type            = "SAS"
  system_disk_size            = "20"

  nics {
    network_id = var.subnet_server
  }

  security_groups = [var.secgroup_server]
  availability_zone = "eu-nl-02"
  key_name          = opentelekomcloud_compute_keypair_v2.k3s_keypair.name
}
