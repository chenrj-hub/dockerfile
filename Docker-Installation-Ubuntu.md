
**************************************************
****************** installation ******************
**************************************************
# update sources.list
$ sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
$ sudo vi /etc/apt/sources.list.d/docker.list
> deb https://apt.dockerproject.org/repo ubuntu-xenial main

# installation
$ sudo apt-get update
$ sudo apt-get install -y apt-transport-https ca-certificates
$ sudo apt-get purge lxc-docker
$ sudo apt-cache policy docker-engine
$ sudo apt-get install -y linux-image-extra-$(uname -r)
$ sudo apt-get install -y docker-engine
$ docker --version
$ sudo service docker status (check docker service is started)
$ sudo docker run hello-world (check docker installed correctly)

# added docker group
$ sudo groupadd docker

# add current user to docker group
$ sudo usermod -aG docker $USER

# restart the computer and log back
$ reboot





**************************************************
*************** simple docker file ***************
**************************************************
# create your first dockerfile
$ mkdir docker_screencasts && cd docker_screencasts && touch Dockerfile
> 
----------------------------------
FROM alpine

CMD ["echo", "hello world!"]
----------------------------------
$ docker build .
$ >
----------------------------------
Sending build context to Docker daemon  14.85kB
Step 1/2 : FROM alpine
latest: Pulling from library/alpine
88286f41530e: Pull complete 
Digest: sha256:f006ecbb824d87947d0b51ab8488634bf69fe4094959d935c0c103f4820a417d
Status: Downloaded newer image for alpine:latest
 ---> 76da55c8019d
Step 2/2 : CMD echo hello world!
 ---> Running in b81cedf9e4a2
 ---> fadf13ffce52
Removing intermediate container b81cedf9e4a2
Successfully built [fadf13ffce52]
----------------------------------

# docker run
$ docker run --name test fadf13ffce52


# remove docker run
$ docker rm test && docker build 
$ docker run --name test fadf13ffce52 (That should be print 'hello world!' on screen)

# run script in dockerfile
$ touch script.sh 
> 
----------------------------------
#! /bin/sh

echo hello world, from a script file!
----------------------------------
> 
----------------------------------
FROM alpine

COPY script.sh /script.sh
CMD ["/script.sh"]
----------------------------------

$ docker stop test && docker rm test
$ docker build . && docker run --name test [built id here]
$ docker stop test && docker rm test



## 修改 docker 镜像默认存储位置
# 新建 /etc/docker/daemon.json 文件
# 加入内容
{
    "graph": "/aliyun_nas/nas/docker-data",
    "storage-driver": "aufs"
}

## docker 加速
$ sudo curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s http://4e70ba5d.m.daocloud.io 
$ sudo service docker restart


## docker 镜像导出与导入
$ docker save [image id] [image id] > images.tar
$ docker load < images.tar


## How to auto-restart Docker containers after a host server crash
https://bobcares.com/blog/auto-restart-docker-containers/2/
docker update --restart=on-failure:3 [container id here]

