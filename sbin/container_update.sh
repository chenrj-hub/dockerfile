#!/usr/bin/env bash

chmod +x `pwd`/${_DOCKER_APP_NAME}.hook

_docker_config_file=$_APP_CONFIG_FILE

_app_name=$1			#
_container_name=$2			# 
_container_type=$3			# loadbanance
_container_provider=$4		# provider

## get web_backend from config.yml
_web_backend_provider="app.$_app_name.express.web.*"

# 修改之前先启动容器
docker start "$_container_name"  2>&1 >/dev/null

if [[ $_container_type == "loadbalance" ]]; then
	## 根据后端 web 引擎，取出容器名字
	#docker inspect `docker ps -a | grep $_web_backend_provider | awk '{split($0, a, " "); print a[1]}'` -f "{{ .Name }}" | awk '{split($0, a, "/"); print a[2]}'
	_container_ids=`docker ps -a | grep "$_web_backend_provider" | awk '{split($0, a, " "); print a[1]}'`
	_container_names=`docker inspect $_container_ids -f "{{ .Name }}" | awk '{split($0, a, "/"); print a[2]}'`
	_container_nodes_name_and_port=`docker inspect $_container_ids -f "{{ .Name }}:{{ .Config.ExposedPorts }}" | awk 'gsub(/\/|map|\[|\]|tcp:|{}/, "", $0) {print}'`
	
	_node_index=0
	_container_nodes_cluster_string=''
	
	for node in $_container_nodes_name_and_port ; do 
	  _node_index=$[$_node_index+1]
	  _container_nodes_cluster_string=`printf "server s%s %s check" $_node_index $node`
	  docker exec -it $_container_name sed -i -e "s/server[[:space:]]*s0[[:space:]]*127.0.0.1:80 check/\n        $_container_nodes_cluster_string server s0 127.0.0.1:80 check/g" /etc/haproxy/haproxy.cfg
	done;
	
	#docker exec -it $_container_name sed -i -e "s/server s0 127.0.0.1:80 check/server s1 app.my_server.nginx.web.1:80 check\n        server s2 app.my_server.nginx.web.2:80 check/g" /etc/haproxy/haproxy.cfg
	if ! [[ -z "$_container_nodes_cluster_string" ]]; then
	  docker exec -it $_container_name sed -i -e "s/server[[:space:]]*s0[[:space:]]*127.0.0.1:80 check//g" /etc/haproxy/haproxy.cfg
	  #docker restart "$_container_name"
	fi
	
	echo ""
fi



