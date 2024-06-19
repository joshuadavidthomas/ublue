#!/bin/bash

set -ouex pipefail

curl -Lo /etc/yum.repos.d/keyd.repo https://copr.fedorainfracloud.org/coprs/alternateved/keyd/repo/fedora-"${FEDORA_MAJOR_VERSION}"/alternateved-keyd-fedora-"${FEDORA_MAJOR_VERSION}".repo
curl -Lo /etc/yum.repos.d/wezterm-nightly.repo https://copr.fedorainfracloud.org/coprs/wezfurlong/wezterm-nightly/repo/fedora-"${FEDORA_MAJOR_VERSION}"/wezfurlong-wezterm-nightly-fedora-"${FEDORA_MAJOR_VERSION}".repo

sed -i 's@enabled=0@enabled=1@g' /etc/yum.repos.d/keyd.repo
sed -i 's@enabled=0@enabled=1@g' /etc/yum.repos.d/wezterm-nightly.repo

# NOTES:
# - zlib-ng-compat & zlib-ng-compat-devel:
#   needed for python installation on Fedora 40
#   https://fedoraproject.org/wiki/Changes/ZlibNGTransition
rpm-ostree install \
        keyd \
        wezterm \
        zlib-ng-compat \
        zlib-ng-compat-devel

systemctl enable keyd

sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/keyd.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/wezterm-nightly.repo
