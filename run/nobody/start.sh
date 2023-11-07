#!/usr/bin/dumb-init /bin/bash

# define path to webdir and config template
app_path='/usr/local/share/nzbget'

# define path to config file copied to /config
config_filepath='/config/nzbget.conf'

# check if nzbget.conf exists, if not copy default config
if [[ -f /config/nzbget.conf ]]; then

	echo "[info] NZBGet configuration file exists"

else

	echo "[info] NZBGet configuration does not exist, copying default configuration file to /config/..."

	# copy to /config
	cp "${app_path}/nzbget.conf" /config/

	# set maindir to /data folder for downloads
	sed -i 's~^MainDir=.*~MainDir=/data~g' "${config_filepath}"

fi

# <snip> TODO remove this after nov 2024
echo "[info] Patching NZBGet-NG config file for existing users..."

# set web path baed off app path
sed -i -e "s~^WebDir=.*~WebDir=${app_path}/webui~g" "${config_filepath}"

# set config template path based off app path
sed -i -e "s~^ConfigTemplate=.*~ConfigTemplate=${app_path}/nzbget.conf~g" "${config_filepath}"

# set cert store path based off app path
sed -i -e "s~^CertStore=.*~CertStore=${app_path}/cacert.pem~g" "${config_filepath}"
# </snip>

echo "[info] Starting NZBGet non-daemonised and specify config file (close stdout due to chatter)..."
/usr/local/bin/nzbget --option UnrarCmd=/usr/sbin/unrar -c "${config_filepath}" -s 1>&-