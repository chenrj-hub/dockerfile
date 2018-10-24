# chunhui2001/ubuntu_1610_dev:redis_instance
# Version 0.0.1
FROM chunhui2001/ubuntu_1610_dev:redis_base
MAINTAINER Chunhui.Zhang "chunhui2001@gmail.com"

ENV REFRESHED_AT 2017-10-30

ARG APP_NAME='____appname'
ARG APP_ENV='local'
ARG passwd=Cc

ENV APP_NAME=$APP_NAME

#RUN sed -i -e"s/^#\s*requirepass\s*foobared/requirepass ${passwd}/" /etc/redis/redis.conf

# /var/log/redis/app-redis-primary.log
VOLUME ["/var/lib/redis", "/var/log/redis/"]

#ENTRYPOINT ["/usr/bin/redis-server", "/etc/redis/redis.conf"]
ENTRYPOINT ["/usr/bin/redis-server", "--logfile", "/var/log/redis/redis-primary.log"]

CMD ["--requirepass", "Cc"]


### docker build -t chunhui2001/ubuntu_1610_dev:redis_instance .
### docker run -d -P --net=ebid_network --name nodeappdemo_redis -h nodeappdemo_redis chunhui2001/ubuntu_1610_dev:redis_instance \
###			--requirepass Cc --bind 0.0.0.0 --protected-mode no

EXPOSE 6379

