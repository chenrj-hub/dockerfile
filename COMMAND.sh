# 创建redis
docker create -P -h app.360bidCn.redis.primary --name app.360bidCn.redis.primary licj316/centos_6_dev:redis_instance --requirepass ebid-pass

# 创建mysql
docker create -p 3306:3306 -h app.360bidCn.mysql.primary -v /Users/apple/Documents/docker/app/ebid.database.mysql:/var/lib/mysql_data --name app.360bidCn.mysql.primary -e MYSQL_ROOT_PASSWORD=Cc licj316/debian_8_dev:mysql_5.7

# 创建tomcat
docker create -P -h app.360bidCn.tomcat.web.1 -v /Users/apple/Documents/docker/app/ebid.backend:/usr/local/tomcat/webapps/ROOT --name app.360bidCn.tomcat.web.1 licj316/centos_7_dev:tomcat8

# 创建node
docker create -P -h app.360bidCn.express.web.1 -v /Users/apple/Documents/docker/app/ebid.frontend:/root/nodejs/app --name app.360bidCn.express.web.1 licj316/centos_6_dev:nodejs8 server.js local

# 创建haproxy
docker create -p 8000:80 -h app.360bidCn.haproxy.loadbalance --name app.360bidCn.haproxy.loadbalance licj316/centos_6_dev:haproxy_instance

# mysql初始化数据库
create database ebid_db_dev;
use ebid_db_dev;

docker exec app.Dev360bidCn.mysql.primary sh -c "mysqldump -uroot -p ebid_db_dev" > ./ebid_db_dev.sql

source /var/lib/mysql_data/ebid_db_dev.sql;

GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'Cc' WITH GRANT OPTION;

flush privileges;

#重置密码
mysqladmin -u root password "Cc"
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('Cc');
flush privileges;

#创建spring-boot docker运行镜像
docker build -t licj316/centos_7_dev:spring_app .

docker pull licj316/centos_7_dev:spring_app

#测试环境wechat docker容器创建脚本
docker create -p 8081:8081 \
-v /root/app/public/ebid-wechat:/root/app \
-h app.360bidTop.web.wechat --name app.360bidTop.web.wechat \
-e SPRING_PROFILES_ACTIVE="prod" licj316/centos_7_dev:spring_app

