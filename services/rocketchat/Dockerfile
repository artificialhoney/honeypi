
FROM arm64v8/node:14.21.3-bullseye as builder

RUN groupadd -r rocketchat \
&&  useradd -r -g rocketchat rocketchat \
&&  mkdir -p /app/uploads \
&&  chown rocketchat:rocketchat /app/uploads \
&& echo "disable-ipv6" >> ~/.gnupg/dirmngr.conf

VOLUME /app/uploads

# gpg: key 4FD08014: public key "Rocket.Chat Buildmaster <buildmaster@rocket.chat>" imported
RUN gpg --batch --keyserver keyserver.ubuntu.com --recv-keys  0E163286C20D07B9787EBE9FD7F9D0414FD08104

WORKDIR /app
 
ENV DEBIAN_FRONTEND noninteractive
ENV RC_VERSION 6.10.2

RUN apt-get update && apt-get -y install g++ build-essential
RUN apt-get install -y curl ca-certificates imagemagick --no-install-recommends
RUN apt-get install -y libstdc++6
RUN apt-get install -y python
RUN curl -fSL "https://releases.rocket.chat/${RC_VERSION}/download" -o rocket.chat.tgz \
&&  curl -fSL "https://releases.rocket.chat/${RC_VERSION}/asc" -o rocket.chat.tgz.asc \
&&  gpg --batch --verify rocket.chat.tgz.asc rocket.chat.tgz \
&&  tar zxvf rocket.chat.tgz \
&&  rm rocket.chat.tgz rocket.chat.tgz.asc
ADD . /app

RUN set -x \
 && cd /app/bundle/programs/server \
 && npm install \
 && cd npm \
 && npm rebuild isolated-vm @kaciras/deasync sharp bcrypt --build-from-source \
 && cd node_modules/meteor/accounts-password \
 && npm rebuild bcrypt --build-from-source \
 && cd - \ 
 && npm cache clear --force

FROM arm64v8/node:14.21.3-bullseye

RUN groupadd -r rocketchat \
&&  useradd -r -g rocketchat rocketchat \
&&  mkdir -p /app 

COPY --from=builder /app /app

RUN  mkdir -p /app/uploads \
&&   chown rocketchat:rocketchat /app/uploads 

VOLUME /app/uploads

USER rocketchat

WORKDIR /app/bundle


# needs a mongo instance - defaults to container linking with alias 'mongo'
ENV DEPLOY_METHOD=docker-arm64 \
    NODE_ENV=production \
    MONGO_URL=mongodb://mongo:27017/rocketchat \
    MONGO_OPLOG_URL=mongodb://mongo:27017/local \
    HOME=/tmp \
    PORT=3000 \
    ROOT_URL=http://localhost:3000 \
    Accounts_AvatarStorePath=/app/uploads


EXPOSE 3000

CMD ["node", "main.js"]