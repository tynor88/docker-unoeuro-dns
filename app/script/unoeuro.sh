#!/bin/bash

#Load configuration
. /config/unoeuro.conf

UNOEURO_API_URL="https://api.unoeuro.com/ddns.php?apikey=$APIKEY&domain=$DOMAIN&hostname=$HOSTNAME"
PUSHBULLET_API_URL="https://api.pushbullet.com/v2/pushes"

send_pushbullet () {
  if [[ ! -z "$PUSHBULLET_ACCESS_TOKEN" ]]; then
    RESPONSE_PUSHBULLET=$(curl -s -L --header "Access-Token: $PUSHBULLET_ACCESS_TOKEN" --header "Content-Type: application/json" --data-binary "{\"body\":\"$1\",\"title\":\"$2\",\"type\":\"note\"}" --request POST "$PUSHBULLET_API_URL")
    if [[ "$RESPONSE_PUSHBULLET" == {\"error* ]]; then
      echo "Could not send Pusbullet notification due to an error: $RESPONSE_PUSHBULLET"
    else
      echo "Pushbullet notification sent"
    fi
  fi
}

RESPONSE_UNOEURO=$(curl -s -L "$UNOEURO_API_URL")

if [[ "$RESPONSE_UNOEURO" == good* ]]; then
  UPDATE_MESSAGE="IP was updated (${RESPONSE_UNOEURO#*good }) for domain: $DOMAIN hostname: $HOSTNAME"
  echo $UPDATE_MESSAGE
  send_pushbullet "$UPDATE_MESSAGE" "IP Updated"
elif [ "$RESPONSE_UNOEURO" = "nochg" ]; then
  echo "The DNS record is already set to the IP given"
elif [ "$RESPONSE_UNOEURO" = "badauth" ]; then
  ERROR_MESSAGE="Invalid UnoEuro ApiKey ($APIKEY)"
  echo $ERROR_MESSAGE
  send_pushbullet "$ERROR_MESSAGE" "Error updating DNS record"
elif [[ "$RESPONSE_UNOEURO" == dnserr* ]]; then
  ERROR_MESSAGE="Error returned from UnoEuro when updating DNS record: $RESPONSE_UNOEURO"
  echo $ERROR_MESSAGE
  send_pushbullet "$ERROR_MESSAGE" "Error updating DNS record"
else
  ERROR_MESSAGE="Something went wrong when receiving response from UnoEuro, please check your settings: $RESPONSE_UNOEURO"
  echo $ERROR_MESSAGE
  send_pushbullet "$ERROR_MESSAGE" "Error updating DNS record"
fi
