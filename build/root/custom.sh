#!/bin/bash

# exit script if return code != 0
set -e

# github releases
####

# download nzbget binary installer
github.sh --install-path "/usr/local/bin/nzbget" --github-owner "nzbget" --github-repo "nzbget" --download-assets "nzbget.*bin-linux.run" --compile-src 'chmod +x nzbget*bin-linux.run && ./nzbget*bin-linux.run --arch x86_64 --destdir .'

# remove installer
rm -f "/usr/local/bin/nzbget/nzbget*bin-linux.run"

# remove statically built unrar as it looks buggy, see here https://forum.nzbget.net/viewtopic.php?f=3&t=3237
rm -f /usr/local/bin/nzbget/unrar

# install specific version of libunrar (5.6.3 - last known working version) to try and prevent 'stuck' operation on unpack
package_name="libunrar.tar.xz"
rcurl.sh -o "/tmp/${package_name}" "https://github.com/binhex/arch-packages/raw/master/compiled/${OS_ARCH}/${package_name}"
pacman -U "/tmp/${package_name}" --noconfirm

# install specific version of unrar (5.6.3 - last known working version) to try and prevent 'stuck' operation on unpack
package_name="unrar.tar.xz"
rcurl.sh -o "/tmp/${package_name}" "https://github.com/binhex/arch-packages/raw/master/compiled/${OS_ARCH}/${package_name}"
pacman -U "/tmp/${package_name}" --noconfirm
