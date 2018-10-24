# licj316/centos_6_dev:redis_base
# Version 0.0.1
FROM licj316/centos_6_dev:basic
MAINTAINER Chunhui.Zhang "chunhui2001@gmail.com"


## Set workdir
WORKDIR /usr/local

## Download files and install
RUN wget http://download.redis.io/redis-stable.tar.gz && tar -zxf redis-stable.tar.gz && cd redis-stable && make distclean && make && make install




CMD []

EXPOSE 6379