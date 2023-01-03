# flyio-powerdns-pg
Ultra-scalable authorativ PowerDNS Server on Fly.io

## Config
Non sensitive Information can be specified in the fly.toml file.  
For passwords, you should use `flyctl secrets set VAR=VALUE` cmdlet.

## Restrictions
The Records for the nameserver itself (A, AAA, CNAME) should not be hosted on the server itself.  
ATM: Fly.io can`t resolv those Records when issueing SSL Certs.

## Enviroment variables
**PDNSCONF_GPGSQL_HOST="postgres"**  
Hostname or DNS of the Postgres Database.  

**PDNSCONF_GPGSQL_PORT="5432"**  
Port of the DB with write-capability.  

**PDNSCONF_GPGSQL_READPORT="5433"**  
Port of the DB readonly, but with better geo-awarness.  

**PDNSCONF_GPGSQL_DBNAME="pdns"**  
Database-Name - has to be created manually on Fly.io.  
The DB Schema can be found here: [PowerDNS Postgres Docs](https://doc.powerdns.com/authoritative/backends/generic-postgresql.html)  

**PDNSCONF_GPGSQL_USER="postgres"**  
Username for connectiong the Database.  

**PDNSCONF_GPGSQL_PASSWORD="changeme"**  
Password of the Database, will be shown when deploying a PG-DB on fly.io  

**PDNSCONF_API_KEY="changeme"**  
Password when using the PowerDNS API (e.g. when connecting with PowerDNS-Admin)  

**PDNSCONF_FLYIO_MAINREGION="fra"**  
Your Mainregion specified during initial Fly deployment.  
Mainregion will be ablte to connect to writeable Postgres DB.  
All other regions will connect to read replicas cause of there better performance when distributed globaly.  

**PDNSCONF_DEFAULT_SOA="a.dns.server. web.hostmaster. 0 10800 3600 604800 3600"**  
Your Default SOA Record.