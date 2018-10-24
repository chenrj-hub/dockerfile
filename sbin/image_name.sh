#!/usr/bin/env bash

# 取当前路径下的 Dockerfile 中的第一行中约定好的镜像名字
_image_name=`cat Dockerfile | grep '^\s*#' | awk 'NR==1' | awk '{split($0,a," " ); print a[2]}'`
echo $_image_name
