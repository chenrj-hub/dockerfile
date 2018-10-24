# chunhui2001/ubuntu_1610_dev:jenkins
# Version 0.0.1
FROM chunhui2001/ubuntu_1610_dev:java8
MAINTAINER Chunhui.Zhang "chunhui2001@gmail.com"

ENV REFRESHED_AT 2017-12-4

RUN apt-get update -y && apt-get install -y supervisor iptables curl apt-transport-https dirmngr git ca-certificates lsb-release software-properties-common python cmake build-essential fontconfig
#RUN curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | apt-key add -
#RUN echo "deb http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
#RUN apt-get update -y && apt-get install -y install docker-ce

### Install Maven and Ant
RUN wget http://mirror.bit.edu.cn/apache/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz -P /usr/local/ && tar -zxf /usr/local/apache-maven-3.5.2-bin.tar.gz -C /usr/local/
RUN wget http://mirrors.hust.edu.cn/apache/ant/binaries/apache-ant-1.10.1-bin.tar.gz -P /usr/local/ && tar -zxf /usr/local/apache-ant-1.10.1-bin.tar.gz -C /usr/local/
RUN ln -s /usr/local/apache-ant-1.10.1 /usr/local/ant && ln -s /usr/local/apache-maven-3.5.2 /usr/local/maven



### Install Jenkins
ENV JENKINS_HOME /usr/local/jenkins
ENV JENKINS_MIRROR http://mirrors.jenkins-ci.org

RUN mkdir -p $JENKINS_HOME/data/plugins
RUN curl -sf -o $JENKINS_HOME/jenkins.war -L $JENKINS_MIRROR/war-stable-rc/latest/jenkins.war


RUN for plugin in chucknorris greenballs scm-api git-client git ws-cleanup; \
	do curl -sf -o $JENKINS_HOME/data/plugins/${plugin}.hpi \
	-L $JENKINS_MIRROR/plugins/${plugin}/latest/${plugin}.hpi; done

RUN curl -fsSL https://raw.githubusercontent.com/chunhui2001/docker-images/master/sbin/dockerup | tee -a dockerup 2>&1 >/dev/null 
RUN chmod +x dockerup

### Install Docker
RUN apt-get install -y docker.io
RUN echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" >> /etc/apt/sources.list
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D 2>&1 >/dev/null 
RUN apt-get update -y && apt-get -y install docker-engine
RUN mkdir /etc/docker && echo '{"registry-mirrors": ["http://4e70ba5d.m.daocloud.io"]}' > /etc/docker/daemon.json
VOLUME /var/lib/docker

RUN mkdir -p /var/log/supervisor
ENV DOCKER_HOST=127.0.0.1:4243

#ADD dockerjenkins.sh /usr/local/bin/dockerjenkins.sh
#RUN chmod +x /usr/local/bin/dockerjenkins.sh

### added ssh keys
ADD id_rsa.jenkins /root/.ssh/
ADD id_rsa.jenkins.pub /root/.ssh/
RUN chmod 400 /root/.ssh/id_rsa.jenkins /root/.ssh/id_rsa.jenkins.pub
RUN eval `ssh-agent` && echo "IdentityFile    ~/.ssh/id_rsa.jenkins" > /root/.ssh/config
RUN echo "|1|EXsMBwbshGAMtxuPMS6ztnUkdZs=|/9jJP04hUIjZ6+uaHg5Svf+OhA4= ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBH/0yRV0TrxcbjTJumlvhuxNGAVTl3CY/5QZqpGx427c/jSbcH0BAhBstFviRp/sSqqHSI+kJEzdleqKKQFTE+8=" > /root/.ssh/known_hosts

RUN rm -rf /usr/local/*.tar.gz 

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# ENTRYPOINT ["/usr/local/bin/dockerjenkins.sh"]
# ENTRYPOINT ["java", "-jar", "/usr/local/jenkins/jenkins.war"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]


EXPOSE 8080





#####################
#### Instruction ####
#####################
# %JENKINS_HOME%\secrets\initialAdminPassword
# jenkins.admin.user
# docker run --restart=on-failure:3 -d -p 9001:8080 --privileged -v /var/lib/docker-jenkins:/var/lib/docker chunhui2001/ubuntu_1610_dev:jenkins_initialized

## PM2
# sudo -E pm2 start server.js
# pm2 start app.js --name my-api
# pm2 save
# pm2 startup [ubuntu | ubuntu14 | ubuntu12 | centos | centos6 | arch | oracle | amazon | macos | darwin | freebsd | systemd | systemv | upstart | launchd | rcd | openrc]
# sudo su -c "env PATH=$PATH:/home/unitech/.nvm/versions/node/v4.3/bin pm2 startup <distribution> -u <user> --hp <home-path>
# pm2 unstartup ubuntu

# curl -u jenkins.admin.user:Cc http://192.168.189.189:9001/job/ebid_frontend/rssFailed
# sudo apt install libxml-xpath-perl
# tempval=`curl -u jenkins.admin.user:Cc http://192.168.189.189:9001/job/ebid_frontend/rssFailed > /tmp/xml.tmp && xpath -e '//entry[1]' /tmp/xml.tmp  | base64`
# openssl enc -base64 -d <<< $tempval

### ssh 远程执行命
# ssh -t -p $port $user@$ip "remote_cmd"  
#####################
#### Instruction ####
#####################
