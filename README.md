# kafka-action

This action runs zookeeper and Kafka docker containers using Bitnami Kafka image and also create topic.

#### Usage
```
      - name: Run kafka docker container
        uses: yujungcheng/kafka-action@v9
        with:
          topic name: "<topic name>"
```
> update the value of topic name to create a topic. Without the topic name input, a default topic name 'default-topic' is created.

Get the created topic description.
```
      - name: Get topic description
        run: echo "${{ steps.kafka_action.outputs.topic_desc }}"
```

> connect Kafka broker via "localhost:9092"


An workflow example
```
name: test kafka action

on: [push]

jobs:
  test-kafka-action:
    runs-on: ubuntu-20.04
    steps:
      - name: Run kafka docker container
        id: kafka_action
        uses: yujungcheng/kafka-action@v9
        with:
          topic name: "monitor"

      - name: Get topic description
        run: echo "${{ steps.kafka_action.outputs.topic_desc }}"
```

#### Reference
- https://docs.github.com/en/actions/creating-actions/creating-a-docker-container-action
- https://github.com/marketplace/actions/setup-bitnami-kafka
- https://github.com/marketplace/actions/setup-kafka
