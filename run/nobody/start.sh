#!/bin/bash

# check if nzbget.conf exists, if not copy default config
if [[ -f /config/nzbget.conf ]]; then

	echo "[info] NZBGet configuration file exists"

else

	echo "[info] NZBGet configuration does not exist, copying default configuration file to /config/..."

	# copy to /config
	cp /usr/local/bin/nzbget/nzbget.conf /config/

	# set maindir to /data folder for downloads
	sed -i 's/MainDir=~\/downloads/MainDir=\/data/g' /config/nzbget.conf

fi

# Due to the change in install location we need to patch the NZBGet configuration
# file for the WebDir - triggered by switch from AOR package to NZBGet GitHub installer
echo "[info] Patching NZBGet config file for WebDir location..."
sed -i -e 's~WebDir=/usr/share/webui~WebDir=${AppDir}/webui~g' /config/nzbget.conf

# need to create dst folder as its not auto generated (used to store nzb logs)
mkdir -p /data/dst

# start nzbget non-daemonised and specify config file (close stdout due to chatter)
/usr/local/bin/nzbget/nzbget -c /config/nzbget.conf -s 1>&-