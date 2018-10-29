#!/bin/bash
set -xe

if [ -z "${INIT_DATABASES}" ] ; then
    echo "INIT_DATABASES variable not set"
    exit 1
fi
echo "INIT_DATABASES value", ${INIT_DATABASES}

cd "${PGDATA}"
cp /etc/ssl/certs/ssl-cert-snakeoil.pem "${PGDATA}"/server.crt
cp /etc/ssl/private/ssl-cert-snakeoil.key "${PGDATA}"/server.key
chmod og-rwx server.key
chown -R postgres:postgres "${PGDATA}"

# Turn on/off ssl
if [ -z "${SSL_MODE}" ] ; then
    SSL_MODE=off
fi
echo "SSL is ${SSL_MODE}"

sed -ri "s/^#?(ssl\s*=\s*)\S+/\1'${SSL_MODE}'/" "$PGDATA/postgresql.conf"

# Create user mentioned databases and grant permissions
for db in `echo ${INIT_DATABASES} | tr ',' '\n'`
do
    echo "CREATE DATABASE $db;" >> /tmp/initdb.sql
    echo "GRANT ALL PRIVILEGES ON DATABASE $db TO $POSTGRES_USER;" >> /tmp/initdb.sql
done

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -f /tmp/initdb.sql