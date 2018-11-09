variable "do_token" {
  default = "575c14a1bdafec63a019152b7d1e6ed93ce5125806505294e36e71f47590d0ea"
}
variable "pub_key" {
  default = "$HOME/.ssh/id_rsa.pub"
}
variable "pvt_key" {
  default = "$HOME/.ssh/id_rsa"
}
variable "ssh_fingerprint" {
  default = "00:35:99:54:be:3d:5a:b4:c7:64:6c:c6:ed:4f:c8:e7"
}

provider "digitalocean" {
  token = "${var.do_token}"
}
