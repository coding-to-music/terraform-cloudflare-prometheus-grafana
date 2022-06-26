# terraform-cloudflare-prometheus-grafana

# 🚀 Javascript full-stack 🚀

https://github.com/coding-to-music/terraform-cloudflare-prometheus-grafana

From / By Paolo Tagliaferri https://github.com/Vortexmind

https://www.paolotagliaferri.com/monitor-your-website-with-cloudflare-prometheus-grafana/

https://github.com/Vortexmind/terraform-cloudflare-prometheus-grafana

Example of a Grafana dashboard, using data from Prometheus:

![The exporter container up and running](https://github.com/coding-to-music/terraform-cloudflare-prometheus-grafana/blob/main/images/image2-5.avif?raw=true)

![Grafana screenshot](https://github.com/coding-to-music/terraform-cloudflare-prometheus-grafana/blob/main/images/grafana_prometheus.png?raw=true)

## Restart grafana-server:

```
sudo systemctl restart grafana-server
```

## Environment variables:

```java
        "AccountTag"   : "${account_id}",
        "TunnelID"     : "${cloudflare_tunnel_id}",
        "TunnelName"   : "${cloudflare_tunnel_name}",
        "TunnelSecret" : "${cloudflare_tunnel_secret}"

github_token: ${{ github.token }}

CF_API_TOKEN=${cloudflare_analytics_api_token}

resource "digitalocean_droplet" "prometheus_analytics" {
  image  = var.digitalocean_droplet_image
  name   = "cloudflare-prometheus-analytics"
  region = var.digitalocean_droplet_region
  size   = var.digitalocean_droplet_size
  ssh_keys = [
    data.digitalocean_ssh_key.default.id
  ]
  user_data = templatefile("${path.module}/cloud-init/bootstrap-cloud-init.yaml", {
      account_id = var.cloudflare_account_id
      fqdn = local.cloudflare_fqdn
      ssh_fqdn = local.cloudflare_ssh_fqdn

Configure the Docker Containers (on Synology DSM)
Let's set up the exporter first. We will use the lablabs/cloudflare_exporter image and set it up with the following environment variables:

CF_ZONES: the zone ID from your Cloudflare Zone's Overview panel.
CF_API_TOKEN: the Analytics token you created earlier in the Cloudflare Dashboard.
LISTEN: If you follow the example, use:9091 (this will make the exporter listen on all interfaces on the 9091 port for incoming Prometheus scraping requests).

First, let's save the prometheus.yml configuration file we described above somewhere on our DSM. I usually create a folder for each container I am running and place all the related files there.

```

## GitHub

```java
git init
git add .
git remote remove origin
git commit -m "first commit"
git branch -M main
git remote add origin git@github.com:coding-to-music/terraform-cloudflare-prometheus-grafana.git
git push -u origin main
```

# 👷 Sample Prometheus & Grafana terraform stack to monitor a Cloudflare zone

A sample environment on Digitalocean for monitoring the metrics of a given Cloudflare zone using GraphQL API.

- The environment (Prometheus / Grafana / Prometheus Exporter) runs in Digitalocean
- Grafana is exposed on a configurable FQDN of the monitored domain.
- Grafana is protected by Cloudflare Access
- The Grafana instance is reachable via a Cloudflare Tunnel

## Documentation

https://www.paolotagliaferri.com/monitor-your-website-with-cloudflare-prometheus-grafana/

## License

This work is available under [MIT License](https://github.com/Vortexmind/terraform-cloudflare-prometheus-grafana/blob/main/LICENSE)

# Monitor your website with Cloudflare, Prometheus and Grafana

https://www.paolotagliaferri.com/monitor-your-website-with-cloudflare-prometheus-grafana/

Learn how to set up monitoring for your website using Cloudflare's GraphQL API, Prometheus and Grafana. Self host (Synology) or build a Terraform environment on Digitalocean.

Learn how to set up monitoring for your website using Cloudflare's GraphQL API, Prometheus and Grafana.

By Paolo Tagliaferri

Oct 10, 2021 • 8 min read

If you are running a website, you will be interested in keeping a close eye on the performance and security metrics of the associated traffic. If you use a service such as Cloudflare to improve the performance and security of your web application, you will already have access to pretty exhaustive analytics dashboards and proactive notifications that you can use to keep everything in check and to be alerted about important events.

However, if you are like me, you may have your analytics dashboard. You might be already running an instance of Grafana and pulling data from various sources, including your smart home sensors, or your intelligent fridge - mine is quite dumb, but that's beyond the scope of this conversation😜.

When you already have your monitoring stack, you will want to integrate it all into a unique visualization that is independent of the data source.

In this article, we will see how to achieve just that using Prometheus and one of its exporters, getting the data on demand from the Cloudflare GraphQL API. Since in my case I run Docker images on my Synology DSM - I will start from explaining how to achieve it there but we will also see a more general example at the end.

Let's dive in!

By the way - if you are interested in Grafana and Smart Home - I wrote about it in the past here: https://www.paolotagliaferri.com/data-visualization-with-telegraf-influxdb-grafana-on-synology-home-automation/

## Target Architecture

As usual, I like to illustrate what we are set to achieve with a handy diagram (made with the awesome Excalidraw) https://excalidraw.com/

![The target architecture](https://github.com/coding-to-music/terraform-cloudflare-prometheus-grafana/blob/main/images/Prometheus---Grafana---Cloudflare-1.avif?raw=true)

The target architecture

In the diagram, we can see how our web application is protected behind Cloudflare. Why would we want to do this? There are many reasons and I already covered this topic in a few earlier posts, so we won't spend more time on it. https://www.paolotagliaferri.com/secure-https-setup-with-cloudflare/

All the traffic for our web application, both from legitimate users/integrations and bad actors, will be ingested on Cloudflare's global network. Cloudflare will remove bad traffic based on our security configuration, and forward the good requests to our webserver.

Because Cloudflare is acting as a reverse proxy in front of our web application, we want to get all the interesting data out of Clouflare and into our Grafana. We will use Prometheus to store our metrics in time series and act as a data source for our dashboards.

We will also use a Prometheus Exporter: this is an adapter that converts third party data formats (such as the data returned by the Cloudflare GraphQL API) into the required input format for Prometheus.

In my example, all the above software (Grafana, Prometheus and the exporter) will be run as Docker containers on a Synology DSM. I explained in the past how to get Grafana going on Synology/Docker, so we will focus on the other two in this article. https://www.paolotagliaferri.com/home-assistant-data-persistence-and-visualization-with-grafana-and-influxdb/

## Prometheus configuration

You can find the Prometheus image on Docker Hub. https://hub.docker.com/r/prom/prometheus/

Before you start up Prometheus, you need to configure it. A simple configuration file is shown below (see the docs for the full information). https://prometheus.io/docs/prometheus/latest/configuration/configuration/

```
# my global config
global:
  scrape_interval: 15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
  # scrape_timeout is set to the global default (10s).

# Alertmanager configuration
alerting:
  alertmanagers:
    - static_configs:
        - targets:
          # - alertmanager:9093


# A scrape configuration containing exactly one endpoint to scrape:
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: "website_data_fom_cloudflare"

    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.

    static_configs:
      - targets: ["localhost:9091"]
```

prometheus.yml

Here, we define how frequently we will scrape the data sources ( scrape_interval ) and evaluate the rules ( evaluation_timeout ). Rules are used for recording data: for example to pre-record certain expressions to save time when querying. They are also used to define alert conditions and notifications to external services. We will not set this up for the time being.

We set up a scraping job: it has a job_name and also an endpoint that will be queried by Prometheus to pull the metrics ( targets ). In our case, Prometheus will look at http://localhost:9091/metrics to retrieve the data. This is where we will run our exporter.

## Exporter configuration

As discussed, we need a Prometheus Exporter that is capable of pulling the data from Cloudflare's GraphQL API and adapt it into the format required by Prometheus, then publish it at an endpoint that Prometheus can poll.

For our example, we will use the exporter available at https://github.com/lablabs/cloudflare-exporter. There is also a nice article explaining how it was made and also explaining why the concepts behind our simple home-baked setup can be extended to day-to-day production setups. https://www.lablabs.io/blog/improving-your-monitoring-setup-by-integrating-cloudflares-analytics-data-into-prometheus-and-grafana

The exporter is also available as a Docker Image on DockerHub, which is exactly what we need. https://hub.docker.com/r/lablabs/cloudflare_exporter

To configure it, we need to grab a Cloudflare API Token which has Read access for Analytics for the Cloudflare zone we want to monitor. The exporter supports also the Cloudflare Global API Key however following the principle of "least privilege" it is recommended to use the token instead. If you are not sure, refer to the step-by-step guide to create your token. https://developers.cloudflare.com/analytics/graphql-api/getting-started/authentication/api-token-auth

## Configure the Docker Containers (on Synology DSM)

Let's set up the exporter first. We will use the `lablabs/cloudflare_exporter` image and set it up with the following environment variables:

- `CF_ZONES`: the zone ID from your Cloudflare Zone's Overview panel.
- `CF_API_TOKEN`: the Analytics token you created earlier in the Cloudflare Dashboard.
- `LISTEN`: If you follow the example, use:9091 (this will make the exporter listen on all interfaces on the 9091 port for incoming Prometheus scraping requests).

  The container can run as unprivileged, and since it shouldn't consume too many resources you can configure it with limits just to be on the safe side. In my case, I have used the host network without port mappings.

![Grafana screenshot](https://github.com/coding-to-music/terraform-cloudflare-prometheus-grafana/blob/main/images/image-3.webp?raw=true)

The exporter container is up and running

Now that we have the exporter up and running, we can test that it is working correctly by hitting the metrics endpoint `http://<your DSM IP/hostname>:9091/metrics`. If everything is correct, we should see some metrics ready to be consumed by Prometheus, which is what we need to start up next.

First, let's save the `prometheus.yml` configuration file we described above somewhere on our DSM. I usually create a folder for each container I am running and place all the related files there.

We will be using the `prom/prometheus` image we downloaded earlier. For this basic setup, there isn't much to set up. We just need to map our configuration file from the path on the Synology to `/etc/prometheus/prometheus.yml` (which is where it will be expected in the container).

The Prometheus data will be persisted in a volume that is automatically created with the container. For production deployments, the documentation recommends using a named volume instead, but for our purposes, this will be more than enough.

By default, Prometheus will run on port `9090`. If that works for you, you can just start the container on the host network, otherwise map a different port on the host side.

Once you started the container, you can head to http://<your DSM IP/hostname>:9090/targets: if everything looks good, you should reach Prometheus's web interface. The `Targets` page will show you what is being scraped and in our case, we should see some statistics about our only target so far, the exporter. Make sure the `State` is `UP` meaning they can talk to each other 😎.

![Grafana screenshot](https://github.com/coding-to-music/terraform-cloudflare-prometheus-grafana/blob/main/images/image-4.avif?raw=true)

Prometheus Web UI: Targets

As you can see, you can use Prometheus's Web UI to inspect the metrics. However, it will be much easier to set up some swanky dashboards with Grafana!

## Add Prometheus as a Grafana Data Source

Assuming you already have Grafana up and running, head to `Configuration > Data Sources` and add your Prometheus instance.

![Grafana screenshot](https://github.com/coding-to-music/terraform-cloudflare-prometheus-grafana/blob/main/images/image-6.avif?raw=true)

Add Prometheus as Data Source in Grafana

Because so far we are being naughty, and we are setting everything up on unencrypted HTTP, all we need to do here is to add the URL to our Prometheus instance (on the configured port) and select Server access. Save and ... that was it!: Grafana can now consume all the metrics stored in Prometheus!

## Grafana Dashboard

This one is also easy. The folks at Labyrinth Labs have shared a handy dashboard that can be easily imported and used directly. You can also use it as a starting point to create your panels. https://grafana.com/grafana/dashboards/13133

Simply import the dashboard and point it to your Prometheus instance, and watch out for the flood of data 🌊

![The exporter container up and running](https://github.com/coding-to-music/terraform-cloudflare-prometheus-grafana/blob/main/images/image2-5.avif?raw=true)

Labyrinth Labs's Cloudflare Analytics Grafana Dashboard

## Bonus content - Terraformed version

Well, it was easy to get it all up and running huh?

To make it a bit more interesting for you, I have created another version in Terraform. It runs the same above stack (Grafana / Prometheus / Exporter) in a Digitalocean VM. Further to that, it exposes the Grafana instance securely via a combination of Cloudflare Access and Cloudflare Tunnel. Feel free to pull the code from https://github.com/Vortexmind/terraform-cloudflare-prometheus-grafana

```
git clone git@github.com:Vortexmind/terraform-cloudflare-prometheus-grafana.git
```

How does this modify our architecture? Let's see:

![Grafana screenshot](https://github.com/coding-to-music/terraform-cloudflare-prometheus-grafana/blob/main/images/Prometheus---Grafana---Cloudflare---Digital-Ocean-1.webp?raw=true)

Stack on Digitalocean & protection with Cloudflare Access

We have now exposed our Grafana instance using a secure Cloudflare Tunnel. https://www.cloudflare.com/en-gb/products/tunnel/ This means that our VM is connected to nearby Cloudflare datacenters and is ready to accept authorized traffic to our Grafana.

To determine who can reach it, we use Cloudflare Access https://www.cloudflare.com/en-gb/teams/access/ to define our Grafana application and attach security policies to it. In my sample Terraform setup, I just specify an authorized e-mail address that will be able to receive the standard One-Time-Pin for authentication. https://developers.cloudflare.com/cloudflare-one/identity/one-time-pin

If you look at the firewall configuration of the Digitalocean VM, inbound HTTP (s) traffic is not allowed. The only way someone can reach the Grafana is via Cloudflare Access and the Tunnel.

This means we can access our monitoring tools from anywhere 🏝️as long as we have a reliable internet connection. We can also do it securely, since it's protected by Access.

A final parting thought: when you manage your infrastructure as code, it is easier to keep it monitored and secure with automated checks. An example of this is the `tfsec-pr-commenter-action` (available here: https://github.com/aquasecurity/tfsec-pr-commenter-action) that can be added to your Github workflow. The action will scan your Terraform configuration and leave useful comments for potentially dangerous configurations.

For example, you can see the comments it left when I committed my initial template - in my case warning that my Digitalocean firewall template is very permissive about outgoing traffic (and also for inbound ICMP traffic). As this is only a tutorial, and the infrastructure short lived, that's fine. But if this was a setup for production it would be very handy to have a chance of reviewing such comments from the automated template review. https://github.com/Vortexmind/terraform-cloudflare-prometheus-grafana/pull/1

At the very least this is much better than managing all your set-up manually and then forgetting open ports! 💣

I hope you enjoyed this short tutorial. Let me know if you have any comments and thanks for reading!
