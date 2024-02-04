# Docker tool

1. remove docker image <none> tag:
```
docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
```

2. Rabbitmq


```
https://github.com/rabbitmq/rabbitmq-delayed-message-exchange/releases
```

```
rabbitmqctl status
docker compose up -d amqp://guest:guest@localhost/vh_host
docker cp apache:/usr/local/apache2/conf/httpd.conf .
```


3. Kafka
```
mkdir -p data/zookeeper data/kafka
sudo chown -R 1000:1000 data/* 


docker run --tty --network host confluentinc/cp-kafkacat:7.0.13 kafkacat -b 192.168.5.43:9092 -L

docker exec -it broker kafka-topics  --bootstrap-server broker:9092 --list | xargs -n 1 docker exec -it broker kafka-topics kafka-topics  --bootstrap-server broker:9092 --delete --topic $(docker exec -it broker kafka-topics  --bootstrap-server broker:9092 --list)

```

4. Flink
```
mkdir -p data/flink-web -p data/usrlib
sudo chown -R 0:0 data/* 
```

5. debezium

- elasticsearch-cqc: https://www.confluent.io/hub/confluentinc/kafka-connect-elasticsearch

curl -X GET "http://localhost:8083/connectors"
curl -X DELETE "http://localhost:8083/connectors/transactions-es-sink"
curl localhost:8083/connectors/debezium-mysql-moviesdb/status
```
curl -i -X POST -H "Accept:application/json" \
    -H  "Content-Type:application/json" http://localhost:8083/connectors/ \
    -d @es-sink.json

curl -i -X POST -H "Accept:application/json" \
-H  "Content-Type:application/json" http://localhost:8083/connectors/ \
-d @mysql-sink.json
```

6. Elasticseach
```
curl -X PUT localhost:9200/movies   -H "Content-Type: application/json"   -d @movies-mapping.json

```

