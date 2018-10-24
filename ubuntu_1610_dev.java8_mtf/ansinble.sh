#!/usr/bin/env bash

cd /root/app/mtf-cms && git checkout . && git pull origin master
cd /root/app/mtf-cms-a4 && git checkout . && git pull origin master

cd /root/app/mtf-cms-a4 && npm install --registry https://registry.cnpmjs.org && ./sync.sh
cd /root/app/mtf-cms && /usr/local/maven/bin/mvn clean compile dependency:copy-dependencies

