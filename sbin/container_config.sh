#!/usr/bin/env bash

_docker_config_file=$_APP_CONFIG_FILE

_app_name=$1	# 应用程序名字
_new_nodename=$2
_image_name=$3
_network_name=$4
_provider_name=$5 	# 类型， redis, mysql, express, etc.	
_expose_ports=`im_expose $_image_name`

_container_cmd=''
_container_volume=''
_container_env='' 	# 容器环境变量
_container_volume_from=`cn_name volume container $_app_name -1`
_container_slash_p='-P'

_app_env=$(yaml $_docker_config_file main.app_env)
_app_ports=$(yaml $_docker_config_file main.app_port)

_tomcat_volume=$(yaml $_docker_config_file volumes.tomcat)
_tomcat_log_volume=$(yaml $_docker_config_file volumes.tomcat_log)
_express_volume=$(yaml $_docker_config_file volumes.express)
_mysql_volume=$(yaml $_docker_config_file volumes.mysql)
_jdk_volume=$(yaml $_docker_config_file volumes.jdk)

_passwd_redis=$(yaml $_docker_config_file redis.redis_passwd)
_passwd_mysql=$(yaml $_docker_config_file mysql.mysql_passwd)


if [[ $_provider_name == 'volume' ]]; then

  if [[ ! -z "$_express_volume" ]]; then 
    # express volume
    _container_volume="$_container_volume -v $_express_volume:/root/nodejs/app"
  fi
	
  if [[ ! -z "$_tomcat_volume" ]]; then 
    # tomcat volume
    _container_volume="$_container_volume -v $_tomcat_volume:/usr/local/tomcat/webapps/ROOT -v $_tomcat_log_volume:/usr/local/tomcat/logs"
  fi
  
  if [[ ! -z "$_mysql_volume" ]]; then 
    # mysql volume
    _container_volume="$_container_volume -v $_mysql_volume:/var/lib/mysql_data"
  fi
  
  if [[ ! -z "$_jdk_volume" ]]; then 
    # mysql volume
    _container_volume="$_container_volume -v $_jdk_volume:/root/app"
  fi
fi 


if [[ $_provider_name == 'mysql' ]]; then 
	#_container_env="-e MYSQL_ROOT_PASSWORD=$_passwd_mysql"
	_container_env="-e MYSQL_ROOT_PASSWORD=Cc"
  #  _container_slash_p='-p 3307:3306'
fi

if [[ $_provider_name == 'express' ]]; then
    _container_cmd="server.js $_app_env"
fi 


if [[ $_provider_name == 'jdk' ]]; then
    _container_cmd="/root/app/redeploy.sh $_app_env"
fi 

if [[ $_provider_name == 'redis' ]]; then 
	_container_cmd="--requirepass $_passwd_redis --bind 0.0.0.0 --protected-mode no"
  _container_slash_p='-p 16379:6379'
fi

if [[ $_provider_name == 'volume' ]]; then 
  echo "docker create --net $_network_name -h $_new_nodename $_container_volume --name $_new_nodename $_image_name $_container_cmd"
fi

if [[ $_provider_name == 'haproxy' ]]; then 

  OLD_IFS="$IFS" 
  IFS=" " 
  _app_port_arr=($_app_ports) 
  _expose_port_arr=($_expose_ports) 
  IFS="$OLD_IFS" 
  _app_ports_slash_p=''

  for (( i = 0 ; i < ${#_app_port_arr[@]} ; i++ ))
  do
  	
  	if [[ -z "${_expose_port_arr[$i]}" ]]; then
		break
  	fi

  	_app_ports_slash_p=`printf "%s-p %s:%s" "$_app_ports_slash_p " "${_app_port_arr[$i]}" "${_expose_port_arr[$i]}"`
  	
  done

  [[ -z "$_app_ports_slash_p" ]] && _container_slash_p="-P" || _container_slash_p="$_app_ports_slash_p"

  #_container_slash_p=$(_app_ports_slash_p:-" -P ")

fi


if [[ $_provider_name != 'volume' ]]; then 
  echo "docker create $_container_slash_p --net $_network_name -h $_new_nodename --volumes-from $_container_volume_from --name $_new_nodename $_container_env $_image_name $_container_cmd"
fi

# 在容器非正常退出时重启容器（退出状态非0），最多重启3次
# --restart=on-failure:3
# docker update --restart=on-failure:3 0711ffd56539 49a242d757d4 cad69a2c3531 0317cf6bd362 28f81780239f
# docker inspect --format '{{.HostConfig.RestartPolicy.Name}} {{.HostConfig.RestartPolicy.MaximumRetryCount}}' 28f81780239f

# 查看重启次数
# docker inspect -f "{{ .RestartCount }}" 28f81780239f

# 查看容器最后一次的启动时间
# docker inspect -f "{{ .State.StartedAt }}" 28f81780239f

