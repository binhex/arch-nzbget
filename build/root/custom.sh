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

# this command uses github cli (gh) to downlad the latest release from nzbgetcom/nzbget
# the 'GH_HOST' and '-R' options allow for non authenticated downloads from public repositories
# which maybe actually a bug, as 'gh' currently enforces authentication, even for public repos
# see the following issue for details https://github.com/cli/cli/issues/2680#issuecomment-1345491083
GH_HOST='public-auth-workaround' gh release download -R github.com/nzbgetcom/nzbget -p nzbget*-bin-linux.run

# run downloaded nzbget installer and then delete
chmod +x ./nzbget*-bin-linux.run && ./nzbget*-bin-linux.run && rm -f ./nzbget*-bin-linux.run

# copy cert from nzbget to fix tls issues - see https://github.com/nzbget/nzbget/issues/784#issuecomment-931609658
curl -o "${app_path}/cacert.pem" -L https://nzbget.net/info/cacert.pem

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
