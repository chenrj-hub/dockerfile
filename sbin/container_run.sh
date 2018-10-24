#!/usr/bin/env bash

_app_name=$1	# 应用程序名字
_new_nodename=$2	# 容器名字
_image_name=$3		# 镜像名字
_network_name=$4	# 网络名字
_provider_name=$5 	# 类型， volume, redis, mysql, etc.	
_container_type=$6  # 

_container_config=`cn_config $_app_name $_new_nodename $_image_name $_network_name $_provider_name`

_container_id=`$_container_config | awk '{print substr($0,1,12)}'`

cecho g "Container Confituration: "

echo "### $_new_nodename:" >>  ./"$_app_name".command
echo "$_container_config" >> ./"$_app_name".command
echo ""  >> ./"$_app_name".command
cecho b "$_container_config"

# 判断是否创建成功
if [[ -z "$_container_id" ]]; then 
  #cecho y "$_container_config"
  cecho r "[$_new_nodename] 创建容器失败，容器名可能重复!"
  exit
fi

cecho y "容器创建成功 ["$_new_nodename"]"
echo ""

if [[ $_provider_name != 'volume' ]]; then
   
    #_lasthosts=`docker exec $_container_id tail -1 /etc/hosts`
	#_ip=`echo $_lasthosts | awk '{split($0,a," " ); print a[1]}'`
	#_hostname=`echo $_lasthosts | awk '{split($0,a," " ); print a[2]}'`
	#_port_bind="无" #`docker port $_container_id | awk 'NR==1' | awk '{split($0,a,"[:/]" ); print a[1], a[3]}'`
	#cecho b "A****** $_container_id *******"
	#cecho y "A new continer is running: "
	#cecho y "Container Id: $_container_id"
	#cecho y "IP Address: $_ip"
	#cecho y "Hostname: $_new_nodename"
	#cecho y "Port: "`if [[ -z "$_port_bind" ]]; then   echo "无" ; else echo $_port_bind ; fi `
	#cecho b "******* $_container_id *******"
	
	#echo ""
	
	
	
	if [[ "$_provider_name" == "haproxy" ]]; then
	  # 如果容器启动成功，进入容器修改 
	  cecho y "进入容器修改 ["$_new_nodename"]"
	  cn_update $_app_name $_new_nodename loadbalance haproxy 
	fi
	
	#if [[ "$_provider_name" == "tomcat" ]]; then
	#  # 如果容器启动成功，进入 tomcat 容器修改 
	#  cn_update $_app_name $_new_nodename web tomcat 
	#fi
   
fi


