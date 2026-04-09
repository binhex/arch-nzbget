#!/bin/bash

# exit script if return code != 0
set -e

# github releases
####

# define path to download nzbget installer
download_path='/usr/local/share'

# define path to installed app
app_path="${download_path}/nzbget"

# define path to config file copied to /config
config_filepath="${app_path}/nzbget.conf"

# create location to store downloaded installer
mkdir -p "${download_path}" & cd "${download_path}"

# download github release binary
gh.sh --github-owner nzbgetcom --github-repo nzbget --download-type release --release-type binary --download-path /tmp --asset-regex 'nzbget.*-bin-linux.run'

# run downloaded nzbget installer and then delete
chmod +x /tmp/nzbget*-bin-linux.run && /tmp/nzbget*-bin-linux.run && rm -f /tmp/nzbget*-bin-linux.run

# copy mozzilla root CA certs in pem format, required for nzbget
curl -o "${app_path}/cacert.pem" -L https://curl.se/ca/cacert.pem

# set maindir to /data folder for downloads
sed -i -e 's~^MainDir=.*~MainDir=/data~g' "${config_filepath}"

# set web path baed off app path
sed -i -e "s~^WebDir=.*~WebDir=${app_path}/webui~g" "${config_filepath}"

# set config template path based off app path
sed -i -e "s~^ConfigTemplate=.*~ConfigTemplate=${app_path}/nzbget.conf~g" "${config_filepath}"

# set cert store path based off app path
sed -i -e "s~^CertStore=.*~CertStore=${app_path}/cacert.pem~g" "${config_filepath}"

# disable update check as we are running from dev branch right now
sed -i -e "s~^UpdateCheck=.*~UpdateCheck=none~g" "${config_filepath}"
