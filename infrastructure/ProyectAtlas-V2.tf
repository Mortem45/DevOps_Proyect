
resource "digitalocean_tag" "ProyectAtlas-V2-tag" {
  name = "WebSite-V2"
}
resource "digitalocean_droplet" "ProyectAtlas-V2" {
  count  = 2
  image  = "${var.image_id}"
  name   = "ProyectAtlas-V2"
  region = "nyc3"
  size   = "s-1vcpu-1gb"
  tags   = ["${digitalocean_tag.ProyectAtlas-V2-tag.id}"]
  ssh_keys = ["${var.ssh_fingerprint}"]
  user_data = "${file("user-data.web")}"
  lifecycle {
    create_before_destroy = true
  }

  provisioner "local-exec" {
    command = "sleep 120 && curl ${self.ipv4_address}:3000"
  }
}

resource "digitalocean_loadbalancer" "ProyectAtlas-V2" {
  name = "DevOps-Balancer"
  region = "nyc3"

  forwarding_rule {
    entry_port = 80
    entry_protocol = "http"

    target_port = 3000
    target_protocol = "http"
  }

  healthcheck {
    port = 3000
    protocol = "http"
    path = "/"
  }

  droplet_tag = "${digitalocean_tag.ProyectAtlas-V2-tag.name}"
}

