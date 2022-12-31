FROM alpine:latest
LABEL maintainer="Bernd Klaus"

ENV PDNSCONF_GPGSQL_HOST="postgres" \
    PDNSCONF_GPGSQL_PORT="5432" \
    PDNSCONF_GPGSQL_DBNAME="pdns" \
    PDNSCONF_GPGSQL_USER="postgres" \
    PDNSCONF_GPGSQL_PASSWORD="changeme" \
    PDNSCONF_API_KEY="changeme" \
    PDNSCONF_FYLIO_GIP="0.0.0.0" \
    PDNSCONF_SERVER_TYPE="primary"

RUN apk --update --no-cache add \
        pdns \
        pdns-backend-lua2 \
        pdns-backend-pgsql \
        pdns-backend-bind \
        pdns-backend-geoip \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/* \
    && rm -rf /var/log/* \
    && rm -f /etc/pdns/pdns.conf \
    && mkdir -p /etc/pdns/conf.d

COPY pdns.conf /etc/pdns/pdns.conf
COPY entrypoint.sh /

EXPOSE 53/tcp 53/udp 80/tcp

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/usr/sbin/pdns_server", "--disable-syslog=yes"]