#!/usr/bin/env bash

# 检查将要构建的镜像在本地仓库中是否存在
_image_path=$1
_user_account=`echo $1 | awk '{split($0,a,"/" ); print a[1]}'`
_image_name=`echo $1 | awk '{split($0,a,"/" ); print a[2]}' | awk '{split($0,a,":" ); print a[1]'}`
_image_tag=`echo $1 | awk '{split($0,a,"/" ); print a[2]}' | awk '{split($0,a,":" ); print a[2]'}`

_image_exists=`im_exists $_image_path`

if [[ -z "$_image_exists" || 1==1 ]]; then 
  # not exists
  # build image
  cecho p "Building Docker Image: ["$_image_path"]"
  docker rmi $_image_path>/dev/null 2>/dev/null
  docker build -t $_image_path $DOCKER_IMAGES_HOME/$_image_name.$_image_tag
  cecho g "Build Docker Image Completed >>>> $_image_path <<<<"
else 
  # exists 
  if [[ $_image_exists == 'remote' ]]; then
  	cecho b "Pull a docker image from docker hub: ["$_image_path"]"
  fi
  if [[ $_image_exists == 'local' ]]; then
  	cecho y "Use docker image from local: ["$_image_path"]"
  fi
fi