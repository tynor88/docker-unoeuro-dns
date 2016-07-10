#!/bin/bash

. /config/unoeuro.conf
RESPONSE=$(curl -s -L "https://api.unoeuro.com/ddns.php?apikey=$APIKEY&domain=$DOMAIN&hostname=$HOSTNAME")
if [[ "$RESPONSE" == good* ]]; then
  UPDATE_MESSAGE="IP was updated (${RESPONSE#*good }) for domain: $DOMAIN hostname: $HOSTNAME"
  echo $UPDATE_MESSAGE
  if [[ ! -v "$PUSHBULLET_ACCESS_TOKEN" ]]; then
    RESPONSE=$(curl --header 'Access-Token: $PUSHBULLET_ACCESS_TOKEN' --header 'Content-Type: application/json' --data-binary '{"body":"$UPDATE_MESSAGE","title":"IP Updated","type":"note"}' --request POST https://api.pushbullet.com/v2/pushes)
  fi
elif [ "$RESPONSE" = "nochg" ]; then
  echo "The record is already set to the IP given"
elif [ "$RESPONSE" = "badauth" ]; then
  echo "Invalid ApiKey ($APIKEY)"
elif [[ "$RESPONSE" == dnserr* ]]; then
  echo "Error returned from UnoEuro: $RESPONSE"
else
  echo "Something went wrong, please check your settings"
fi
