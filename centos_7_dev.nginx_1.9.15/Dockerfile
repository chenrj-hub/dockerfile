# chunhui2001/centos_7_dev:nginx_1.9.15
# Version 0.0.1
FROM chunhui2001/centos_7_dev:basic
MAINTAINER Chunhui.Zhang "chunhui2001@gmail.com"

# Add nginx_work.tar to /root/
ADD nginx-work.tar /root/

RUN yum install epel-release -y
RUN yum install -y httpd-devel pcre perl pcre-devel zlib zlib-devel GeoIP GeoIP-devel
RUN yum install -y gc gcc gcc-c++ pcre-devel zlib-devel make wget openssl-devel libxml2-devel 
RUN yum install -y libxslt-devel gd-devel perl-ExtUtils-Embed
RUN yum install -y gperftools gperftools-devel libatomic_ops-devel perl-devel
RUN yum install -y readline-devel ncurses-devel openssl-devel

#RUN wget http://geolite.maxmind.com/download/geoip/api/c/GeoIP.tar.gz && tar -zxvf GeoIP.tar.gz && cd GeoIP-* && ./configure && make && make install
#RUN echo '/usr/local/lib' > /etc/ld.so.conf.d/geoip.conf && ldconfig


### Install Lua
RUN wget http://www.lua.org/ftp/lua-5.2.0.tar.gz -P /usr/local/ && tar zxf /usr/local/lua-*.tar.gz -C /usr/local/
RUN sed -i -e "s/^INSTALL_TOP=[[:space:]]*\/usr\/local$/INSTALL_TOP= \/usr\/local\/lua/g" /usr/local/lua-*/Makefile
WORKDIR /usr/local/lua-5.2.0
RUN make linux && make install

RUN wget "http://luajit.org/download/LuaJIT-2.0.1.tar.gz" -P /usr/local/ && tar -xzf /usr/local/LuaJIT-*.tar.gz -C /usr/local/
WORKDIR /usr/local/LuaJIT-2.0.1
RUN  make && make install
RUN ln -s /usr/local/lib/libluajit-5.1.so.2 /lib64/libluajit-5.1.so.2

RUN useradd nginx && usermod -s /sbin/nologin nginx

### extract dependencies
RUN tar -zxf /root/nginx-work/nginx-1.9.15.tar.gz -C /root/nginx-work/
RUN tar -zxf /root/nginx-work/lua-nginx-module-v0.10.6rc1.tar.gz -C /root/nginx-work/
RUN tar -zxf /root/nginx-work/ngx_devel_kit-v0.3.0.tar.gz -C /root/nginx-work/
RUN tar -zxf /root/nginx-work/zlib-1.2.8.tar.gz -C /root/nginx-work/
RUN tar -zxf /root/nginx-work/openssl-1.0.2h.tar.gz -C /root/nginx-work/
RUN cp /root/nginx-work/configure.sh /root/nginx-work/nginx-1.9.15/
RUN mkdir /root/nginx-work/nginx-1.9.15/modules/
RUN mv /root/nginx-work/nginx-ey-balancer /root/nginx-work/nginx-1.9.15/modules/
RUN sed -i -e "s/^NGINX_DIR[[:space:]]*=.*$/NGINX_DIR = \"..\/nginx-1.9.15\"/g" /root/nginx-work/nginx-1.9.15/modules/nginx-ey-balancer/Makefile

ENV LUAJIT_LIB=/usr/local/lib
ENV LUAJIT_INC=/usr/local/include/luajit-2.0
WORKDIR /root/nginx-work/nginx-1.9.15/
RUN patch -p0 < modules/nginx-ey-balancer/patches/nginx-1.9.15.patch
RUN ./configure.sh && make && make install


WORKDIR /root/nginx-work

# update nginx.conf /usr/local/nginx/conf/nginx.conf
COPY nginx.sample.nginx.conf /usr/local/nginx/conf/nginx.conf

# add sites-enabled/default
COPY nginx.sample.default /usr/local/nginx/sites-enabled/default

# add index.html /usr/local/nginx/html/
COPY index.html /usr/local/nginx/html/index.html

# copy mime.types file to /usr/local/nginx
RUN cp mime.types /usr/local/nginx/mime.types

# use sed to update index.html
RUN sed -i "s#%%DATE%%#`date -d today +"%Y-%m-%d %H:%M:%S.%s"`#g" /usr/local/nginx/html/index.html

# run nginx with daemon off 
ENTRYPOINT ["/usr/local/nginx/sbin/nginx"]

# remove /root/nginx-work
WORKDIR /root
RUN rm -rf /root/nginx-work && rm -rf /usr/local/lua-* && rm -rf /usr/local/LuaJIT-* 

# CMD ["-g", "daemon off;"]

# open port
EXPOSE 80
