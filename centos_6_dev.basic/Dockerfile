# chunhui2001/centos_6_dev:basic 
# Version 0.0.1
FROM centos:6
MAINTAINER Chunhui.Zhang "chunhui2001@gmail.com"

# Install dev tools
RUN yum -y update && yum groupinstall -y "Development Tools" && yum install -y wget mkfontscale zlib-devel

## Install lsb
RUN yum install -y `yum provides */lsb_release | grep x86_64 | awk '{split($0,a,":" ); print a[1]}'`

## 安装 devtools2 for C++11 compiler
RUN wget http://people.centos.org/tru/devtools-2/devtools-2.repo -O /etc/yum.repos.d/devtools-2.repo
RUN yum install -y devtoolset-2-gcc devtoolset-2-binutils devtoolset-2-gcc-c++
RUN ln -s /opt/rh/devtoolset-2/root/usr/bin/* /usr/local/bin/
RUN update-alternatives --install /usr/bin/gcc gcc /usr/local/bin/gcc 100
RUN update-alternatives --install /usr/bin/g++ g++ /usr/local/bin/g++ 100


## 设定时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

## Chinese Support
RUN yum groupinstall -y "Chinese Support"

# Install Microsoft TrueType Fonts in CentOS 6
RUN wget http://www.itzgeek.com/msttcore-fonts-2.0-3.noarch.rpm && rpm -Uvh msttcore-fonts-2.0-3.noarch.rpm && rm -f msttcore-fonts-2.0-3.noarch.rpm

## 刷新内存中的字体缓存
RUN fc-cache -fv

## 通过fc-list看一下字体列表
# fc-list

## 查看已安装的中文字体
# fc-list :lang=zh

## 安装微软雅黑字体
# http://blog.csdn.net/brad_chen/article/details/50110189

## 设置默认字体
# https://seasonofcode.com/posts/how-to-set-default-fonts-and-font-aliases-on-linux.html

WORKDIR /usr/share/fonts/wqy-microhei/
RUN mkfontscale && fc-cache -fv  1>/dev/null 2>&1


# Upgrade openssl
RUN wget https://github.com/openssl/openssl/archive/OpenSSL_1_1_0f.tar.gz -P /usr/local/ && tar -zxf /usr/local/OpenSSL_1_1_0f.tar.gz -C /usr/local/ 

WORKDIR /usr/local/openssl-OpenSSL_1_1_0f
RUN ./config shared zlib-dynamic && make && make install && echo "/usr/local/lib64" >> /etc/ld.so.conf && ldconfig


WORKDIR /root/

# Open ports
# EXPOSE 80
