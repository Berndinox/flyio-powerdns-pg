#!/bin/sh


sed -i 's|.*gpgsql-host=.*|'gpgsql-host=$PDNSCONF_GPGSQL_HOST'|g' /etc/pdns/pdns.conf
sed -i 's|.*gpgsql-dbname=.*|'gpgsql-dbname=$PDNSCONF_GPGSQL_DBNAME'|g' /etc/pdns/pdns.conf
sed -i 's|.*gpgsql-user=.*|'gpgsql-user=$PDNSCONF_GPGSQL_USER'|g' /etc/pdns/pdns.conf
sed -i 's|.*gpgsql-password=.*|'gpgsql-password=$PDNSCONF_GPGSQL_PASSWORD'|g' /etc/pdns/pdns.conf
sed -i 's|.*api-key=.*|'api-key=$PDNSCONF_API_KEY'|g' /etc/pdns/pdns.conf

if [ "${PDNSCONF_SERVER_TYPE}" == "master" ]; then
  sed -i 's|.*sedreplacementcode.*|'master=yes\ \#Or:\ slave=yes\ -sedreplacementcode'|g' /etc/pdns/pdns.conf
elif [ "${PDNSCONF_SERVER_TYPE}" == "slave" ]; then
  sed -i 's|.*sedreplacementcode.*|'slave=yes\ \#Or:\ master=yes\ -sedreplacementcode'|g' /etc/pdns/pdns.conf
else
  sed -i 's|.*sedreplacementcode.*|'master=yes\ \#Or:\ slave=yes\ -sedreplacementcode'|g' /etc/pdns/pdns.conf
fi

echo "Lets Fly our PowerDNS!"

exec "$@"