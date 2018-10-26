# chenrj/centos_6_dev:java8
# Version 0.0.1
FROM chenrj/centos_6_dev:basic 
MAINTAINER chenrj "790099746@qq.com"

# download files
WORKDIR /usr/local
RUN wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F;oraclelicense=accept-securebackup-cookie" \
        http://download.oracle.com/otn/java/jdk/8u172-b11/a58eab1ec242421181065cdc37240b08/jdk-8u172-linux-x64.rpm
        
# Install
RUN rpm -Uvh jdk-8u172-linux-x64.rpm

RUN alternatives --install /usr/bin/javaws javaws /usr/java/latest/bin/javaws 1 
RUN alternatives --install /usr/bin/java java /usr/java/latest/bin/java 1 
RUN alternatives --install /usr/bin/javac javac /usr/java/latest/bin/javac 1
RUN alternatives --install /usr/bin/javah javah /usr/java/latest/bin/javah 1
RUN alternatives --install /usr/bin/jps jps /usr/java/latest/bin/jps 1
RUN alternatives --install /usr/bin/jar jar /usr/java/latest/bin/jar 1

#RUN alternatives --config java


# remove files
RUN rm /usr/local/jdk-8u172-linux-x64.rpm

# reset dir
WORKDIR /root/app


ENTRYPOINT []
CMD ["/bin/bash"]


# Open ports
EXPOSE 8081
