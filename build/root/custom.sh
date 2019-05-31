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
cd "${install_path}" && ./nzbget*bin-linux.run --arch x86_64 --destdir .

# remove installer
rm -f "${install_path}"/nzbget*bin-linux.run

# remove statically built unrar as it looks buggy, see here https://forum.nzbget.net/viewtopic.php?f=3&t=3237
rm -f /usr/local/bin/nzbget/unrar