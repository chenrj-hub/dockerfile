# chunhui2001/ubuntu_1610_dev:nodejs6
# Version 0.0.1
FROM chunhui2001/ubuntu_1610_dev:nodejs_base
MAINTAINER Chunhui.Zhang "chunhui2001@gmail.com"

ARG APP_NAME='____appname'
ARG APP_ENV='local'

## prod, dev, test, local, staging, beta, preview
ENV NODE_ENV=$APP_ENV
ENV HTTP_PORT=3000

## Create logs folder
RUN mkdir -p /var/log/nodejs

## Add sample nodejs app
ADD nodeappdemo /root/nodejs/app

## 更新配置文件
# TODO

## Set work dir
WORKDIR /root/nodejs/app
#RUN npm install --unsafe-perm node-gyp --registry https://registry.cnpmjs.org
RUN npm install

ENTRYPOINT ["/usr/sbin/node"]
CMD ["server.js", $NODE_ENV]

# /var/log/nodejs/app.log
VOLUME ["/root/nodejs/app"]

### docker build --build-arg APP_NAME=nodeappdemo --build-arg APP_ENV=local -t chunhui2001/ubuntu_1610_dev:nodejs6 .
### docker run -d -P --net ebid_network -h nodeappdemo --name nodeappdemo chunhui2001/ubuntu_1610_dev:nodejs6

## Open ports
EXPOSE $HTTP_PORT
