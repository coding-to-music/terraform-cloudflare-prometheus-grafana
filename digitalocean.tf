
resource "digitalocean_project" "cloudflare_prometheus_analytics" {
  name        = "cloudflare-prometheus-analytics"
  description = "A sample project demonstrating how to implement Prometheus and Grafana to pull Cloudflare GraphQL Analytics"
  purpose     = "Analytics"
  environment = "Production"
  resources = [digitalocean_droplet.prometheus_analytics.urn]
}

data "digitalocean_ssh_key" "default" {
  name       = var.digitalocean_key_name  
}

data "digitalocean_image" "image_details" {
  name = "cloudflare-prometheus-analytics"
  # name_regex = "cloudflare-prometheus-analytics*"
  # region = var.digitalocean_droplet_region
  # most_recent = true
}

output "digitalocean_image_id" {
  value = data.digitalocean_image.image_details.image
  description = "image_id"
}

output "digitalocean_image_min_disk_size" {
  value = data.digitalocean_image.image_details.min_disk_size
  description = "min_disk_size"
}

output "digitalocean_image_size_gigabytes" {
  value = data.digitalocean_image.image_details.size_gigabytes
  description = "size_gigabytes"
}

output "digitalocean_image_type" {
  value = data.digitalocean_image.image_details.type
  description = "type"
}

output "digitalocean_image_name" {
  value = data.digitalocean_image.image_details.name
  description = "name"
}

resource "digitalocean_droplet" "prometheus_analytics" {
  # image  = var.digitalocean_droplet_image
  image = "${data.digitalocean_image.image_details.image}"
  name   = "cloudflare-prometheus-analytics"
  region = var.digitalocean_droplet_region
  size   = var.digitalocean_droplet_size
  monitoring = true
  ssh_keys = [
    data.digitalocean_ssh_key.default.id
  ]
  user_data = templatefile("${path.module}/cloud-init/bootstrap-cloud-init.yaml", {
      account_id = var.cloudflare_account_id
      fqdn = local.cloudflare_fqdn
      ssh_fqdn = local.cloudflare_ssh_fqdn
      cloudflare_tunnel_id = cloudflare_argo_tunnel.prometheus_analytics.id
      cloudflare_tunnel_name = cloudflare_argo_tunnel.prometheus_analytics.name
      cloudflare_tunnel_secret = cloudflare_argo_tunnel.prometheus_analytics.secret
      trusted_pub_key = cloudflare_access_ca_certificate.ssh_short_lived.public_key
      cloudflare_analytics_api_token = var.cloudflare_analytics_api_token
      # user = local.user_from_mail
      # user = var.another_non_root_user
      # non_root_user = var.non_root_user
      # non_root_user_password = var.non_root_user_password
  })

#
# grafana-setup:
#   build: grafana-setup/
#   depends_on:
#     - grafana

  # connection digitalocean_droplet {
  #     user  = "root"
  #     type  = "ssh"
  #     host  = self.ipv4_address
  #     private_key = file(var.digitalocean_priv_key_path)
  #     timeout = "10m"
  # }
  connection {
      user  = "root"
      type  = "ssh"
      host  = var.chromebook_ipv4_address
      # private_key = file(var.chromebook_priv_key_path)
      private_key = file(var.digitalocean_priv_key_path)
      # timeout = "10m"
  }
}

data "digitalocean_droplet" "prometheus_analytics" {
  name = digitalocean_droplet.prometheus_analytics.name
  depends_on = [digitalocean_droplet.prometheus_analytics]
}

data "cloudflare_ip_ranges" "cloudflare" {}

data "http" "my_ip" {
  url = "https://ipv4.icanhazip.com"
}

resource "digitalocean_firewall" "cloudflare_prometheus_analytics_fw" {
  name = "cloudflare-prometheus-analytics-fw"
  
  droplet_ids = [digitalocean_droplet.prometheus_analytics.id]

  inbound_rule {
    protocol    = "tcp"
    port_range  = "22"
    source_addresses = concat(["${chomp(data.http.my_ip.response_body)}"],data.cloudflare_ip_ranges.cloudflare.cidr_blocks)
  }

  inbound_rule {
    protocol    = "icmp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol    = "tcp"
    port_range = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol    = "udp"
    port_range = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol    = "icmp"
    port_range = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}