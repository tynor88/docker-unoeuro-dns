FROM phusion/baseimage:0.9.19
MAINTAINER tynor88 <tynor@hotmail.com>

#Adding Custom files
COPY init/ /etc/my_init.d/
COPY cron/ /etc/cron.d/
COPY app/script/ /app/script/
RUN chmod -v +x /etc/service/*/run /etc/my_init.d/*.sh /app/script/*.sh
