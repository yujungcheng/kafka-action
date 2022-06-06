#!/bin/sh



TOPIC_NAME=${1}
echo "Set topic: ${TOPIC_NAME}"


docker network create kafka-net --driver bridge

docker run -d --network kafka-net -h zookeeper --name zookeeper \
    -e ALLOW_ANONYMOUS_LOGIN=yes \
    bitnami/zookeeper:latest

docker run -d --network kafka-net -h kafka --name kafka \
    -e ALLOW_PLAINTEXT_LISTENER=yes \
    -e KAFKA_BROKER_ID=1 \
    -e KAFKA_CFG_AUTO_CREATE_TOPICS_ENABLE=true \
    -e KAFKA_CFG_ZOOKEEPER_CONNECT=zookeeper:2181 \
    -e KAFKA_CFG_LISTENERS=PLAINTEXT://:9092 \
    -e KAFKA_CFG_ADVERTISED_LISTENERS=PLAINTEXT://127.0.0.1:9092 \
    -p 9092:9092 \
    bitnami/kafka:latest

sleep 10  # wait for broker to start.

docker exec kafka kafka-topics.sh \
    --create \
    --topic ${TOPIC_NAME} \
    --replication-factor 1 \
    --partitions 1 \
    --bootstrap-server 127.0.0.1:9092

topic_desc=$(docker exec kafka kafka-topics.sh --describe --topic ${TOPIC_NAME} --bootstrap-server 127.0.0.1:9092)
echo "::set-output name=topic_desc::${topic_desc}"