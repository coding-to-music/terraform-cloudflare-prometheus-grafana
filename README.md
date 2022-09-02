# terraform-cloudflare-prometheus-grafana

# 🚀 Javascript full-stack 🚀

https://github.com/coding-to-music/terraform-cloudflare-prometheus-grafana

From / By Paolo Tagliaferri https://github.com/Vortexmind

https://www.paolotagliaferri.com/monitor-your-website-with-cloudflare-prometheus-grafana/

https://github.com/Vortexmind/terraform-cloudflare-prometheus-grafana

Example of a Grafana dashboard, using data from Prometheus:

![The exporter container up and running](https://github.com/coding-to-music/terraform-cloudflare-prometheus-grafana/blob/main/images/image2-5.avif?raw=true)

![Grafana screenshot](https://github.com/coding-to-music/terraform-cloudflare-prometheus-grafana/blob/main/images/grafana_prometheus.png?raw=true)

## Digitalocean Droplet Prices

https://github.com/andrewsomething/do-api-slugs

https://slugs.do-api.dev

```
# https://slugs.do-api.dev/

# s-1vcpu-512mb-10gb  $4    10GB
# s-1vcpu-1gb         $6    25GB
# s-1vcpu-2gb         $12   50GB
# s-2vcpu-2gb         $18   60GB
# s-2vcpu-4gb         $24   80GB
# s-4vcpu-8gb         $48   160GB
```

## Quick Summary

terraform init

terraform plan

terraform apply -auto-approve

ssh -i /path/to/ssh-keyfile root@ip-address

https://dev.to/koddr/quick-how-to-clone-your-private-repository-from-github-to-server-droplet-vds-etc-39jm

ssh-keygen

put the id_rsa.pub contents into GitHub https://github.com/settings/keys

verify can clone from GitHub:

ssh -vT git@github.com

clone the docker project

run that

need to install terraform

https://www.terraform.io/downloads

wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update && sudo apt install terraform

terraform -v

docker-compose -f docker-compose-step1.yml up

docker-compose -f docker-compose-step2.yml up

docker-compose -f docker-compose-step3.yml up

docker-compose -f docker-compose-step4.yml up

terraform destroy -auto-approve

## Status

Grafana

- set up Prometheus data source
- load dashboards

```

```

## Restart grafana-server:

```
sudo systemctl restart grafana-server
```

## Environment variables:

```java
// terraform.tvars.example

# Digitalocean Configuration
digitalocean_token = ""
digitalocean_droplet_image = "docker-20-04"
digitalocean_droplet_region = "lon1"
digitalocean_droplet_size = "s-1vcpu-1gb"
digitalocean_key_name = ""
digitalocean_priv_key_path = ""

# Cloudflare Configuration
cloudflare_domain = ""
cloudflare_account_id = ""
cloudflare_tunnel_secret = "Some-very-secret-passphrase-you-only-know"
cloudflare_cname_record = "grafana"
cloudflare_ssh_cname_record = "ssh-browser"

# Used by Terraform to manage your Cloudflare resources
cloudflare_api_token = ""
# Used by the Prometheus Exporter to pull your analytics from Cloudflare GraphQL
cloudflare_analytics_api_token = ""

# Authorized user for Cloudflare Access
user_email = ""
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

## terraform init

```
tf init
```

Output:

```
Initializing the backend...

Initializing provider plugins...
- Reusing previous version of cloudflare/cloudflare from the dependency lock file
- Reusing previous version of hashicorp/http from the dependency lock file
- Reusing previous version of digitalocean/digitalocean from the dependency lock file
- Installing cloudflare/cloudflare v3.1.0...
- Installed cloudflare/cloudflare v3.1.0 (signed by a HashiCorp partner, key ID DE413CEC881C3283)
- Installing hashicorp/http v2.1.0...
- Installed hashicorp/http v2.1.0 (signed by HashiCorp)
- Installing digitalocean/digitalocean v2.14.0...
- Installed digitalocean/digitalocean v2.14.0 (signed by a HashiCorp partner, key ID F82037E524B9C0E8)

Partner and community providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://www.terraform.io/docs/cli/plugins/signing.html

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

## terraform apply

```
Plan: 4 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + success_message = (known after apply)
cloudflare_access_ca_certificate.ssh_short_lived: Creating...
cloudflare_access_ca_certificate.ssh_short_lived: Creation complete after 0s [id=e2cb52dc8d3af48a5e1b6c288d43638ea44c504e80caaf39]
digitalocean_droplet.prometheus_analytics: Creating...
digitalocean_droplet.prometheus_analytics: Still creating... [10s elapsed]
digitalocean_droplet.prometheus_analytics: Still creating... [20s elapsed]
digitalocean_droplet.prometheus_analytics: Still creating... [30s elapsed]
digitalocean_droplet.prometheus_analytics: Still creating... [40s elapsed]
digitalocean_droplet.prometheus_analytics: Creation complete after 43s [id=306019345]
data.digitalocean_droplet.prometheus_analytics: Reading...
digitalocean_project.cloudflare_prometheus_analytics: Creating...
digitalocean_firewall.cloudflare_prometheus_analytics_fw: Creating...
data.digitalocean_droplet.prometheus_analytics: Read complete after 0s [name=cloudflare-prometheus-analytics]
digitalocean_firewall.cloudflare_prometheus_analytics_fw: Creation complete after 0s [id=]
digitalocean_project.cloudflare_prometheus_analytics: Creation complete after 4s [id=]

Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

Outputs:

success_message = <<EOT

    Your droplet is up and running at ip_address

    Direct SSH Command (only allowed from ip_address :
        ssh -i /home/tmc/.ssh root@ip_address

    Or navigate to https://ssh-browser.example.com to use Browser Based authentication.

    It takes some time for the Droplet to boot up and start the stack. To check progress, SSH in the droplet and run
    less /var/log/cloud-init-output.log

    Once startup is complete, go to https://grafana.example.com to reach your Grafana instance. The instance is behind Cloudflare
    Access protection, you will need to enter your email address to recieve an OTP token.
    After Cloudflare Access authentication, use the default `admin` (username) `admin` (password) to authenticate in Grafana.

    Remember to:
     - Add your Prometheus Data Source in Grafana (use http://prometheus:9090 for the URL)
     - Import the Grafana dashboard for a quick start: https://grafana.com/grafana/dashboards/13133
```

## view what is running on the new droplet

```
root@cloudflare-prometheus-analytics:~# docker container ls
```

```
root@cloudflare-prometheus-analytics:~# docker container ls
CONTAINER ID   IMAGE                    COMMAND                  CREATED         STATUS         PORTS                                       NAMES
d9ad4961bf5e   grafana/grafana:latest   "/run.sh"                7 minutes ago   Up 7 minutes   0.0.0.0:3000->3000/tcp, :::3000->3000/tcp   scripts_grafana_1
4d45cbc59cf9   prom/prometheus:latest   "/bin/prometheus --c…"   7 minutes ago   Up 7 minutes   0.0.0.0:9090->9090/tcp, :::9090->9090/tcp   scripts_prometheus_1
```

## view open files using `lsof``

```
sudo lsof -n -P -i +c 13
```

Output:

```
COMMAND         PID            USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
sshd          29149            root    3u  IPv4 160205      0t0  TCP *:22 (LISTEN)
sshd          29149            root    4u  IPv6 160207      0t0  TCP *:22 (LISTEN)
docker-proxy  39700            root    4u  IPv4 174230      0t0  TCP *:9090 (LISTEN)
docker-proxy  39704            root    4u  IPv6 174238      0t0  TCP *:9090 (LISTEN)
docker-proxy  39814            root    4u  IPv4 174870      0t0  TCP *:3000 (LISTEN)
docker-proxy  39818            root    4u  IPv6 174878      0t0  TCP *:3000 (LISTEN)
sshd          77551            root    4u  IPv4 340011      0t0  TCP here->there:49666 (ESTABLISHED)
systemd-resol 89119 systemd-resolve   12u  IPv4 386895      0t0  UDP 127.0.0.53:53
systemd-resol 89119 systemd-resolve   13u  IPv4 386896      0t0  TCP 127.0.0.53:53 (LISTEN)
```

## sudo systemctl status

```
sudo systemctl status
```

```
● cloudflare-prometheus-analytics
    State: degraded
     Jobs: 0 queued
   Failed: 1 units
    Since: Mon 2022-06-27 18:44:35 UTC; 32min ago
   CGroup: /
           ├─user.slice
           │ └─user-0.slice
           │   ├─user@0.service …
           │   │ └─init.scope
           │   │   ├─115561 /lib/systemd/systemd --user
           │   │   └─115563 (sd-pam)
           │   └─session-5.scope
           │     ├─115551 sshd: root@pts/0
           │     ├─115646 -bash
           │     ├─115655 sudo systemctl status
           │     ├─115658 systemctl status
           │     └─115659 pager
           ├─init.scope
           │ ├─  1 /lib/systemd/systemd --system --deserialize 32
           │ └─352 bpfilter_umh
           └─system.slice
             ├─containerd.service …
             │ ├─  750 /usr/bin/containerd
             │ ├─39718 /usr/bin/containerd-shim-runc-v2 -namespace moby -id 4d45cbc59cf995c78cd38a69279c32d260c43d68276f701d06f45b58cd8b3dd1 -address /run/containerd/containerd.sock
             │ ├─39737 /bin/prometheus --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/prometheus --web.console.libraries=/usr/share/prometheus/console_libraries --web.console.templates=/usr/share/prometheus/consoles
             │ ├─39831 /usr/bin/containerd-shim-runc-v2 -namespace moby -id d9ad4961bf5e8f5bb69d353fde37706a602c8ced102f928f4741787475e17f9f -address /run/containerd/containerd.sock
             │ └─39851 grafana-server --homepath=/usr/share/grafana --config=/etc/grafana/grafana.ini --packaging=docker cfg:default.log.mode=console cfg:default.paths.data=/var/lib/grafana cfg:default.paths.logs=/var/log/grafana cfg:default.paths.plugins=/var/lib/g>
             ├─systemd-networkd.service
             │ └─89106 /lib/systemd/systemd-networkd
             ├─systemd-udevd.service
             │ ├─ 17487 /lib/systemd/systemd-udevd
             │ ├─115656 /lib/systemd/systemd-udevd
             │ └─115657 /lib/systemd/systemd-udevd
             ├─cron.service
             │ └─725 /usr/sbin/cron -f
             ├─system-serial\x2dgetty.slice
             │ └─serial-getty@ttyS0.service
             │   └─753 /sbin/agetty -o -p -- \u --keep-baud 115200,38400,9600 ttyS0 vt220
             ├─docker.service …
             │ ├─  810 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
             │ ├─39700 /usr/bin/docker-proxy -proto tcp -host-ip 0.0.0.0 -host-port 9090 -container-ip 172.18.0.3 -container-port 9090
             │ ├─39704 /usr/bin/docker-proxy -proto tcp -host-ip :: -host-port 9090 -container-ip 172.18.0.3 -container-port 9090
             │ ├─39814 /usr/bin/docker-proxy -proto tcp -host-ip 0.0.0.0 -host-port 3000 -container-ip 172.18.0.4 -container-port 3000
             │ └─39818 /usr/bin/docker-proxy -proto tcp -host-ip :: -host-port 3000 -container-ip 172.18.0.4 -container-port 3000
             ├─polkit.service
             │ └─4122 /usr/lib/policykit-1/polkitd --no-debug
             ├─networkd-dispatcher.service
             │ └─114182 /usr/bin/python3 /usr/bin/networkd-dispatcher --run-startup-triggers
             ├─multipathd.service
             │ └─506 /sbin/multipathd -d -s
             ├─accounts-daemon.service
             │ └─67277 /usr/lib/accountsservice/accounts-daemon
             ├─systemd-journald.service
             │ └─89125 /lib/systemd/systemd-journald
             ├─atd.service
             │ └─743 /usr/sbin/atd -f
             ├─unattended-upgrades.service
             │ └─791 /usr/bin/python3 /usr/share/unattended-upgrades/unattended-upgrade-shutdown --wait-for-signal
             ├─ssh.service
             │ └─29149 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups
             ├─snapd.service
             │ └─51890 /usr/lib/snapd/snapd
             ├─uuidd.service
             │ └─53589 /usr/sbin/uuidd --socket-activation
             ├─rsyslog.service
             │ └─111845 /usr/sbin/rsyslogd -n -iNONE
             ├─systemd-resolved.service
             │ └─89119 /lib/systemd/systemd-resolved
             ├─dbus.service
             │ └─726 /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
             ├─systemd-timesyncd.service
             │ └─89218 /lib/systemd/systemd-timesyncd
             ├─system-getty.slice
             │ └─getty@tty1.service
             │   └─756 /sbin/agetty -o -p -- \u --noclear tty1 linux
             └─systemd-logind.service
               └─739 /lib/systemd/systemd-logind
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
