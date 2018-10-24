# chenrj/centos_6_dev:redis_base
# Version 0.0.1
FROM chenrj/centos_6_dev:basic
MAINTAINER chenrj "790099746@qq.com"


## Set workdir
WORKDIR /usr/local

## Download files and install
RUN wget http://download.redis.io/redis-stable.tar.gz && tar -zxf redis-stable.tar.gz && cd redis-stable && make distclean && make && make install




CMD []

EXPOSE 6379