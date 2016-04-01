#!/bin/bash 

CACHEDIR=$HOME
CACHENAME=.git-update.cache
CACHEHISTORY=.git-update-loc.cache
EXPWD=$PWD

# XXX support for removing cachefiles.
if [ $1 ]
then
	CACHEDIR=$1
fi

echo "---"
for dir in $(find . -name ".git")
do cd ${dir%/*}
	echo $PWD
	git pull
	echo ""
	cd - > /dev/null
done
