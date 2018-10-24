# chunhui2001/centos_6_dev:logstash_instance
# Version 0.0.1
FROM chunhui2001/centos_6_dev:logstash_base
MAINTAINER Chunhui.Zhang "chunhui2001@gmail.com"

# Refer
# http://www.cnblogs.com/linuxboke/p/5706813.html
# https://my.oschina.net/guol/blog/182297
## logstash多个mysql的input导出到多个output
# http://m.blog.csdn.net/lilongsy/article/details/78283122

# ADD logstash.conf /etc/
ADD https://raw.githubusercontent.com/chunhui2001/docker-images/master/centos_6_dev.logstash_instance/logstash.conf /etc/

RUN sed -i -e"s/-Xms1g/-Xms64m/g" /usr/local/logstash/config/jvm.options
RUN sed -i -e"s/-Xmx1g/-Xmx64m/g" /usr/local/logstash/config/jvm.options

ENTRYPOINT ["/usr/local/logstash/bin/logstash"]

## For 5.6.4 use -f, above use --config=/etc/logstash.conf
CMD ["-f", "/etc/logstash.conf"]


