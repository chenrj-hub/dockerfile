# chenrj/ubuntu_1610_dev:java8
# Version 0.0.1
FROM chenrj/ubuntu_1610_dev:zh-CN
MAINTAINER chenrj "790099746@qq.com"

# copy files
# COPY jdk-8u151-linux-x64.tar.gz /usr/local/

# download files
WORKDIR /usr/local
RUN wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F;oraclelicense=accept-securebackup-cookie" \
         http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-x64.tar.gz
# RUN wget http://download.oracle.com/otn-pub/java/jdk/9.0.1+11/jdk-9.0.1_linux-x64_bin.tar.gz?AuthParam=1509701211_64f88307fcdfd8b93eb6951051e008fc

# extract files 
RUN tar -zxf /usr/local/jdk-8u161-linux-x64.tar.gz -C /usr/local/ && mv /usr/local/jdk1.8.0_161 /usr/local/java

# execute update-alternatives to use java 8
RUN update-alternatives --install /usr/bin/java java /usr/local/java/bin/java 300
RUN update-alternatives --install /usr/bin/javac javac /usr/local/java/bin/javac 300
RUN update-alternatives --install /usr/bin/jar jar /usr/local/java/bin/jar 300
RUN update-alternatives --install /usr/bin/javah javah /usr/local/java/bin/javah 300
RUN update-alternatives --install /usr/bin/jps jps /usr/local/java/bin/jps 300

#RUN update-alternatives --config java 

RUN wget http://mirror.bit.edu.cn/apache/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz -P /usr/local/ && tar -zxf /usr/local/apache-maven-3.5.2-bin.tar.gz -C /usr/local/
RUN wget http://mirrors.hust.edu.cn/apache/ant/binaries/apache-ant-1.10.2-bin.tar.gz -P /usr/local/ && tar -zxf /usr/local/apache-ant-1.10.2-bin.tar.gz -C /usr/local/

RUN ln -s /usr/local/apache-maven-3.5.2 /usr/local/maven
RUN ln -s /usr/local/apache-ant-1.10.2 /usr/local/ant

ENV PATH=$PATH:/usr/local/ant/bin
ENV PATH=$PATH:/usr/local/maven/bin


# remove files
RUN rm /usr/local/*.tar.gz

# reset dir
WORKDIR /root/app

#ENTRYPOINT []
#CMD ["testing"]


# Open ports
EXPOSE 8081


