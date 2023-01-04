FROM alpine:latest
LABEL maintainer="Bernd Klaus"

ENV PDNSCONF_GPGSQL_HOST="postgres" \
    PDNSCONF_GPGSQL_PORT="5432" \
    PDNSCONF_GPGSQL_READPORT="5433" \
    PDNSCONF_GPGSQL_DBNAME="pdns" \
    PDNSCONF_GPGSQL_USER="postgres" \
    PDNSCONF_GPGSQL_PASSWORD="changeme" \
    PDNSCONF_API_KEY="changeme" \
    PDNSCONF_FLYIO_MAINREGION="fra" \
    PDNSCONF_DEFAULT_SOA="a.dns.server. web.hostmaster. 0 10800 3600 604800 3600"

RUN apk --update --no-cache add \
        pdns \
        pdns-backend-pgsql \
        pdns-backend-bind \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/* \
    && rm -rf /var/log/* \
    && rm -f /etc/pdns/pdns.conf \
    && mkdir -p /etc/pdns/conf.d

COPY pdns.conf /etc/pdns/pdns.conf
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 53/tcp 53/udp 80/tcp

ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "/usr/sbin/pdns_server", "--disable-syslog=yes"]
