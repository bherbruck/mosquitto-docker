FROM eclipse-mosquitto:latest

RUN apk add --no-cache bash

ADD ./entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

USER mosquitto

ENTRYPOINT ["/entrypoint.sh"]
