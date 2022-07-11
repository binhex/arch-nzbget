#!/usr/bin/dumb-init /bin/bash

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

# Due to the change in install location (AOR to NZBGet installer) we need to patch the NZBGet configuration file
echo "[info] Patching NZBGet config file for WebDir and ConfigTemplate locations..."
sed -i -e 's~WebDir=/usr/share/nzbget/webui~WebDir=${AppDir}/webui~g' /config/nzbget.conf
sed -i -e 's~ConfigTemplate=/usr/share/nzbget/nzbget.conf~ConfigTemplate=${AppDir}/nzbget.conf~g' /config/nzbget.conf

# start nzbget non-daemonised and specify config file (close stdout due to chatter)
/usr/local/bin/nzbget/nzbget --option UnrarCmd=/usr/bin/unrar -c /config/nzbget.conf -s 1>&-