multidb-postgres
==================

This postgres image facilitates quick script which can create multiple databases on postgres start.
Image targets usecase, where multiple applications are hosted through docker-compose and share single PG container.

Specify the following environment variable with comma separated database names to be created,

`INIT_DATABASES=test1,test2,test3`

