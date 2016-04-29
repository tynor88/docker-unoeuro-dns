# docker-unoeuro-dns
Keep your DNS records for your own domains updated with this UnoEuro DDNS script. UnoEuro provides a free DNS service for your private domains. You can move all your domains for free and have them managed at UnoEuro.

## Usage

```
docker create \
  --name=UnoEuroDNS \
  -e DOMAIN=<domain> \
  -e HOSTNAME=<hostname> \
  -e APIKEY=<apikey> \
  tynor88/unoeuro-dns
```

**Parameters**

* `-e DOMAIN` The name of the domain (product) you wish to update (without www). Can be in punycode format. Ie. "example.com"
* `-e HOSTNAME` The name of the A record you wish to update. The domain should not be appended to this. Ie. use "home", not "home.example.com"
* `-e APIKEY` The API key for the UnoEuro account. Found in UnoEuro's controlpanel

## Setting up the application

Make sure your domain's DNS is managed by UnoEuro and retrieve your Api-key (https://www.unoeuro.com/controlpanel/account.php). Then run the docker create command above with your domain, hostname and apikey  
It will update your IP with the UnoEuro DNS service every 5 minutes  

## Info

* Shell access whilst the container is running: `docker exec -it UnoEuroDNS /bin/bash`
* Upgrade to the latest version: `docker restart UnoEuroDNS`
* To monitor the logs of the container in realtime: `docker logs -f UnoEuroDNS`

## Versions

+ **2016/04/29:** Initial release
