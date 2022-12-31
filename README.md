# flyio-powerdns-pg
Ultra-scalable authorativ PowerDNS Server on Fly.io

### Config
PDNSCONF_GPGSQL_HOST="postgres"  
PDNSCONF_GPGSQL_PORT="5432"  
PDNSCONF_GPGSQL_DBNAME="pdns"  
PDNSCONF_GPGSQL_USER="postgres"  
PDNSCONF_GPGSQL_PASSWORD="changeme"  
PDNSCONF_API_KEY="changeme"  
PDNSCONF_FYLIO_GIP="0.0.0.0"  
PDNSCONF_SERVER_MODE="primary" (Or secondary)  
PDNSCONF_DEFAULT_SOA="a.dns.server web.hostmaster.@ 0 10800 3600 604800 3600"