# chunhui2001/centos_7_dev:haproxy_instance
# Version 0.0.1
FROM chunhui2001/centos_7_dev:haproxy_base
MAINTAINER Chunhui.Zhang "chunhui2001@gmail.com"


#ENV DOMAIN_NAME='-d example.com -d www.example.com'

ENV REFRESHED_AT 2017-11-21

#RUN service haproxy start && service haproxy stop


ADD script.sh /root/script.sh
ADD haproxy.cfg.default /etc/haproxy/haproxy.cfg


VOLUME ["/etc/letsencrypt"]

RUN chmod +x /root/script.sh

#ENTRYPOINT ["certbot", "certonly", "--standalone", "--preferred-challenges", "http", "--http-01-port", "80", "$DOMAIN_NAME"]
#ENTRYPOINT ["haproxy", "-f", "/etc/haproxy/haproxy.cfg", "-p", "/var/run/haproxy.pid"]
ENTRYPOINT ["/root/script.sh"]

# ssl or empty
CMD ["bash"] 

EXPOSE 80


