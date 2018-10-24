# chunhui2001/ubuntu_1610_dev:redis_base
# Version 0.0.1
FROM chunhui2001/ubuntu_1610_dev:zh-CN
MAINTAINER Chunhui.Zhang "chunhui2001@gmail.com"

ENV REFRESHED_AT 2017-11-04


RUN apt-get install -y software-properties-common python-software-properties
RUN add-apt-repository ppa:chris-lea/redis-server
RUN apt-get -y update
RUN apt-get install -y redis-server redis-tools


CMD []

EXPOSE 6379