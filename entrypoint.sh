#!/bin/sh

sed -i 's|.*gpgsql-host=.*|'gpgsql-host="$PDNSCONF_GPGSQL_HOST"'|g' /etc/pdns/pdns.conf
sed -i 's|.*gpgsql-dbname=.*|'gpgsql-dbname="$PDNSCONF_GPGSQL_DBNAME"'|g' /etc/pdns/pdns.conf
sed -i 's|.*gpgsql-user=.*|'gpgsql-user="$PDNSCONF_GPGSQL_USER"'|g' /etc/pdns/pdns.conf
sed -i 's|.*gpgsql-password=.*|'gpgsql-password="$PDNSCONF_GPGSQL_PASSWORD"'|g' /etc/pdns/pdns.conf
sed -i 's|.*api-key=.*|'api-key="$PDNSCONF_API_KEY"'|g' /etc/pdns/pdns.conf
sed -i 's|.*default-soa-content=.*|'default-soa-content="$PDNSCONF_DEFAULT_SOA"'|g' /etc/pdns/pdns.conf


if [ "$PDNS_DNSDIST_ENABLED" ]; then
  sed -i 's|.*local-port=.*|'local-port=8053'|g' /etc/pdns/pdns.conf
  if  [ ! "$PDNS_DNSDIST_FAILOVER_IP" == "false" ]; then
    sed -i 's|.*failover-01.*|'newServer\(\{address="$PDNS_DNSDIST_FAILOVER_IP",\ name="failover",\ order=10\}\)'|g' /etc/dnsdist/dnsdist.conf
  fi
else
  sed -i 's|.*local-port=.*|'local-port=53'|g' /etc/pdns/pdns.conf
  if [ ! "dnsdist -V" &> /dev/null ]; then
    rm -rf /etc/dnsdist/
  elif [ "dnsdist -V" &> /dev/null ]; then
    apk del dnsdist
    rm -rf /etc/dnsdist/
  fi
fi


if [ "${PDNSCONF_FLYIO_MAINREGION}" == "${FLY_REGION}" ]; then
  sed -i 's|.*sedreplacementcode.*|'primary=yes\ \#Or:\ secondary=yes\ -sedreplacementcode'|g' /etc/pdns/pdns.conf
  sed -i 's|.*gpgsql-port=.*|'gpgsql-port="$PDNSCONF_GPGSQL_PORT"'|g' /etc/pdns/pdns.conf
else
  sed -i 's|.*sedreplacementcode.*|'secondary=yes\ \#Or:\ primary=yes\ -sedreplacementcode'|g' /etc/pdns/pdns.conf
  sed -i 's|.*gpgsql-port=.*|'gpgsql-port="$PDNSCONF_GPGSQL_READPORT"'|g' /etc/pdns/pdns.conf
  sed -i 's|gpgsql-host=top2|'gpgsql-host=top1'|g' /etc/pdns/pdns.conf
fi

echo "Lets Fly our PowerDNS!"

/usr/sbin/pdns_server --disable-syslog=yes &
/usr/bin/dnsdist --supervised --disable-syslog & 
wait -n
exit $?