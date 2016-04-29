#!/bin/bash

. /config/unoeuro.conf
RESPONSE=$(curl -s -L "https://api.unoeuro.com/ddns.php?apikey=$APIKEY&domain=$DOMAIN&hostname=$HOSTNAME")
if [[ "$RESPONSE" == good* ]]; then
  echo "IP was updated (${RESPONSE#*good }) for domain: $DOMAIN hostname: $HOSTNAME"
elif [ "$RESPONSE" = "nochg" ]; then
  echo "The record is already set to the IP given"
elif [ "$RESPONSE" = "badauth" ]; then
  echo "Invalid ApiKey ($APIKEY)"
elif [[ "$RESPONSE" == dnserr* ]]; then
  echo "Error returned from UnoEuro: $RESPONSE"
else 
  echo "Something went wrong, please check your settings"
fi