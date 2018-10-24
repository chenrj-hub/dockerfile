# chunhui2001/debian_8_dev:mysql_default
# Version 0.0.1
FROM mysql:5.7
MAINTAINER Chunhui.Zhang <chunhui2001@gmail.com>

## Refer
# https://severalnines.com/blog/mysql-docker-building-container-image

RUN mkdir /var/lib/mysql_data && chown -R mysql:mysql /var/lib/mysql_data
ADD my.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

VOLUME ["/var/lib/mysql_data"]

# helper
RUN echo "alias 'll=ls -al'" >> /root/.bashrc && echo "alias 'lll=ls -lh'" >> /root/.bashrc 

## Run example
# $ mkdir -p /storage/mysql-pxb/datadir
# $ mkdir -p /storage/backups
# $ docker run -d \
# --name mysql-server \
# -v /storage/mysql-server/datadir:/var/lib/mysql_data \ (必须,将存储数据的文件夹挂在到外部)
# -e MYSQL_ROOT_PASSWORD=mypassword \ (必须)
# severalnines/mysql-pxb:5.6

# 恢复数据库
# mysql -u root -p -h 127.0.0.1 -P 32802 ebid_db_test < ~/Desktop/ebid_db_staging.sql

# 开启 root 远程链接
# GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION; 
# FLUSH PRIVILEGES; 


# Open ports
EXPOSE 3306


