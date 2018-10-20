#!/bin/bash
set -xe

if [ -z "${INIT_DATABASES}" ] ; then
    echo "INIT_DATABASES variable not set"
    exit 1
fi

echo "INIT_DATABASES value", ${INIT_DATABASES}


for db in `echo ${INIT_DATABASES} | tr ',' '\n'`
do
    echo "CREATE DATABASE $db;" >> /tmp/initdb.sql
    echo "GRANT ALL PRIVILEGES ON DATABASE $db TO $POSTGRES_USER;" >> /tmp/initdb.sql
done

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -f /tmp/initdb.sql