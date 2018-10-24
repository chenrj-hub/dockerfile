# chunhui2001/ubuntu_1610_dev:java8_mtf_server
# Version 0.0.1
FROM chunhui2001/ubuntu_1610_dev:tomcat8
MAINTAINER Chunhui.Zhang "chunhui2001@gmail.com"

ENV REFRESHED_AT 2017-12-25

RUN apt-get install -y git


### Node
ARG NODE_VERSION=v6.11.3
ARG PHANTOMJS_VERSION=1.9.8
#ARG PHANTOMJS_VERSION=2.1.1

ENV REFRESHED_AT 2017-11-03
ENV NODE_VERSION $NODE_VERSION

## install compile tools
RUN apt-get install -y python cmake build-essential fontconfig

## Download files and extract
WORKDIR /usr/local
RUN wget https://nodejs.org/download/release/$NODE_VERSION/node-$NODE_VERSION-linux-x64.tar.gz && tar -zxf node-$NODE_VERSION-linux-x64.tar.gz
RUN ln -s /usr/local/node-$NODE_VERSION-linux-x64 /usr/local/node && ln -s /usr/local/node/bin/node /usr/sbin/node && ln -s /usr/local/node/bin/npm /usr/sbin/npm


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


### Install Maven and Ant
RUN wget http://mirror.bit.edu.cn/apache/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz -P /usr/local/ && tar -zxf /usr/local/apache-maven-3.5.2-bin.tar.gz -C /usr/local/
RUN wget http://mirrors.hust.edu.cn/apache/ant/binaries/apache-ant-1.10.1-bin.tar.gz -P /usr/local/ && tar -zxf /usr/local/apache-ant-1.10.1-bin.tar.gz -C /usr/local/
RUN ln -s /usr/local/apache-ant-1.10.1 /usr/local/ant && ln -s /usr/local/apache-maven-3.5.2 /usr/local/maven

RUN npm install -g @angular/cli --registry https://registry.cnpmjs.org

ADD ansinble.sh /root/ansinble.sh
RUN chmod +x /root/ansinble.sh
RUN gulp -v


WORKDIR /root/app/mtf-cms

# start tomcat
#ENTRYPOINT ["/usr/local/maven/bin/mvn"]
#CMD ["exec:java"]

ENTRYPOINT []
CMD []

# Open ports
EXPOSE 9181





