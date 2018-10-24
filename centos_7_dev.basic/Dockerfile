# chenrj/centos_7_dev:basic 
# Version 0.0.1
FROM centos:7
MAINTAINER chenrj "790099746@qq.com"

# Install dev tools
RUN yum -y update && yum groupinstall -y "Development Tools" && yum install -y wget mkfontscale zlib-devel

## Install lsb
RUN yum install -y `yum provides */lsb_release | grep x86_64 | awk '{split($0,a,":" ); print a[1]}'`

# Install openssl
RUN wget https://github.com/openssl/openssl/archive/OpenSSL_1_1_0f.tar.gz -P /usr/local/ && tar -zxf /usr/local/OpenSSL_1_1_0f.tar.gz -C /usr/local/ 
WORKDIR /usr/local/openssl-OpenSSL_1_1_0f
RUN ./config shared zlib-dynamic --prefix=/usr/local/openssl && make && make install && echo "/usr/local/lib64" >> /etc/ld.so.conf && ldconfig



#　mv /usr/bin/openssl /usr/bin/openssl.bak
#　mv /usr/include/openssl /usr/include/openssl.bak
#　ln -s /usr/local/ssl/bin/openssl /usr/bin/openssl
#　ln -s /usr/local/ssl/include/openssl /usr/include/openssl
#　echo “/usr/local/ssl/lib” >> /etc/ld.so.conf
#　ldconfig -v
# openssl version -a


## 设定时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

## Chinese Support
RUN yum install -y kde-l10n-Chinese && yum reinstall -y glibc-common && yum groupinstall -y "fonts"
RUN localedef -c -f UTF-8 -i zh_CN zh_CN.utf8

ENV LANG zh_CN.UTF-8
ENV LANGUAGE zh_CN:zh
ENV LC_ALL zh_CN.UTF-8

## 查看语言设置
# locale –a

RUN rm -rf /usr/local/*1_1_0f*

WORKDIR /root/

# Open ports
# EXPOSE 80
