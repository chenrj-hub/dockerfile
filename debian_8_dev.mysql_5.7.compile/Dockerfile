# chunhui2001/debian_8_dev:mysql_5.7
# Version 0.0.1
FROM chunhui2001/ubuntu_1610_dev:basic
# FROM chunhui2001/ubuntu_1610_dev:temp
MAINTAINER Chunhui.Zhang "chunhui2001@gmail.com"


# Install dependencies
RUN apt-get install -y libncurses5 libncurses5-dev bison m4 cmake libaio1 libaio-dev

# Set work dir
WORKDIR /root

# Download mysql file
RUN wget https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-boost-5.7.20.tar.gz && tar -zxf mysql-boost-5.7.20.tar.gz && cd mysql-5.7.20

WORKDIR /root/mysql-5.7.20
# RUN cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql-5.7.20 -DWITH_BOOST=./boost
# -DWITH_ARCHIVE_STORAGE_ENGINE=1 -DWITH_FEDERATED_STORAGE_ENGINE=1 -DWITH_BLACKHOLE_STORAGE_ENGINE=1
#  && rm CMakeCache.txt
RUN cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql-5.7.20 -DWITH_BOOST=./boost -DMYSQL_TCP_PORT=3306 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DMYSQL_UNIX_ADDR=/tmp/mysql.sock -DINSTALL_LAYOUT=STANDALONE -DENABLED_PROFILING=ON -DMYSQL_MAINTAINER_MODE=OFF -DWITH_DEBUG=OFF -DENABLED_LOCAL_INFILE=TRUE -DWITH_ZLIB=bundled -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci
RUN make && make install

RUN ln -s /usr/local/mysql-5.7.20 /usr/local/mysql

WORKDIR /usr/local/mysql

# Post installation setup
# Mysql conf
# RUN cp support-files/my-medium.cnf /etc/my.cnf
COPY my.cnf /usr/local/mysql/

RUN mkdir /usr/local/mysql/mysql_files && mkdir /usr/local/mysql/data && mkdir /usr/local/mysql/logs && /usr/local/mysql/logs/error.log

# Install database (: mysql_install_db replace by mysqld --initialize)
# RUN ./scripts/mysql_install_db --user=mysql --datadir=/usr/local/mysql/data/


# Add mysql group and user
RUN groupadd mysql && useradd -g mysql mysql

# Set folder permissions
#RUN chown -R mysql:mysql /usr/local/mysql-5.7.20/var
RUN chown mysql:mysql /usr/local/mysql-5.7.20/data
RUN chown mysql:mysql /usr/local/mysql-5.7.20/logs
RUN chgrp -R mysql /usr/local/mysql-5.7.20
RUN chmod 750 /usr/local/mysql-5.7.20/mysql_files
RUN chmod 777 /usr/local/mysql/logs/error.log
RUN chown mysql:mysql /usr/local/mysql

# Init mysql
#RUN /usr/local/mysql/bin/mysqld --initialize --user=mysql

# remove files
RUN rm -rf /root/mysql-*

# Testing
# Start the server: /usr/local/mysql/bin/mysqld_safe -user=mysql &
# Set a root password for MySQL (does not affect system root's password): /usr/local/mysql/bin/mysqladmin -u root password new_password
# Try to log in!: /usr/local/mysql/bin/mysql

# MySQL Tools
# mysql-admin
# phpmyadmin

# Starting Mysql at boot time
# cp support-files/mysql.server /etc/init.d/mysql
# chmod +x /etc/init.d/mysql
# update-rc.d mysql defaults

#ENTRYPOINT ["/usr/local/mysql/bin/mysqld_safe"]
#CMD ["--user=mysql", "&"]

# 开启 root 远程链接
# GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION; 
# FLUSH PRIVILEGES; 

# ARG DATABASE_ROOT_PASS

#RUN service mysql start \
#    && mysqladmin -u root password "$DATABASE_ROOT_PASS" \
#    && mysql -u root -p"$DATABASE_ROOT_PASS" -e "UPDATE mysql.user SET Password=PASSWORD('$DATABASE_ROOT_PASS') WHERE User='root'" \
#    && mysql -u root -p"$DATABASE_ROOT_PASS" -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1')" \
#    && mysql -u root -p"$DATABASE_ROOT_PASS" -e "DELETE FROM mysql.user WHERE User=''" \
#    && mysql -u root -p"$DATABASE_ROOT_PASS" -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%'" \
#    && mysql -u root -p"$DATABASE_ROOT_PASS" -e "FLUSH PRIVILEGES"

# https://severalnines.com/blog/mysql-docker-containers-understanding-basics

# Open ports
EXPOSE 3306
