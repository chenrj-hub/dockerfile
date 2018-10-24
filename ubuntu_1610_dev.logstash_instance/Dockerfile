# chunhui2001/ubuntu_1610_dev:logstash_instance
# Version 0.0.1
FROM chunhui2001/ubuntu_1610_dev:logstash_base
MAINTAINER Chunhui.Zhang "chunhui2001@gmail.com"


# Refer
# http://www.cnblogs.com/linuxboke/p/5706813.html
# https://my.oschina.net/guol/blog/182297
## logstash多个mysql的input导出到多个output
# http://m.blog.csdn.net/lilongsy/article/details/78283122

ARG APP_NAME='____appname'
ARG APP_ENV='local'

ENV APP_NAME=$APP_NAME
ENV APP_ENV=$APP_ENV

# RUN mkdir -p /var/log/nodejs/____appname.log
# RUN mkdir -p /var/log/redis/____appname-redis-primary.log

ADD logstash.conf /etc/

## update __appname to $APP_NAME
#RUN sed -i -e"s/____appname/$APP_NAME/" /etc/logstash.conf

WORKDIR /opt/logstash

ENTRYPOINT ["bin/logstash"]

CMD ["--config=/etc/logstash.conf"]

### docker build -t chunhui2001/ubuntu_1610_dev:logstash_instance .

### docker run -d --name logstash_app --volumes-from redis --volumes-from node --volumes-from tomcat --volumes-from nginx --volumes-from mysql \
### chunhui2001/ubuntu_1610_dev:logstash_instance


## Open ports
#EXPOSE $HTTP_PORT