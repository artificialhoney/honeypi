FROM node:14.15-alpine3.12

RUN mkdir -p /usr/src && apk add git && git clone https://github.com/ory/hydra-login-consent-node.git /usr/src/app
WORKDIR /usr/src/app

RUN adduser -S ory -D -u 10000 -s /bin/nologin

RUN npm ci --silent

RUN npm run build

USER 10000

ENTRYPOINT npm run serve

EXPOSE 3000