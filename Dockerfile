FROM phusion/baseimage:0.9.16

MAINTAINER tynor88 <tynor@hotmail.com>

VOLUME ["/config"]

# Add dynamic dns script
ADD unoeuro.sh /root/unoeuro/unoeuro.sh

RUN chmod +x /root/unoeuro/unoeuro.sh && \
mkdir -p /etc/my_init.d

ADD firstrun.sh /etc/my_init.d/firstrun.sh
ADD unoeurocron.conf /root/unoeuro/unoeurocron.conf

RUN chmod +x /etc/my_init.d/firstrun.sh && \
crontab /root/unoeuro/unoeurocron.conf

RUN cron
