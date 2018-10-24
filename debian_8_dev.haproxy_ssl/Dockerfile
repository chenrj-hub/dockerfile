# chunhui2001/debian_8_dev:haproxy_ssl
# Version 0.0.1
FROM bradjonesllc/docker-haproxy-letsencrypt
MAINTAINER Chunhui.Zhang <chunhui2001@gmail.com>

RUN apt-get update -y && apt-get install vim -y

ADD haproxy.cfg.default /usr/local/etc/haproxy/haproxy.cfg

#docker create \
#	--net ha_test \
#    -e CERTS=damiaa.com,www.damiaa.com \
#    -e EMAIL=chunhui2001@gmail.com \
#    -v /etc/letsencrypt:/etc/letsencrypt \
#    -v /root/haproxy.cfg.default:/usr/local/etc/haproxy/haproxy.cfg \
#    -p 80:80 -p 443:443 \
#    chunhui2001/debian_8_dev:haproxy_ssl
    

#docker create --net ha_test -e CERTS=damiaa.com,www.damiaa.com -e EMAIL=chunhui2001@gmail.com -v /etc/letsencrypt:/etc/letsencrypt  -v /root/haproxy.cfg.default:/usr/local/etc/haproxy/haproxy.cfg -p 80:80 -p 443:443 chunhui2001/debian_8_dev:haproxy_ssl
#docker create --name app.Dev360bidCn.haproxy.loadbalance --net Dev360bidCn_network -e CERTS=360bid.top,www.360bid.top,develop.360bid.cn -e EMAIL=chunhui2001@gmail.com -v /etc/letsencrypt:/etc/letsencrypt -p 80:80 -p 443:443 chunhui2001/debian_8_dev:haproxy_ssl

#docker create --net ha_test -e CERTS=360bid.top,www.360bid.top -e EMAIL=chunhui2001@gmail.com -v /root/letsencrypt_360bid_top:/etc/letsencrypt  -v /root/haproxy.cfg.default:/usr/local/etc/haproxy/haproxy.cfg -p 80:80 -p 443:443 chunhui2001/debian_8_dev:haproxy_ssl

#docker create --net ha_test -p 80:80 chunhui2001/centos_6_dev:haproxy_instance
     
 
    