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

# FIXME check for timestamps rather than existence of cachefile.
if ! [ -f $CACHEDIR/$CACHENAME ]
then
	for dir in $(find . -name ".git")
	do
		echo ${dir%/*} >> $CACHEDIR/$CACHENAME
	done
	# FIXME breaks when script is executed again from parent dir.
	echo "Created $CACHEDIR/$CACHENAME" >> $HOME/$CACHEHISTORY
fi

echo "Using $CACHEDIR/$CACHENAME"
echo "---"

for dir in $(cat $CACHEDIR/$CACHENAME)
do
	cd $dir
	echo $PWD
	git pull
	echo ""
	cd - > /dev/null
done
cd $EXPWD
