# chunhui2001/centos_6_dev:nodejs_base
# Version 0.0.1
FROM chunhui2001/centos_6_dev:basic
MAINTAINER Chunhui.Zhang "chunhui2001@gmail.com"

ARG NODE_VERSION=v6.11.3
ARG PHANTOMJS_VERSION=1.9.8
#ARG PHANTOMJS_VERSION=2.1.1

ENV REFRESHED_AT 2017-11-09
ENV NODE_VERSION $NODE_VERSION



## Download files and extract
WORKDIR /usr/local
RUN wget https://nodejs.org/download/release/$NODE_VERSION/node-$NODE_VERSION-linux-x64.tar.gz && tar -zxf node-$NODE_VERSION-linux-x64.tar.gz
RUN ln -s /usr/local/node-$NODE_VERSION-linux-x64 /usr/local/node && ln -s /usr/local/node/bin/node /usr/sbin/node && ln -s /usr/local/node/bin/npm /usr/sbin/npm


## Install phantomjs
RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 && tar -jxf phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2
RUN ln -s /usr/local/phantomjs-$PHANTOMJS_VERSION-linux-x86_64 /usr/local/phantomjs && ln -s /usr/local/phantomjs/bin/phantomjs /usr/local/bin/
# /usr/local/bin/phantomjs --version


## npm config
RUN npm config set user 0
RUN npm config set unsafe-perm true
RUN npm config set prefix /usr/local
RUN npm install -g sm
# RUN npm install -g --unsafe-perm puppeteer
RUN npm install -g --unsafe-perm node-gyp --registry https://registry.cnpmjs.org
RUN npm install -g gulp gulp-cli
RUN ln -s /usr/local/bin/gulp /usr/sbin/gulp
# gulp -v

## Clear files
RUN rm -rf /usr/local/*.tar.*

VOLUME ["/root/nodejs/app"]

WORKDIR /root/nodejs/app


