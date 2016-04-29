#!/bin/bash

# Check to make sure the domain, hostname and apikey are set
if [ -z "$DOMAIN" ] || [ -z "$HOSTNAME" ] || [ -z "$APIKEY" ]; then
  echo "Please pass your domain, hostname and apikey as environment variables in your docker run command. See docker info for more details."
  exit 1
else
  echo "Retrieving domain, hostname and apikey from the environment variables"
  echo -e "DOMAIN=$DOMAIN \nHOSTNAME=$HOSTNAME \nAPIKEY=$APIKEY \n" > /config/unoeuro.conf
fi
  
echo "Fixing permissions..."
chmod -R go+rw /config