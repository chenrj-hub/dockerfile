# chunhui2001/ubuntu_1610_dev:logstash_base
# Version 0.0.1
FROM ubuntu:14.04
MAINTAINER Chunhui.Zhang "chunhui2001@gmail.com"

RUN apt-get -y update && apt-get install -y wget
RUN wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
RUN echo 'deb http://packages.elasticsearch.org/logstash/1.4/debian stable main' > /etc/apt/sources.list.d/logstash.list
RUN apt-get -y update && apt-get install -y logstash vim


# execute update-alternatives to use java 8
#RUN update-alternatives --install /usr/bin/java java /usr/local/java/bin/java 300
#RUN update-alternatives --install /usr/bin/javac javac /usr/local/java/bin/javac 300
#RUN update-alternatives --install /usr/bin/jar jar /usr/local/java/bin/jar 300
#RUN update-alternatives --install /usr/bin/javah javah /usr/local/java/bin/javah 300
#RUN update-alternatives --install /usr/bin/jps jps /usr/local/java/bin/jps 300


## remove openjdk
# RUN apt-get purge openjdk*


