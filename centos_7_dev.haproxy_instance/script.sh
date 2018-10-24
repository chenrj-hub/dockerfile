#!/usr/bin/env bash

_arg=$1

if [[ "$_arg" == "ssl" ]]; then
	if [[ -z "$DOMAIN_NAME" ]]; then
		echo "Please export 'DOMAIN_NAME' as an environment variable"
		echo "-e DOMAIN_NAME='-d example.com -d www.example.com'"
		exit 0
	fi 
	certbot certonly --standalone --preferred-challenges http --http-01-port 80 $DOMAIN_NAME 
fi 

if [[ "$_arg" == "ha" ]]; then 
	haproxy -f /etc/haproxy/haproxy.cfg -p /var/run/haproxy.pid
fi



if [[ "$_arg" == "bash" ]]; then 
	bash
fi