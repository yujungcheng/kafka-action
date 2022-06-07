#!/bin/sh


docker network create kafka-net --driver bridge

sh -c "docker network create kafka-net --driver bridge"

run="docker run -d"

run_zookeeper="$run --network kafka-net -h zookeeper --name zookeeper \
    -e ALLOW_ANONYMOUS_LOGIN=yes \
    bitnami/zookeeper:latest"

run_kafka="$run --network kafka-net -h kafka --name kafka -p 9092:9092 \
-e KAFKA_CFG_AUTO_CREATE_TOPICS_ENABLE=true \
-e KAFKA_BROKER_ID=1 \
-e KAFKA_LISTENERS=PLAINTEXT://:9092 \
-e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://127.0.0.1:9092 \
-e ALLOW_PLAINTEXT_LISTENER=yes \
-e KAFKA_ZOOKEEPER_CONNECT=zookeeper:2181 \
bitnami/kafka:latest"

sh -c "${run_zookeeper}"
sh -c "${run_kafka}"



