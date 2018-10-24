# chunhui2001/ubuntu_1610_dev:java9
# Version 0.0.1
FROM chunhui2001/ubuntu_1610_dev:zh-CN
MAINTAINER Chunhui.Zhang "chunhui2001@gmail.com"

# copy files
# COPY jdk-8u151-linux-x64.tar.gz /usr/local/

# download files
WORKDIR /usr/local
RUN wget http://download.oracle.com/otn-pub/java/jdk/9.0.1+11/jdk-9.0.1_linux-x64_bin.tar.gz?AuthParam=1509701211_64f88307fcdfd8b93eb6951051e008fc

# extract files 
RUN tar -zxf /usr/local/jdk-9.0.1_linux-x64_bin.tar.gz -C /usr/local/ && mv /usr/local/jdk-9.0.1_linux-x64_bin /usr/local/java

RUN apt-get install dirmngr
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu yakkety main" | tee /etc/apt/sources.list.d/webupd8team-java.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu yakkety main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
RUN apt-get update -y && apt-get install -y oracle-java9-installer


# execute update-alternatives to use java 9
RUN update-alternatives --install /usr/bin/java java /usr/local/java/bin/java 300
RUN update-alternatives --install /usr/bin/javac javac /usr/local/java/bin/javac 300
RUN update-alternatives --install /usr/bin/jar jar /usr/local/java/bin/jar 300
RUN update-alternatives --install /usr/bin/javah javah /usr/local/java/bin/javah 300
RUN update-alternatives --install /usr/bin/jps jps /usr/local/java/bin/jps 300

## config java
#RUN update-alternatives --config java 

# remove files
#RUN rm /usr/local/jdk-9.0.1_linux-x64_bin.tar.gz
RUN rm /usr/local/*.tar.gz

# reset dir
WORKDIR /root

