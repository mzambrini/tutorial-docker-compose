FROM alpine:3.8

ENV DOCKERIZE_VERSION v0.6.1

RUN apk add --update --no-cache openssl bash curl \
&& rm -rf /var/cache/apk/* \
&& wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
&& tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
&& rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

COPY /work /work

RUN ls /work && chmod +x /work/*.sh 

ENTRYPOINT exec dockerize -wait http://${COUCHDB_USER}:${COUCHDB_PASSWORD}@${COUCHDB_HOST}:${COUCHDB_PORT} -timeout 260s /work/entrypoint.sh

