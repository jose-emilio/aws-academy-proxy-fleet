FROM debian:latest

ENV SQUID_CACHE_DIR=/var/spool/squid \
    SQUID_LOG_DIR=/var/log/squid \
    SQUID_USER=proxy

RUN apt-get update  && DEBIAN_FRONTEND=noninteractive apt-get install -y squid && rm -rf /var/lib/apt/lists/*
RUN usermod -a -G tty proxy
COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh
COPY squid.conf /etc/squid/squid.conf
EXPOSE 3128/tcp
USER proxy
ENTRYPOINT ["/sbin/entrypoint.sh"]
