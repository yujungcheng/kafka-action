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

Get created topic description
```
      - name: Get topic description
        run: echo "${{ steps.kafka_action.outputs.topic_desc }}"
```

> connect Kafka broker via "localhost:9092"

#### Reference
- https://docs.github.com/en/actions/creating-actions/creating-a-docker-container-action
- https://github.com/marketplace/actions/setup-bitnami-kafka
- https://github.com/marketplace/actions/setup-kafka
