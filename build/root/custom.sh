#!/bin/bash

# exit script if return code != 0
set -e

install_path="/usr/local/bin/nzbget"
download_filename="nzbget.*bin-linux.run"

# github releases
####

# download nzbget binary installer
/root/github.sh -df "${download_filename}" -dp "/tmp" -ep "" -ip "${install_path}" -go "nzbget" -gr "nzbget" -rt "binary"

# run installer to install nzbget and dependencies
"${install_path}"'/nzbget*bin-linux.run'
