#!/usr/bin/env bash

#export DOCKER_IMAGES_HOME=/home/keesh/docker-images
#export PATH=$PATH:$DOCKER_IMAGES_HOME/sbin

#$DOCKER_IMAGES_HOME/sbin/lns.sh

declare _app_config_file=`pwd`/*.App.yml

declare _app_name=$(yaml $_app_config_file main.app_name)
declare _app_main_port=$(yaml $_app_config_file main.app_port)

echo "Docker Command: " > "$_app_name".command


# 初始化随即密码
sed -i -e "s/[[:space:]]*redis_passwd:.*$/    redis_passwd: `openssl rand -base64 32 | awk 'gsub(/\/|\[|\]|#|=/, "", $0) {print}'`/g" $_app_config_file
sed -i -e "s/[[:space:]]*mysql_passwd:.*$/    mysql_passwd: `openssl rand -base64 32 | awk 'gsub(/\/|\[|\]|#|=/, "", $0) {print}'`/g" $_app_config_file


export _DOCKER_APP_NAME=${_app_name}
export _APP_CONFIG_FILE=$_app_config_file


# 定义参数数组
declare -A _input_params=()


if [[ $(yaml $_app_config_file images.volume) ]]; then
  _input_params["volume"]=$(yaml $_app_config_file images.volume)
fi

if [[ $(yaml $_app_config_file images.mysql) ]]; then
  _input_params["mysql"]=$(yaml $_app_config_file images.mysql)
fi


if [[ $(yaml $_app_config_file images.jdk) ]]; then
  _input_params["jdk"]=$(yaml $_app_config_file images.jdk)
fi


if [[ $(yaml $_app_config_file images.tomcat) ]]; then
  _input_params["tomcat"]=$(yaml $_app_config_file images.tomcat)
fi

if [[ $(yaml $_app_config_file images.redis) ]]; then
  _input_params["redis"]=$(yaml $_app_config_file images.redis)
fi

if [[ $(yaml $_app_config_file images.logstash) ]]; then
  _input_params["logstash"]=$(yaml $_app_config_file images.logstash)
fi

if [[ $(yaml $_app_config_file images.express) ]]; then
  _input_params["express"]=$(yaml $_app_config_file images.express)
fi

if [[ $(yaml $_app_config_file images.haproxy) ]]; then
  _input_params["haproxy"]=$(yaml $_app_config_file images.haproxy)
fi


# 构建 docker network
_network_name=`docker network ls | grep ${_app_name}_network | awk '{split($0,a," " ); print a[2]}'`

if [[ -z "$_network_name" ]]; then
  docker network create ${_app_name}_network
fi

# 创建容器卷 (创建之前先删除)
if [[ ${_input_params['volume']+isset} ]]; then 
  docker pull "${_input_params['volume']}"
  _container_volume_name=`cn_name volume container $_app_name -1`
  cn_run $_app_name $_container_volume_name ${_input_params["volume"]} $_network_name volume volume
  
fi


#if [[ ${_input_params['tomcat']+isset} || ${_input_params['express']+isset} ]]; then 
#  # run node container: apache2、nginx、tomcat、express
#  cecho p "Running Node Containers:"
#  for ((i=1; i<=$_nodecount; i++)) do 
#    _container_node_name=`cn_name web express $_app_name $i`
#    echo $_container_node_name
#    cn_run $_app_name $_container_node_name ${_input_params["express"]} $_network_name express web
#  done
#fi

### run node container: apache2、nginx、tomcat、express
if [[ ${_input_params['tomcat']+isset} ]]; then 
  docker pull "${_input_params['tomcat']}"
  cecho p "Running Tomcat Node Containers:"
  _container_node_name=`cn_name web tomcat $_app_name 1`
  cn_run $_app_name $_container_node_name ${_input_params["tomcat"]} $_network_name tomcat web
fi

if [[ ${_input_params['jdk']+isset} ]]; then 
  docker pull "${_input_params['jdk']}"
  cecho p "Running jdk Node Containers:"
  _container_node_name=`cn_name web jdk $_app_name 1`
  cn_run $_app_name $_container_node_name ${_input_params["jdk"]} $_network_name jdk web
fi

if [[ ${_input_params['nginx']+isset} ]]; then 
  docker pull "${_input_params['nginx']}"
  cecho p "Running Nginx Node Containers:"
  _container_node_name=`cn_name web nginx $_app_name 1`
  cn_run $_app_name $_container_node_name ${_input_params["nginx"]} $_network_name nginx web
  _container_node_name=`cn_name web nginx $_app_name 2`
  cn_run $_app_name $_container_node_name ${_input_params["nginx"]} $_network_name nginx web
fi

if [[ ${_input_params['express']+isset} ]]; then 
  docker pull "${_input_params['express']}"
  cecho p "Running Express Node Containers:"
  _container_node_name=`cn_name web express $_app_name 1`
  cn_run $_app_name $_container_node_name ${_input_params["express"]} $_network_name express web
  _container_node_name=`cn_name web express $_app_name 2`
  cn_run $_app_name $_container_node_name ${_input_params["express"]} $_network_name express web
fi

if [[ ${_input_params['redis']+isset} ]]; then 
  	docker pull "${_input_params['redis']}"
	# run redis VOLUME container
	# TODO
	# run redis container
	_container_node_name=`cn_name primary redis $_app_name -1`
	#echo $_container_node_name
	cn_run $_app_name $_container_node_name ${_input_params['redis']} $_network_name redis primary
fi

if [[ ${_input_params['mysql']+isset} ]]; then 
  docker pull "${_input_params['mysql']}"
  # run mysql VOLUME container
  # TODO
  # run mysql container
  _container_node_name=`cn_name primary mysql $_app_name -1`
  # -v /storage/mysql-server/datadir:/var/lib/mysql_data
  cn_run $_app_name $_container_node_name ${_input_params['mysql']} $_network_name mysql primary
  
  
fi

if [[ ${_input_params['logstash']+isset} ]]; then 
  docker pull "${_input_params['logstash']}"
  # run logstash container
  _container_node_name=`cn_name log logstash $_app_name -1`
  #docker run -d -P --name $_container_node_name ${_input_params['logstash']}
  cn_run $_app_name $_container_node_name ${_input_params['logstash']} $_network_name logstash log
fi

if [[ ${_input_params['haproxy']+isset} ]]; then 
  docker pull "${_input_params['haproxy']}"
  # run haproxy
  _container_node_name=`cn_name loadbalance haproxy $_app_name -1`
  # sed -i -e "s/server s0 hostname_here:80 check/server s1 172.17.0.3:80 check\n        server s2 172.17.0.4:80 check/g" /etc/haproxy/haproxy.cfg
  #docker run -d -P --name $_container_node_name -h $_container_node_name ${_input_params['haproxy']}
  cn_run $_app_name $_container_node_name ${_input_params['haproxy']} $_network_name  haproxy loadbalance
fi


echo ""  >> "$_app_name".command
echo "EOF" >> "$_app_name".command

`pwd`/${_DOCKER_APP_NAME}.hook

cecho y "应用程序 [$_app_name] 创建成功，正在重启....."
docker restart `docker ps -a | grep $_app_name | awk '{split($0, a, " "); print a[1]}'`
docker restart `docker ps -a | grep $_app_name | grep loadbalance | awk '{split($0, a, " "); print a[1]}'`

echo ""

cat $_APP_CONFIG_FILE


#### How To Use FPM To Easily Create Packages in Multiple Formats
## https://www.digitalocean.com/community/tutorials/how-to-use-fpm-to-easily-create-packages-in-multiple-formats




