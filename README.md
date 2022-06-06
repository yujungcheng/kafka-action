# kafka-action

This action is for running a Kafka docker container using Bitnami Kafka image and also create a topic.

#### Usage
```
- name: Run kafka docker container
  uses: yujungcheng/kafka-action@v1
  with:
    topic_name: "<topic name>"
```
> update the value of topic name to create a topic
> connect Kafka broker via "localhost:9092"

#### Reference
https://github.com/marketplace/actions/setup-bitnami-kafka
https://github.com/marketplace/actions/setup-kafka