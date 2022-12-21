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

# Keypair

resource "opentelekomcloud_compute_keypair_v2" "k3s_keypair" {
  name       = "k3s_keypair"
  public_key = var.keypair
}

# Instances

resource "opentelekomcloud_compute_instance_v2" "server_1" {
  name            = "server_1"
  image_id        = var.image_id
  flavor_id       = var.flavor_id_servers
  key_pair        = opentelekomcloud_compute_keypair_v2.k3s_keypair.name
  security_groups = ["default"]

  network {
    name = "my_network"
  }
}

