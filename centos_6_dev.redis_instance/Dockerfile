# licj316/centos_6_dev:redis_instance
# Version 0.0.1
FROM licj316/centos_6_dev:redis_base
MAINTAINER Chunhui.Zhang "chunhui2001@gmail.com"

# REDIS_PASS

VOLUME ["/var/lib/redis", "/var/log/redis/"]

ENTRYPOINT ["/usr/local/bin/redis-server", "--logfile", "/var/log/redis/redis-primary.log"]

CMD ["--requirepass", "Cc"]


EXPOSE 6379