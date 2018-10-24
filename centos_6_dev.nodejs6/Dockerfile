# chunhui2001/centos_6_dev:nodejs6
# Version 0.0.1
FROM chunhui2001/centos_6_dev:nodejs_base
MAINTAINER Chunhui.Zhang "chunhui2001@gmail.com"

ARG APP_NAME='____appname'
ARG APP_ENV='local'

## prod, dev, test, local, staging, beta, preview
ENV NODE_ENV=$APP_ENV
ENV HTTP_PORT=3000

## Add sample nodejs app
ADD nodeappdemo /root/nodejs/app

## Set work dir
WORKDIR /root/nodejs/app
RUN npm install

ENTRYPOINT ["/usr/sbin/node"]
CMD ["server.js", "local"]

VOLUME ["/root/nodejs/app"]


## Open ports
EXPOSE $HTTP_PORT
