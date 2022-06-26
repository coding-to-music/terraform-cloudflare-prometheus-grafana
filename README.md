# terraform-cloudflare-prometheus-grafana

# 🚀 Javascript full-stack 🚀

https://github.com/coding-to-music/terraform-cloudflare-prometheus-grafana

From / By Paolo Tagliaferri https://github.com/Vortexmind

https://github.com/Vortexmind/terraform-cloudflare-prometheus-grafana

## Restart grafana-server:

```
sudo systemctl restart grafana-server
```

## Environment variables:

```java

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
