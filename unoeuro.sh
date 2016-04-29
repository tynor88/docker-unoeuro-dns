#!/bin/bash

if [ -f /config/unoeuro.new.conf ]; then
  tr -d '\r' < /config/unoeuro.new.conf > /tmp/unoeuro.new.conf
  . /tmp/unoeuro.new.conf
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
else
  echo "Please enter your domain, hostname and apikey as environment variables in your docker run command. See info box for details"
fi
