#!/bin/bash

# exit script if return code != 0
set -e

# github releases
####

install_path="/usr/local/bin/nzbget"
download_filename="nzbget.*bin-linux.run"

# download nzbget binary installer
github.sh -df "${download_filename}" -da "${download_filename}" -dp "/tmp" -ep "" -ip "${install_path}" -go "nzbget" -gr "nzbget" -rt "binary"

# run installer to install nzbget and dependencies
cd "${install_path}" && ./nzbget*bin-linux.run --arch x86_64 --destdir .

# remove installer
rm -f "${install_path}"/nzbget*bin-linux.run

# remove statically built unrar as it looks buggy, see here https://forum.nzbget.net/viewtopic.php?f=3&t=3237
rm -f /usr/local/bin/nzbget/unrar

# install specific version of libunrar (5.6.3 - last known working version) to try and prevent 'stuck' operation on unpack
package_name="libunrar.tar.xz"
curly.sh -rc 6 -rw 10 -of "/tmp/${package_name}" -url "https://github.com/binhex/arch-packages/raw/master/compiled/${OS_ARCH}/${package_name}"
pacman -U "/tmp/${package_name}" --noconfirm

# install specific version of unrar (5.6.3 - last known working version) to try and prevent 'stuck' operation on unpack
package_name="unrar.tar.xz"
curly.sh -rc 6 -rw 10 -of "/tmp/${package_name}" -url "https://github.com/binhex/arch-packages/raw/master/compiled/${OS_ARCH}/${package_name}"
pacman -U "/tmp/${package_name}" --noconfirm
