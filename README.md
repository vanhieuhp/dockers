# Docker tool

1. remove docker image <none> tag:
```
docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
```

2. Rabbitmq


```
https://github.com/rabbitmq/rabbitmq-delayed-message-exchange/releases
```

#### cmd
```
rabbitmqctl status
docker compose up -d amqp://guest:guest@localhost/vh_host
docker cp apache:/usr/local/apache2/conf/httpd.conf .
```