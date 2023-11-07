#!/bin/bash

# exit script if return code != 0
set -e

# github releases
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
