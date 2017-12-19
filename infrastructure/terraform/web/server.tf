resource "digitalocean_tag" "web" {
  name = "web"
}

resource "digitalocean_droplet" "web" {
  image              = "ubuntu-16-04-x64"
  name               = "web"
  region             = "nyc3"
  size               = "512mb"
  monitoring         = true
  private_networking = true

  ssh_keys = [
    "${digitalocean_ssh_key.public_keys.*.fingerprint}",
  ]

  tags = [
    "${digitalocean_tag.web.id}",
  ]
}

output "web_ip" {
  value = "${digitalocean_droplet.web.ipv4_address}"
}
