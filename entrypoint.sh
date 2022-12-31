#!/bin/sh


sed -i 's|.*gpgsql-host=.*|'gpgsql-host=$PDNSCONF_GPGSQL_HOST'|g' /etc/pdns/pdns.conf
sed -i 's|.*gpgsql-port=.*|'gpgsql-port=$PDNSCONF_GPGSQL_PORT'|g' /etc/pdns/pdns.conf
sed -i 's|.*gpgsql-dbname=.*|'gpgsql-dbname=$PDNSCONF_GPGSQL_DBNAME'|g' /etc/pdns/pdns.conf
sed -i 's|.*gpgsql-user=.*|'gpgsql-user=$PDNSCONF_GPGSQL_USER'|g' /etc/pdns/pdns.conf
sed -i 's|.*gpgsql-password=.*|'gpgsql-password=$PDNSCONF_GPGSQL_PASSWORD'|g' /etc/pdns/pdns.conf
sed -i 's|.*api-key=.*|'api-key=$PDNSCONF_API_KEY'|g' /etc/pdns/pdns.conf
sed -i 's|.*local-address=.*|'local-address=$PDNSCONF_FYLIO_GIP'|g' /etc/pdns/pdns.conf




if [ "${PDNSCONF_SERVER_MODE}" == "master" ]; then
  sed -i 's|.*sedreplacementcode.*|'primary=yes\ \#Or:\ secondary=yes\ -sedreplacementcode'|g' /etc/pdns/pdns.conf
elif [ "${PDNSCONF_SERVER_MODE}" == "slave" ]; then
  sed -i 's|.*sedreplacementcode.*|'secondary=yes\ \#Or:\ primary=yes\ -sedreplacementcode'|g' /etc/pdns/pdns.conf
else
  sed -i 's|.*sedreplacementcode.*|'primary=yes\ \#Or:\ secondary=yes\ -sedreplacementcode'|g' /etc/pdns/pdns.conf
fi

echo "Lets Fly our PowerDNS!"

exec "$@"