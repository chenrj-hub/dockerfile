#!/usr/bin/env bash

_image_name=$1
#_expose_port=`docker inspect --format "{{ .ContainerConfig.ExposedPorts }}" $_image_name | sed 's/[^0-9 ]//g'`
_expose_port=`docker inspect $_image_name | grep /tcp\": |  sed 's/[^0-9]//g' | awk '{printf("%s ",$0);}'`
_len=`expr ${#_expose_port} / 2`
_result=`expr substr "$_expose_port" 1 $_len`


echo $_result