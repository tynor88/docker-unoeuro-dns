#!/bin/bash

if [ -f /config/unoeuro.new.conf ]; then
  tr -d '\r' < /config/unoeuro.new.conf > /tmp/unoeuro.new.conf
  . /tmp/unoeuro.new.conf
  RESPONSE=$(curl -s -L "https://api.unoeuro.com/ddns.php?apikey=$APIKEY&domain=$DOMAIN&hostname=$HOSTNAME")
  if [[ "$RESPONSE" == good* ]]; then
    echo "[$(date)] Your IP was updated (${RESPONSE#*good }) for domain: $DOMAIN hostname: $HOSTNAME"
  elif [ "$RESPONSE" = "nochg" ]; then
    echo "[$(date)] The record is already set to the IP given"
  elif [ "$RESPONSE" = "badauth" ]; then
    echo "[$(date)] Invalid login (ApiKey)"
  elif [[ "$RESPONSE" == dnserr* ]]; then
    echo "[$(date)] Error returned from UnoEuro: $RESPONSE"
  else 
    echo "[$(date)] Something went wrong, please check your settings"
  fi
else
  echo "[$(date)] Please enter your domain, hostname and apikey as environment variables in your docker run command. See info box for details"
fi
