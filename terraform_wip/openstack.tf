provider "openstack" {
}

variable "env_name" {
  default = "test"
}

variable "ext-net" {
  default = "a07d7f52-0eed-4242-91fd-368dea025cc7"
}

variable "image_id" {
  default = "d324da4b-b827-44fb-8331-bfad41a28aca"
}

variable "flavor_name" {
  default = "c1.medium"
}

variable "key_name" {
  default = "CircleCI Master"
}
/*
resource "openstack_networking_network_v2" "network" {
  name           = "ae-${var.env_name}-net"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet" {
  name       = "ae-${var.env_name}-subnet"
  network_id = "${openstack_networking_network_v2.network.id}"
  cidr       = "192.168.60.0/24"
  ip_version = 4
  enable_dhcp = true
  dns_nameservers = ["1.1.1.1","1.0.0.1"]
}

resource "openstack_networking_router_v2" "router" {
  name       = "ae-${var.env_name}-router"
  admin_state_up      = true
  external_network_id = "${var.ext-net}"
}

resource "openstack_networking_router_interface_v2" "router_interface" {
  router_id = "${openstack_networking_router_v2.router.id}"
  subnet_id = "${openstack_networking_subnet_v2.subnet.id}"
}

resource "openstack_networking_port_v2" "port" {
  name       = "ae-${var.env_name}-port"
  network_id     = "${openstack_networking_network_v2.network.id}"
  admin_state_up = true
  security_group_ids = [
    "${openstack_compute_secgroup_v2.management.id}",
    "${openstack_compute_secgroup_v2.epoch.id}",
  ]
}


resource "openstack_compute_secgroup_v2" "management" {
  name = "ae-${var.env_name}-management"
  description = "Allow node management from internet (ICMP, SSH, API)"
}

resource "openstack_compute_secgroup_v2" "epoch" {
  name = "ae-${var.env_name}-epoch"
  description = "Full access between epoch nodes in their environment"
}

resource "openstack_compute_secgroup_v2" "internal" {
  name = "ae-${var.env_name}-internal"
  description = "Allow access to internal ports"
}


resource "openstack_compute_instance_v2" "basic" {
  count = 2
  name            = "ae-${var.env_name}-epoch-n${count.index}"
  image_id        = "${var.image_id}"
  flavor_name       = "${var.flavor_name}"
  key_pair        = "${var.key_name}"
  security_groups = [
    "${openstack_compute_secgroup_v2.management.id}",
    "${openstack_compute_secgroup_v2.epoch.id}",
    "${openstack_compute_secgroup_v2.internal.id}",
  ]

  metadata {
    this = "that"
  }

  network {
    name = "ext-net"
  }
}
*/
