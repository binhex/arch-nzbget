#!/bin/bash

# check if nzbget.conf exists, if not copy sample config
if [[ -f /config/nzbget.conf ]]; then

	echo "nzbget.conf exists"
	
else

	# set maindir to /data folder for downloads
	sed -i 's/MainDir=~\/downloads/MainDir=\/data/g' /usr/share/nzbget/nzbget.conf
	
	# copy to /config
	cp /usr/share/nzbget/nzbget.conf /config/
	
fi

#run nzbget specifying config path
/usr/bin/nzbget -s -c /config/nzbget.conf