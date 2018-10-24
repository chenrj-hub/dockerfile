git clone https://github.com/keeshzhang/mtf-cms.git ~/mtf-cms
git clone https://github.com/keeshzhang/mtf-cms-a4.git ~/mtf-cms-a4

docker rm -f app.mtfcms.server.volume app.mtfcms.server.hub app.mtfcms.server.java

docker create -v ~/mtf-cms:/root/app/mtf-cms -v ~/mtf-cms-a4:/root/app/mtf-cms-a4 --name app.mtfcms.server.volume chunhui2001/ubuntu_1610_dev:java8_mtf_server
docker run -it --name app.mtfcms.server.hub --volumes-from app.mtfcms.server.volume chunhui2001/ubuntu_1610_dev:java8_mtf_server /root/ansinble.sh
docker create -p 9180:9181 --name app.mtfcms.server.java --volumes-from app.mtfcms.server.volume chunhui2001/ubuntu_1610_dev:java8_mtf_server /usr/local/maven/bin/mvn exec:java

docker restart app.mtfcms.server.hub
docker start app.mtfcms.server.java