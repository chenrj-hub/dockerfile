# chenrj/ubuntu_1610_dev:nginx_1.9.15
# Version 0.0.1
FROM chenrj/ubuntu_1610_dev:zh-CN
MAINTAINER chenrj "790099746@qq.com"

# copy nginx_work folder
COPY nginx-work /root/nginx-work

# extract files
WORKDIR /root/nginx-work
RUN tar -zxf LuaJIT-2.0.1.tar.gz && tar -zxf lua-nginx-module-v0.10.6rc1.tar.gz && tar -zxf nginx-1.9.15.tar.gz && tar -zxf ngx_devel_kit-v0.3.0.tar.gz && tar -zxf openssl-1.0.2h.tar.gz && tar -zxf zlib-1.2.8.tar.gz

# install dependencies
RUN apt-get -yqq update && apt-get install -yqq build-essential autoconf libssl-dev curl libcurl4-gnutls-dev zlib1g zlib1g-dev libxml2 libxml2-dev libxslt-dev libreadline6-dev libpcre3 libpcre3-dev libssl-dev openssl libssl-dev libperl-dev libgd-dev libgeoip-dev libpam-dev libatomic-ops-dev lua5.1 liblua5.1-0 liblua5.1-0-dev

# ln and ldconfig
RUN ln -s /usr/lib/x86_64-linux-gnu/liblua5.1.so /usr/lib/liblua.so && ldconfig

# install lua
WORKDIR /root/nginx-work/LuaJIT-2.0.1
RUN make && make install >/dev/null 2>/dev/null

# install nginx
WORKDIR /root/nginx-work/nginx-1.9.15
RUN mkdir modules && mv ../nginx-ey-balancer ./modules
RUN sed -i "s#nginx-0.6.35#nginx-1.9.15#g" modules/nginx-ey-balancer/Makefile
RUN patch -p0 < modules/nginx-ey-balancer/patches/nginx-1.9.15.patch
RUN export LUAJIT_LIB=/usr/local/lib && export LUAJIT_INC=/usr/local/include/luajit-2.0
RUN ../configure.sh >/dev/null 2>/dev/null && make >/dev/null 2>/dev/null && make install >/dev/null 2>/dev/null

# add nginx user
RUN useradd -r nginx && usermod -s /sbin/nologin nginx

WORKDIR /root/nginx-work/

# copy mime.types file to /usr/local/nginx
RUN cp mime.types /usr/local/nginx/mime.types

# update nginx.conf /usr/local/nginx/conf/nginx.conf
COPY nginx.sample.nginx.conf /usr/local/nginx/conf/nginx.conf

# add sites-enabled/default
COPY nginx.sample.default /usr/local/nginx/sites-enabled/default

# add index.html /usr/local/nginx/html/
COPY index.html /usr/local/nginx/html/index.html

# use sed to update index.html
RUN sed -i "s#%%DATE%%#`date -d today +"%Y-%m-%d %H:%M:%S.%s"`#g" /usr/local/nginx/html/index.html

# run nginx with daemon off 
ENTRYPOINT ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]

# remove /root/nginx-work
WORKDIR /root
RUN rm -rf /root/nginx-work

# CMD ["-g", "daemon off;"]

# open port
EXPOSE 80
