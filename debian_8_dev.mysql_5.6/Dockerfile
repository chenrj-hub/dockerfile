# chunhui2001/debian_8_dev:mysql_5.6
# Version 0.0.1
FROM mysql:5.6
MAINTAINER Chunhui.Zhang "chunhui2001@gmail.com"

RUN apt-get update -y && apt-get install vim -y

RUN mkdir /var/lib/mysql_data && chown -R mysql:mysql /var/lib/mysql_data
ADD my.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

#[mysqld]
#explicit_defaults_for_timestamp=true

VOLUME ["/var/lib/mysql_data"]

# helper
RUN echo "alias 'll=ls -al'" >> /root/.bashrc && echo "alias 'lll=ls -lh'" >> /root/.bashrc 


## Run container
#  docker run -d -P -d -e MYSQL_ROOT_PASSWORD=Cc chunhui2001/ubuntu_1610_dev:mysql_5.6



# 开启 root 远程链接
# GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION; 
# FLUSH PRIVILEGES; 

# Open ports
EXPOSE 3306
