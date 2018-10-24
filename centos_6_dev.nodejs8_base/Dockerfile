# licj316/centos_6_dev:nodejs8_base
# Version 0.0.1
FROM licj316/centos_6_dev:basic
MAINTAINER Chunhui.Zhang "chunhui2001@gmail.com"

ARG NODE_VERSION=v8.11.1
ARG PHANTOMJS_VERSION=2.1.1
#ARG PHANTOMJS_VERSION=2.1.1

ENV REFRESHED_AT 2017-11-09
ENV NODE_VERSION $NODE_VERSION



## Download files and extract
WORKDIR /usr/local
RUN wget https://nodejs.org/dist/v8.11.1/node-v8.11.1-linux-x64.tar.xz && tar -xvJf node-v8.11.1-linux-x64.tar.xz
RUN ln -s /usr/local/node-$NODE_VERSION-linux-x64 /usr/local/node && ln -s /usr/local/node/bin/node /usr/sbin/node && ln -s /usr/local/node/bin/npm /usr/sbin/npm


## Install phantomjs
#RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 && tar -jxf phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2
ADD phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 /usr/local/
RUN ln -s /usr/local/phantomjs-$PHANTOMJS_VERSION-linux-x86_64 /usr/local/phantomjs && ln -s /usr/local/phantomjs/bin/phantomjs /usr/local/bin/
# /usr/local/bin/phantomjs --version

RUN yum install -y libpng
RUN yum install libpng-devel

ADD epel-release-6-8.noarch.rpm /usr/local
RUN rpm -Uvh epel-release*rpm && yum install -y GraphicsMagick && yum install -y ImageMagick

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

## chromedriver  taobao
RUN npm install chromedriver --chromedriver_cdnurl=https://npm.taobao.org/mirrors/chromedriver

## Clear files
RUN rm -rf /usr/local/*.tar.*

VOLUME ["/root/nodejs/app"]

WORKDIR /root/nodejs/app


