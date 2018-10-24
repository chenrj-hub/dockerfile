### container name pattern, 
## 容器的名字必须是唯一的，当容器删除的时候会删除所有包含该名字的容器
## 删除容器的时候并不删除卷(volume)
## 方括号内的字符是变化的
> app.[container name]_[].
  [mysqldb or h2db or oracledb or redis or mongo or mssqldb or apache or nginx or tomcat nodejs].
  [volume or node or net]
> app.[ebid]_[volume].[mysqldb].[volume]
> app.[ebid]_[volume].[apache].volume]
> app.[ebid]_[node1].[nginx].node]
> app.[ebid]_[node2].[nginx].node]
> net.[ebid]

### docker build
$ docker build -t "registry/image name:tag" .

### docker run
$ docker run -d -P --name daemon "registry/image name:tag" -g "daemon off;"

### docker exec
$ docker exec -it "container name or container id" /bin/bash

### docker commit
$ sudo docker commit 614122c0aabb 

### docker cp
$ docker cp /www/runoob 96f7f14e99ab:/www/

### 查看 docker 镜像存储空间容量
$ du -sh /var/lib/docker

### vim replace
:%s/usr\/lib\/jvm\/java-7-sun/usr\/local\/java/gc

### remove large file from github
$ git rm --cached giant_file
$ git commit --amend -CHEAD
$ git push

### github remote add 
$ echo "# docker-images" >> README.md
$ git init
$ git add README.md
$ git commit -m "first commit"
$ git remote add origin git@github.com:chunhui2001/docker-images.git
$ git push -u origin master






### docker networking
$ docker network create supercard-network
$ docker network ls OR docker network ls -q

## create a container in a exist docker network, docker 网络名不可以有特殊字符
$ docker run -d -P --net=supercard_network --name daemon_dave chunhui2001/ubuntu_1610_dev:nginx_default

## 将已有容器连接到 docker 网络
$ docker network connect supercard-network daemon_redis

## 断开一个容器与指定网络的连接
$ docker network disconnect supercard-network daemon_redis

## 删除一个 docker 网络
$ docker network rm supercard-network

## 查看一个 docker 网络下的所有容器
$ docker inspect --format='{{ .Containers }}' supercard-network

## 通过模版来查找所有退出码为非 0 的容器名
$ docker inspect -f '{{if ne 0.0 .State.ExitCode }}{{.Name}} {{.State.ExitCode}}{{ end }}' $(docker ps -aq)

## 在 jenkins-data 容器中查找卷 /var/jenkins_home 对应在 host 的目录
$ docker inspect -f '{{index .Volumes "/var/jenkins_home"}}' jenkins-data

## 查看所有容器的 ip 地址
$ docker inspect --format '{{ .NetworkSettings.IPAddress }}' `docker ps -aq`

## 根据容器名字列出指定网络下的所有容器的 ip
$ docker inspect -f '{{ .NetworkSettings.Networks.supercard_network.IPAddress }}' `docker ps -a | grep supercard |  awk '{split($0,a," " ); print a[1]}'`

# Ubuntu 16.04 安装Docker ，Pull Docker image的时候遇到docker pull TLS handshake timeout
http://blog.csdn.net/han_cui/article/details/55190319







