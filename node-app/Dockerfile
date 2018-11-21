FROM node:latest

ENV DOCKERIZE_VERSION v0.6.1

RUN apt-get update && apt-get install -y wget \
&& wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
&& tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
&& rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

WORKDIR /usr/src/app
COPY ./src/package*.json ./
# install dependencies
RUN npm install
# automatic security fixes
#RUN npm audit fix
# manual security fixes
# Bundle app source
COPY ./src .

EXPOSE 3000

ENTRYPOINT exec dockerize -wait http://${COUCHDB_USER}:${COUCHDB_PASSWORD}@${COUCHDB_HOST}:${COUCHDB_PORT}/tests_empty  -timeout 120s npm start
