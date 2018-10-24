# licj316/centos_7_dev:tomcat8
# Version 0.0.1
FROM licj316/centos_7_dev:java8
MAINTAINER Chunhui.Zhang "chunhui2001@gmail.com"

ENV JAVA_HOME=/usr/java/latest
WORKDIR /usr/local

## dependencies
RUN yum install -y expat-devel

# Download and extract files
RUN wget http://mirror.bit.edu.cn/apache/tomcat/tomcat-8/v8.5.31/bin/apache-tomcat-8.5.31.tar.gz && tar -zxf apache-tomcat-8.5.31.tar.gz -C /usr/local/
RUN wget http://mirrors.tuna.tsinghua.edu.cn/apache/apr/apr-1.6.3.tar.gz && tar -zxf apr-1.6.3.tar.gz -C /usr/local/
RUN wget http://mirrors.tuna.tsinghua.edu.cn/apache/apr/apr-util-1.6.1.tar.gz && tar -zxf apr-util-1.6.1.tar.gz -C /usr/local/
RUN wget http://mirrors.tuna.tsinghua.edu.cn/apache/apr/apr-iconv-1.2.2.tar.gz && tar -zxf apr-iconv-1.2.2.tar.gz -C /usr/local/

# Install and add tomcat group and tomcat user
RUN mv /usr/local/apache-tomcat-8.5.31 /usr/local/tomcat
RUN groupadd tomcat && chown -R root:root /usr/local/tomcat 
RUN useradd -s /bin/false -g tomcat -d /usr/local/tomcat tomcat 1>/dev/null 2>&1

## Tomcat APR
WORKDIR /usr/local/apr-1.6.3
RUN ./configure && make && make install 

## APR iconv
WORKDIR /usr/local/apr-iconv-1.2.2
RUN ./configure --with-apr=/usr/local/apr && make && make install

## APR util
WORKDIR /usr/local/apr-util-1.6.1
RUN ./configure --with-apr=/usr/local/apr && make && make install

## Tomcat native
# WORKDIR /usr/local/tomcat/bin
# RUN tar -zxf tomcat-native.tar.gz 

# WORKDIR /usr/local/tomcat/bin/tomcat-native-1.2.14-src/native
# RUN ./configure --with-apr=/usr/local/apr --with-ssl=/usr/bin && make && make install 

# set environments
ENV CATALINA_BASE=/usr/local/tomcat
ENV CATALINA_HOME=/usr/local/tomcat
ENV JAVA_OPTS="-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom"
#ENV CATALINA_OPTS="-Xms512M -Xmx1024M -server -XX:+UseParallelGC"
ENV CATALINA_PID=/usr/local/tomcat/temp/tomcat.pid
ENV LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/usr/local/apr/lib'

# set perimisions
WORKDIR /usr/local/tomcat
RUN chgrp -R tomcat conf && chmod g+rwx conf && chmod g+r conf/* && chown -R tomcat work/ temp/ logs/


# remove files
RUN rm -rf /usr/local/*.tar.gz && rm -rf /usr/local/apr-* && rm -rf /usr/local/openssl-*

WORKDIR /usr/local/tomcat/webapps
VOLUME ["/usr/local/tomcat/webapps/ROOT", "/usr/local/tomcat/logs"]

# start tomcat
ENTRYPOINT ["/usr/local/tomcat/bin/catalina.sh", "run"]

# Open ports
EXPOSE 8080



