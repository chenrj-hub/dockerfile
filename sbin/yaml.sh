#/usr/bin/env bash

# dependency
# apt-get install ruby

hashdot=$(gem list hash_dot);
if ! [ "$hashdot" != "" ]; then sudo gem install "hash_dot" ; fi
if [ -f $1 ];then
    cmd=" Hash.use_dot_syntax = true; hash = YAML.load(File.read('$1'));";
    if [ "$2" != "" ] ;then 
        cmd="$cmd puts hash.$2;"
    else
        cmd="$cmd puts hash;"
    fi
    ruby -r yaml -r hash_dot <<< $cmd;
else 
   cecho r "[$1] not exists!"
fi

