#!/usr/bin/env bash

_color=$1
_message=$2

_message=$_message$_newline


RED_COLOR='\E[1;31m'  #红
GREEN_COLOR='\E[1;36m' #绿
YELOW_COLOR='\E[1;33m' #黄
BLUE_COLOR='\E[1;34m'  #蓝
PINK_COLOR='\E[1;35m'      #紫色
RES='\E[0m'

case $1 in
  red | Red | r)
    _color=$RED_COLOR
  ;;
  green | Green | g)
    _color=$GREEN_COLOR
  ;;
  yelow | ye | Yelow | y)
    _color=$YELOW_COLOR
  ;;
  blue | b | Blue)
    _color=$BLUE_COLOR
  ;;
  pink | Pink | p)
    _color=$PINK_COLOR
  ;;
  *)
    _color=$PINK_COLOR
  ;;
esac


echo -e  "${_color}${_message}${RES}"
