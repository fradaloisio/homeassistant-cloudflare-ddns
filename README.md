# Cloudflare DDNS HomeAssistant Add-on

This HomeAssistant add-on runs the
[timothymiller/cloudflare-ddns](https://github.com/timothymiller/cloudflare-ddns)
script inside Home Assistant, updating your A/AAAA records whenever your public IP changes.

## Configuration

1. Install the add-on.
2. In the *Configuration* tab, you'll set up your Cloudflare details. The configuration is a YAML object.
    The `cloudflare` key holds a list of configurations. Each item in this list corresponds to **one subdomain** you want to manage.
    For each subdomain, you need to provide:
    * `api_token`: Your Cloudflare API Token.
    * `zone_id`: The Zone ID of the domain you want to update.
    * `name`: The name of the subdomain. Use `""` for the root domain (e.g., `example.com`) or a name like `"www"` for `www.example.com`.
    * `proxied`: Set to `true` if you want Cloudflare to proxy this record, `false` otherwise.

    You also need to set the global options: `a`, `aaaa`, `purgeUnknownRecords`, `ttl`, and `update_interval`.

    Here's an example of how your configuration should look in the Home Assistant UI. This example configures two subdomains (`homeassistant.yourdomain.com` and `foo.yourdomain.com`) for the same zone:

    ```yaml
      - api_token: "YOUR_CLOUDFLARE_API_TOKEN"
        zone_id: "YOUR_CLOUDFLARE_ZONE_ID"
        name: "homeassistant"
        proxied: true
      - api_token: "YOUR_CLOUDFLARE_API_TOKEN"
        zone_id: "YOUR_CLOUDFLARE_ZONE_ID"
        name: "foo"
        proxied: true
    ```

    The add-on will then take this configuration and format it as needed for the `cloudflare-ddns.py` script (which uses a slightly different structure internally, as seen in its [config-example.json](https://github.com/timothymiller/cloudflare-ddns/blob/master/config-example.json)).
