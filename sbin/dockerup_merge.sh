#!/usr/bin/env bash

./lns.sh

echo '#!/usr/bin/env bash' > $DOCKER_IMAGES_HOME/sbin/dockerup

function merge () {
	_file_name=$1
	_function_name=`echo $_file_name | awk '{split($0, a, "."); print a[1]}'`
	_content=$(cat $DOCKER_IMAGES_HOME/sbin/"$_file_name")
	echo "" >> $DOCKER_IMAGES_HOME/sbin/dockerup
	echo "function $_function_name () { " >> $DOCKER_IMAGES_HOME/sbin/dockerup
	echo "$_content" | grep -v '^#' | awk '{printf ("   %s\n", $0) }' >> $DOCKER_IMAGES_HOME/sbin/dockerup
	echo '} ' >> $DOCKER_IMAGES_HOME/sbin/dockerup
}

merge cecho
merge cn_name
merge im_exists
merge cn_run
merge cn_config
merge cn_update
merge im_build
merge im_name
merge im_expose
merge yaml
merge dockerup.sh

echo '' >> $DOCKER_IMAGES_HOME/sbin/dockerup
echo "export -f yaml" >> $DOCKER_IMAGES_HOME/sbin/dockerup

echo '' >> $DOCKER_IMAGES_HOME/sbin/dockerup
echo 'dockerup' >> $DOCKER_IMAGES_HOME/sbin/dockerup
echo '' >> $DOCKER_IMAGES_HOME/sbin/dockerup
echo '' >> $DOCKER_IMAGES_HOME/sbin/dockerup
echo '' >> $DOCKER_IMAGES_HOME/sbin/dockerup

chmod +x dockerup


#lns.sh r
