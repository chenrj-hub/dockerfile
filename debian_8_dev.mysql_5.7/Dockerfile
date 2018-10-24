# chenrj/debian_8_dev:mysql_5.7
# Version 0.0.1
FROM mysql:5.7
MAINTAINER chenrj "790099746@qq.com"

RUN apt-get update -y && apt-get install vim -y

# 设定时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 开启中文支持
RUN apt-get install ttf-wqy-microhei ttf-wqy-zenhei locales -y
RUN locale-gen zh_CN.UTF-8 && DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales
RUN localedef -c -f UTF-8 -i zh_CN zh_CN.UTF-8
ENV LANG zh_CN.UTF-8
ENV LANGUAGE zh_CN:zh
ENV LC_LANG zh_CN.UTF-8
ENV LC_ALL zh_CN.UTF-8

# alias
RUN echo "alias 'll=ls -al'" >> /root/.bashrc && echo "alias 'lll=ls -lh'" >> /root/.bashrc 

VOLUME ["/var/lib/mysql_data"]

## Run container
#  docker run -d -P -e MYSQL_ROOT_PASSWORD=Cc chunhui2001/debian_8_dev:mysql_5.7


# 开启 root 远程链接
# GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION; 
# FLUSH PRIVILEGES; 

RUN chown -R mysql:mysql /var/lib/mysql_data
ADD my.cnf /etc/mysql/mysql.conf.d/mysqld.cnf


WORKDIR /root

# Open ports
EXPOSE 3306
