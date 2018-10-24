### shell 下执行mysql 命令
$ mysql -uuser -ppasswd -e"insert LogTable values(...)"

### 执行脚本文件
$ mysql -uroot -ppassword < update.sql  





#!/usr/bin/env bash

_APP_NAME=$1

if [[ -z "$_APP_NAME" ]]; then 
  ../cecho.sh r "Please input app name for first params!"
  exit 0
fi

_container_volume_name=`../docker_container_name.sh volume mysql $_APP_NAME 0`
_container_node_name=`../docker_container_name.sh node mysql $_APP_NAME 0`

# 检查容器是否存在
_container_exists=`docker ps -a | grep $_container_volume_name`

if [[ ! -z "$_container_exists" ]]; then 
  ../cecho.sh r "[$_APP_NAME] 已存在请选择其它名字！"
  exit 0
fi

# 创建卷容器，并不启动
# docker create -v /var/lib/mysql --name $_container_volume_name mysql

mkdir /var/lib/mysql/$_APP_NAME && chown -R mysql:mysql /var/lib/mysql/$_APP_NAME


# 创建新容器，使用刚刚创建的卷
# docker run --name $_container_node_name --volumes-from $_container_volume_name -e MYSQL_ROOT_PASSWORD=password -p 3307:3306 mysql
# --character-set-server=utf8 --collation-server=utf8_general_ci
# -v /my/custom/config-file:/etc/my.cnf
docker run --name $_container_node_name -v /var/lib/mysql/$_APP_NAME:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=password -p 3307:3306 mysql
