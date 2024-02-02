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


3. Kafka
```
mkdir -p data/zookeeper data/kafka
sudo chown -R 1000:1000 data/* 
```

4. Flink
```
mkdir -p data/flink-web -p data/usrlib
sudo chown -R 0:0 data/* 
```