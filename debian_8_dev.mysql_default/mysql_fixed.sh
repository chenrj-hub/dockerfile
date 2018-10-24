#!/usr/bin/env bash

_container_id=$1
_database_name="db1"
_database_user="user1"
_database_passwd="Cc"

_script_drop_db=`printf "drop database %s;" $_database_name`
_script_del_user=`printf 'delete from user where User in ("%s");' $_database_user`
_script_create_db=`printf "CREATE DATABASE '%s'" $_database_name`
_script_user_create=`printf 'CREATE USER "%s"@"localhost" IDENTIFIED BY "%s";' $_database_user $_database_passwd`
_script_user_grant=`printf 'GRANT ALL PRIVILEGES ON %s.* TO "%s"@"%%" IDENTIFIED BY "%s";' $_database_name $_database_user $_database_passwd` 

echo $_script_drop_db
echo $_script_del_user
echo $_script_create_db
echo $_script_user_create
echo $_script_user_grant
#exit;

# 启动 mysql
docker exec -it $_container_id /bin/bash -c "service mysql start"

# 删除数据库
docker exec -it $_container_id /bin/bash -c "/usr/bin/mysql -u root mysql -e '$_script_drop_db'" >/dev/null 2>/dev/null

# 删除用户
docker exec -it $_container_id /bin/bash -c "/usr/bin/mysql -u root mysql -e '$_script_del_user'" >/dev/null 2>/dev/null

# 创建数据库
docker exec -it $_container_id /bin/bash -c "/usr/bin/mysql -u root mysql -e '$_script_create_db'" >/dev/null 2>/dev/null

# 建表
# docker exec -it $_container_id /bin/bash -c "/usr/bin/mysql -u root -e 'CREATE DATABASE $_database_name;'" >/dev/null 2>/dev/null

# 创建 mysql 用户并授权 
docker exec -it $_container_id /bin/bash -c "/usr/bin/mysql -u root mysql -e '$_script_user_create'" >/dev/null 2>/dev/null

# 更新权限
docker exec -it $_container_id /bin/bash -c "/usr/bin/mysql -u root mysql -e '$_script_user_grant'" >/dev/null 2>/dev/null


