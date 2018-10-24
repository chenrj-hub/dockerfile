#!/usr/bin/env bash

# 检查将要构建的镜像在本地仓库中是否存在

_user_local=true
_image_name=$1

function image_exists {

	  _exists='true'
	
	  if [[ $_user_local == 'true' ]]; then
	  	  _result=`docker inspect $1 2>&1 >/dev/null | awk '{split($0,a," " ); print a[5]}'`
	  	  _exists='local'
	  	  if [[ $_result == $_image_name ]]; then
		  	 _exists='false'
		  fi
	  else 
		  _result=`docker pull $1  2>&1 >/dev/null | awk '{split($0,a," " ); print a[7]}'`
		  _error=`docker pull $1  2>&1 >/dev/null | awk '{split($0,a," " ); print a[1]}'`
		  _exists='remote'
		  if [[ $_error == 'Error' || $_result == $_image_name ]]; then
		  	 _exists='false'
		  fi
	  fi 
	  
	  if [[ $_exists == 'false' ]]; then
	  	_exists=''
	  fi
	  
	  echo $_exists
	  
}

image_exists $_image_name

