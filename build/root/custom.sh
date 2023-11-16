#!/bin/bash

# exit script if return code != 0
set -e

# nzbget compile
####

# create location to store clone source
mkdir -p /tmp/src/nzbget

# clone from default branch (currently develop)
git clone https://github.com/nzbget-ng/nzbget /tmp/src/nzbget

# cd to clone location
cd /tmp/src/nzbget

# run make to compile from source
make

# install from compiled source
make install

# copy cert from nzbget to fix tls issues - see https://github.com/nzbget/nzbget/issues/784#issuecomment-931609658
curl -o '/usr/local/share/nzbget/cacert.pem' -L https://nzbget.net/info/cacert.pem

# define path to webdir and config template
app_path='/usr/local/share/nzbget'

# define path to config file copied to /config
config_filepath="${app_path}/nzbget.conf"

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

# unrar compile
####

# compile unrar from source to attempt unpack hang fix
# note src 6.2.13 equates to '6.24'
# note src 7.0.3 equates to '7.00 beta 1 version'
cd /tmp
#curl -o unrar.tar.gz -L https://www.rarlab.com/rar/unrarsrc-6.2.12.tar.gz
curl -o unrar.tar.gz -L https://www.rarlab.com/rar/unrarsrc-7.0.3.tar.gz
# backup pre-compiled unrar from ich777
#https://github.com/ich777/unrar/releases/download/7.0.3/rar-v7.0.3.tar.gz
tar -xvf unrar.tar.gz
cd unrar
make -f makefile
cp ./unrar /usr/bin/
