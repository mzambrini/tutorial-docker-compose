FROM alpine:3.8

ADD dockerize-alpine-linux-amd64-v0.6.1.tar.gz /usr/local/bin

COPY /work /work

RUN chmod +x /work/*.sh

ENTRYPOINT exec dockerize -wait http://${COUCHDB_USER}:${COUCHDB_PASSWORD}@${COUCHDB_HOST}:${COUCHDB_PORT} -timeout 260s /work/entrypoint.sh

