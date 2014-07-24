#!/bin/bash

# check if nzbget.conf exists, if not copy sample config
if [ -f /config/nzbget.conf ]; then

	echo "nzbget.conf exists"
	
else

	# set maindir to /data folder for downloads
	RUN sed -i 's/MainDir=~\/downloads/MainDir=\/data/g' /usr/share/nzbget/nzbget.conf
	
	# copy to /config and set owner
	cp /usr/share/nzbget/nzbget.conf /config/
	chown nobody:users /config/nzbget.conf
	
fi
