variable "keys" {
  type = "list"

  default = [
    "geowa4",
  ]
}

resource "digitalocean_ssh_key" "public_keys" {
  count      = "${length(var.keys)}"
  name       = "SSH Key: ${element(var.keys, count.index)}"
  public_key = "${file(format("%s/public_keys/%s.pub", path.module, element(var.keys, count.index)))}"
}

resource "digitalocean_firewall" "base-role" {
  name        = "base-role"
  droplet_ids = ["${digitalocean_droplet.web.*.id}"]

  outbound_rule {
    protocol              = "udp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

resource "digitalocean_firewall" "web" {
  name        = "web-role"
  droplet_ids = ["${digitalocean_droplet.web.*.id}"]

  inbound_rule = [
    {
      protocol         = "tcp"
      port_range       = "80"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol         = "tcp"
      port_range       = "443"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
  ]

  outbound_rule = [
    {
      protocol              = "tcp"
      port_range            = "80"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol              = "tcp"
      port_range            = "443"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
  ]
}

resource "digitalocean_firewall" "ssh" {
  name        = "ssh-role"
  droplet_ids = ["${digitalocean_droplet.web.*.id}"]

  inbound_rule = [
    {
      protocol         = "tcp"
      port_range       = "22"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
  ]

  outbound_rule = [
    {
      protocol              = "tcp"
      port_range            = "22"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
  ]
}
