#!/bin/bash

  rm -f /config/unoeuro.new.conf
  # Check to make sure the domain, hostname and apikey are set
  if [ -z "$DOMAIN" ] || [ -z "$HOSTNAME" ] || [ -z "$APIKEY" ]; then
    echo "Please pass your domain, hostname and apikey as environment variables in your docker run command. See docker info for more details."
    if [ -f /config/unoeuro.conf ]; then
      echo "Retrieving variables from old unoeuro.conf"
      tr -d '\r' < /config/unoeuro.conf > /tmp/unoeuro.conf
      . /tmp/unoeuro.conf
      echo -e "DOMAIN=$DOMAIN \nHOSTNAME=$HOSTNAME \nAPIKEY=$APIKEY \n" > /config/unoeuro.new.conf
    fi
  else
    echo "Retrieving domain, hostname and apikey from the environment variables"
    echo -e "DOMAIN=$DOMAIN \nHOSTNAME=$HOSTNAME \nAPIKEY=$APIKEY \n" > /config/unoeuro.new.conf
  fi
  
  echo "Fixing permissions"
  chmod -R go+rw /config
  
  #Get docker env timezone and set system timezone
  echo $TZ > /etc/timezone
  export DEBCONF_NONINTERACTIVE_SEEN=true DEBIAN_FRONTEND=noninteractive
  dpkg-reconfigure tzdata
