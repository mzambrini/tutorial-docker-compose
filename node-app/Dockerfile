FROM node:latest

ADD dockerize-linux-amd64-v0.6.1.tar.gz /usr/local/bin

WORKDIR /usr/src/app
COPY ./src/package*.json ./

RUN npm install

COPY ./src .

EXPOSE 3000
ENTRYPOINT exec dockerize -wait http://${COUCHDB_USER}:${COUCHDB_PASSWORD}@${COUCHDB_HOST}:${COUCHDB_PORT}/tests_empty  -timeout 120s npm start
