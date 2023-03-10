#!/bin/sh

sed -i 's|.*gpgsql-dbname=.*|'gpgsql-dbname="$PDNSCONF_GPGSQL_DBNAME"'|g' /etc/pdns/pdns.conf
sed -i 's|.*gpgsql-user=.*|'gpgsql-user="$PDNSCONF_GPGSQL_USER"'|g' /etc/pdns/pdns.conf
sed -i 's|.*gpgsql-password=.*|'gpgsql-password="$PDNSCONF_GPGSQL_PASSWORD"'|g' /etc/pdns/pdns.conf
sed -i 's|.*api-key=.*|'api-key="$PDNSCONF_API_KEY"'|g' /etc/pdns/pdns.conf
sed -i 's|.*default-soa-content=.*|'default-soa-content="$PDNSCONF_DEFAULT_SOA"'|g' /etc/pdns/pdns.conf

if [ "${PDNSCONF_FLYIO_MAINREGION}" == "${FLY_REGION}" ]; then
  sed -i 's|.*gpgsql-port=.*|'gpgsql-port="$PDNSCONF_GPGSQL_PORT"'|g' /etc/pdns/pdns.conf
  sed -i 's|.*gpgsql-host=.*|'gpgsql-host="${PDNSCONF_FLYIO_MAINREGION}"."$PDNSCONF_GPGSQL_HOST"'|g' /etc/pdns/pdns.conf
else
  sed -i 's|.*gpgsql-port=.*|'gpgsql-port="$PDNSCONF_GPGSQL_READPORT"'|g' /etc/pdns/pdns.conf
  sed -i 's|.*gpgsql-host=.*|'gpgsql-host=top1.nearest.of."$PDNSCONF_GPGSQL_HOST"'|g' /etc/pdns/pdns.conf
fi

echo "Lets Fly our PowerDNS!"

exec "$@"
