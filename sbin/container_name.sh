#!/usr/bin/env bash


 ### container name pattern, 
 ## 容器的名字必须是唯一的，当容器删除的时候会删除所有包含该名字的容器
 ## 删除容器的时候并不删除卷(volume)
 ## 方括号内的字符是变化的

 #> app.[container name: webname]
 #     .[provider:container or mysql or h2db or oracle or redis or mongo or mssql or apache or nginx or tomcat or express or logstash]
 #     .[type: volume or node or net or daemon or log]

 #> app.[ebid]_[volume].[mysqldb].[volume]
 #> app.[ebid]_[volume].[apache].volume]
 #> app.[ebid]_[node1].[nginx].node]
 #> app.[ebid]_[node2].[nginx].node]
 #> net.[ebid]


_CONTAINER_PREFIX="app"
_param_container_type=$1
_param_container_provider=$2
_param_container_name=$3
_param_container_number=$4

if [[ $# -lt 2 || ! $_param_container_number = ?(-)+([0-9]) ]]; then
  cecho r "请输入容器名字和节点编号, 节点编号必须是整数!"
  exit
fi

if [[ $_param_container_number == '-1' ]]; then
  # 如果数量是-1,则忽略编号
  _param_container_number=''
else 
  _param_container_number='.'$_param_container_number
fi

# TODO validate type and container name

# 根据传入的参数构建容器名字
# APP.node_node0.redis.node
# APP.node_node2.tomcat.node
#_container_name=`printf "$_CONTAINER_PREFIX.%s_$_param_container_type%s.$_param_container_provider.$_param_container_type" $_param_container_name $_param_container_number`

# ebidapp_network
# app.ebidapp.redis.primary.1
# app.ebidapp.redis.salve.1
# app.ebidapp.mysql.primary.1
# app.ebidapp.tomcat.web.1
# app.ebidapp.nginx.web.1
# app.ebidapp.nodejs.web.1
# app.ebidapp.container.volume.1, app.ebidapp.container_tomcat.volume.1, app.ebidapp.container_mysql.volume.1
# app.ebidapp.logstash.log.1
_container_name=`printf "$_CONTAINER_PREFIX.%s.%s.%s%s" $_param_container_name $_param_container_provider $_param_container_type $_param_container_number`

echo $_container_name;

