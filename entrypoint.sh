#!/bin/sh

docker_run="docker run -d"

run_zookeeper="$docker_run --name zookeeper -p $INPUT_ZOOKEEPER_PORT:2181 -e ALLOW_ANONYMOUS_LOGIN=yes bitnami/zookeeper:$INPUT_ZOOKEEPER_VERSION"
sh -c "$run_zookeeper"

run_kafka="$docker_run --name kafka -p $INPUT_KAFKA_PORT:9092 -e KAFKA_BROKER_ID=1 -e KAFKA_LISTENERS=PLAINTEXT://:9092 -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://127.0.0.1:9092  -e ALLOW_PLAINTEXT_LISTENER=yes -e KAFKA_ZOOKEEPER_CONNECT=zookeeper:2181 bitnami/kafka:$INPUT_KAFKA_VERSION"
sh -c "$run_kafka"

echo "TOPIC NAME: $INPUT_TOPIC_NAME"

docker exec kafka kafka-topics.sh \
    --create \
    --topic $INPUT_TOPIC_NAME \
    --replication-factor 1 \
    --partitions 1 \
    --bootstrap-server 127.0.0.1:9092

topic_desc=$(docker exec kafka kafka-topics.sh --describe --topic $INPUT_TOPIC_NAME --bootstrap-server 127.0.0.1:9092)
echo "::set-output name=topic_desc::$topic_desc"