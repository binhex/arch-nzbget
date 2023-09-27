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
rcurl.sh -o "/tmp/${package_name}" "https://github.com/binhex/packages/raw/master/compiled/${TARGETARCH}/${package_name}"
pacman -U "/tmp/${package_name}" --noconfirm

# install specific version of unrar (5.6.3 - last known working version) to try and prevent 'stuck' operation on unpack
package_name="unrar.tar.xz"
rcurl.sh -o "/tmp/${package_name}" "https://github.com/binhex/packages/raw/master/compiled/${TARGETARCH}/${package_name}"
pacman -U "/tmp/${package_name}" --noconfirm

# openssl 1.0.x will fail the connection when it detects the expired certificate, replace with updated pem
# see https://github.com/nzbget/nzbget/issues/784#issuecomment-931609658
rcurl.sh -o "/usr/local/bin/nzbget/cacert.pem" -L "https://nzbget.net/info/cacert.pem"
