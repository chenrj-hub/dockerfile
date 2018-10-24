#!/usr/bin/env bash

_remove=$1
_lns=$2

rm -rf $DOCKER_IMAGES_HOME/sbin/im_build $DOCKER_IMAGES_HOME/sbin/im_exists \
	   $DOCKER_IMAGES_HOME/sbin/im_expose $DOCKER_IMAGES_HOME/sbin/im_name \
	   $DOCKER_IMAGES_HOME/sbin/yaml \
	   $DOCKER_IMAGES_HOME/sbin/cecho $DOCKER_IMAGES_HOME/sbin/cn_config \
	   $DOCKER_IMAGES_HOME/sbin/cn_name $DOCKER_IMAGES_HOME/sbin/cn_run \
	   $DOCKER_IMAGES_HOME/sbin/cn_update
	   
if [[ "$_remove" == "r" ]]; then
	exit
fi 
	   
ln -s $DOCKER_IMAGES_HOME/sbin/image_build.sh $DOCKER_IMAGES_HOME/sbin/im_build
ln -s $DOCKER_IMAGES_HOME/sbin/image_exists.sh $DOCKER_IMAGES_HOME/sbin/im_exists
ln -s $DOCKER_IMAGES_HOME/sbin/image_expose.sh $DOCKER_IMAGES_HOME/sbin/im_expose
ln -s $DOCKER_IMAGES_HOME/sbin/image_name.sh $DOCKER_IMAGES_HOME/sbin/im_name
ln -s $DOCKER_IMAGES_HOME/sbin/yaml.sh $DOCKER_IMAGES_HOME/sbin/yaml
ln -s $DOCKER_IMAGES_HOME/sbin/cecho.sh $DOCKER_IMAGES_HOME/sbin/cecho
ln -s $DOCKER_IMAGES_HOME/sbin/container_config.sh $DOCKER_IMAGES_HOME/sbin/cn_config
ln -s $DOCKER_IMAGES_HOME/sbin/container_name.sh $DOCKER_IMAGES_HOME/sbin/cn_name
ln -s $DOCKER_IMAGES_HOME/sbin/container_run.sh $DOCKER_IMAGES_HOME/sbin/cn_run
ln -s $DOCKER_IMAGES_HOME/sbin/container_update.sh $DOCKER_IMAGES_HOME/sbin/cn_update

