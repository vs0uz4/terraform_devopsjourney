terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_token" {
  default = ""
}

variable "region" {
  default = "nyc1"
}

variable "ssh_key_name" {
  default = "default"
}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_ssh_key" "default" {
  name = var.ssh_key_name
}

resource "digitalocean_droplet" "jenkins-web" {
  image    = "ubuntu-22-04-x64"
  name     = "jenkins-web"
  region   = var.region
  size     = "s-2vcpu-2gb"
  ssh_keys = [data.digitalocean_ssh_key.default.id]
}

resource "digitalocean_kubernetes_cluster" "k8s" {
  name    = "k8s"
  region  = var.region
  version = "1.24.8-do.0"

  node_pool {
    name       = "default"
    size       = "s-2vcpu-2gb"
    node_count = 2
  }
}

output "jenkins-web" {
  value = digitalocean_droplet.jenkins-web.ipv4_address
}

resource "local_file" "config" {
  content  = digitalocean_kubernetes_cluster.k8s.kube_config.0.raw_config
  filename = ".kube/config.yaml"
}