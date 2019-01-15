FROM debian:latest

ENV DOCKERIZE_VERSION v0.6.1

RUN apt-get update && apt-get install -y openssl wget curl \
&& rm -rf /var/lib/apt/lists/* \
&& wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
&& tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
&& rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

COPY /work /work

RUN chmod +x /work/*.sh 

ENTRYPOINT exec dockerize -wait http://${COUCHDB_USER}:${COUCHDB_PASSWORD}@${COUCHDB_HOST}:${COUCHDB_PORT} -timeout 260s /work/entrypoint.sh


