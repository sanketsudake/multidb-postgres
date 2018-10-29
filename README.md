multidb-postgres-ssl
====================

[Automated Build](https://hub.docker.com/r/tripples/multidb-postgres/)


This postgres image facilitates quick script which can create multiple databases on postgres start.
Image targets usecase, where multiple applications are hosted through docker-compose and share single PG container.

Supported configuration parameters:

*  Databases to be created,

`INIT_DATABASES=test1,test2,test3`

* Turn SSL on/off
`SSL_MODE=on` or `SSL_MODE=off`

