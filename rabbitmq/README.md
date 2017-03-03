# RabbitMQ

RabbitMQ running in windows container with:
- Basic install with default guest enabled
- Remote host access is enabled.
- AMQP 1.0 plugin enabled

run:
```
docker run -d --name rabbitmq spring2/rabbitmq
```


view enabled plugins:
```
docker exec -it rabbitmq cmd /c rabbitmq-plugins list
```

ToDo:
- use ENV vars to set default username and password
- example of VOLUME mapped directory
