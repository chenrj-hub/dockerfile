# chunhui2001/ubuntu_1610_dev:haproxy_instance
# Version 0.0.1
FROM chunhui2001/ubuntu_1610_dev:haproxy_base
MAINTAINER Chunhui.Zhang "chunhui2001@gmail.com"

ENV REFRESHED_AT 2017-11-10

RUN touch /tmp/haprxoy_log.sock && chmod 777 /tmp/haprxoy_log.sock
RUN service haproxy start && service haproxy stop

ADD haproxy.cfg.default /etc/haproxy/haproxy.cfg

ENTRYPOINT ["/usr/sbin/rsyslogd"]
ENTRYPOINT ["haproxy", "-f", "/etc/haproxy/haproxy.cfg", "-p", "/var/run/haproxy.pid"]

#CMD ["-p /var/run/haproxy.pid"]

EXPOSE 80