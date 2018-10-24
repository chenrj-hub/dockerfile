# chenrj/centos_6_dev:logstash_base
# Version 0.0.1
FROM chenrj/centos_6_dev:java8
MAINTAINER chenrj "790099746@qq.com"

## Refer: 
#  http://blog.csdn.net/u012373815/article/details/51029826

## Set work dir
WORKDIR /usr/local

## Download file
RUN wget https://artifacts.elastic.co/downloads/logstash/logstash-5.6.4.tar.gz && tar -zxf logstash-5.6.4.tar.gz && rm -rf logstash-5.6.4.tar.gz

## ln
RUN ln -s /usr/local/logstash-5.6.4 /usr/local/logstash





