output "success_message" { 
    value = <<EOF
    
    Your droplet is up and running at ${digitalocean_droplet.prometheus_analytics.ipv4_address}
    
    Direct SSH Command (only allowed from Chromebook ${chomp(var.chromebook_ipv4_address)} : 
        ssh -i ${var.chromebook_priv_key_path} root@${digitalocean_droplet.prometheus_analytics.ipv4_address}

    Direct SSH Command (only allowed from Development Droplet ${chomp(data.http.my_ip.response_body)} : 
        ssh -i ${var.digitalocean_priv_key_path} root@${digitalocean_droplet.prometheus_analytics.ipv4_address}

    Or navigate to https://${local.cloudflare_ssh_fqdn} to use Browser Based authentication.

    It takes some time for the Droplet to boot up and start the stack. To check progress, SSH in the droplet and run 

        less /var/log/cloud-init-output.log

    or

        watch tail -100 /var/log/cloud-init-output.log

    Once startup is complete, go to https://${local.cloudflare_fqdn} to reach your Grafana instance. The instance is behind Cloudflare 
    Access protection, you will need to enter your ${var.user_email} address to recieve an OTP token.
    After Cloudflare Access authentication, use the default `admin` (username) `admin` (password) to authenticate in Grafana.

    Remember to:
     - Add your Prometheus Data Source in Grafana (use http://prometheus:9090 for the URL)
     - Import the Grafana dashboard for a quick start: https://grafana.com/grafana/dashboards/13133

    ${data.cloudflare_zones.configured_zone.zones[0].id}
    ${data.cloudflare_zones.configured_zone.zones[0].name}

    EOF
}
    # user is ${var.user_email}
