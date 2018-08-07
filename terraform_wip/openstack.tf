provider "openstack" {
}



resource "openstack_networking_network_v2" "test" {
  name = "acid-test"
  external = true
}



resource "openstack_compute_instance_v2" "test" {
  count = 2
  name = "acid-test-${count.index}"
  image_id = "5566886d-0d9d-4d86-94ff-55597169e15a"
  flavor_name = "c1.tiny"

  network {
    name = "${openstack_networking_network_v2.test.name}"
  }

  security_groups = ["${openstack_compute_secgroup_v2.test.name}"]
}


resource "openstack_networking_floatingip_v2" "ip" {
  count = 2
  pool = "acid-test"
}

resource "openstack_compute_floatingip_associate_v2" "ips" {
  count = 2
  floating_ip = "${element(openstack_networking_floatingip_v2.ip.*.address, count.index)}"
  instance_id = "${element(openstack_compute_instance_v2.test.*.id, count.index)}"
}

resource "openstack_networking_subnet_v2" "test" {
  name       = "acid-test_1"
  network_id = "${openstack_networking_network_v2.test.id}"
  cidr       = "10.10.0.0/24"
  ip_version = 4
}


resource "openstack_compute_secgroup_v2" "test" {
  name        = "acid-test"
  description = "acid-test security group"

  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
}
