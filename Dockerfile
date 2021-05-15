FROM postgres:13.3
COPY init-db.sh /docker-entrypoint-initdb.d/init-user-db.sh
