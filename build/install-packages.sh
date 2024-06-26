#!/bin/bash

set -ouex pipefail

# NOTES:
# - for pyenv, not sure why this is needed? when i use aurora-dx
#   directly it works fine, but creating my own image inheriting from
#   it doesn't?
# - zlib-ng-compat & zlib-ng-compat-devel:
#   needed for python installation on Fedora 40
#   https://fedoraproject.org/wiki/Changes/ZlibNGTransition
rpm-ostree install \
        bzip2 \
        bzip2-devel \
        gcc \
        gdbm-libs \
        libffi-devel \
        libnsl2 \
        libuuid-devel \
        make \
        openssl-devel \
        patch \
        readline-devel \
        sqlite \
        sqlite-devel \
        tk-devel \
        zlib-ng-compat \
        zlib-ng-compat-devel \
        xz-devel

curl -Lo /etc/yum.repos.d/keyd.repo https://copr.fedorainfracloud.org/coprs/alternateved/keyd/repo/fedora-"${FEDORA_MAJOR_VERSION}"/alternateved-keyd-fedora-"${FEDORA_MAJOR_VERSION}".repo
curl -Lo /etc/yum.repos.d/wezterm-nightly.repo https://copr.fedorainfracloud.org/coprs/wezfurlong/wezterm-nightly/repo/fedora-"${FEDORA_MAJOR_VERSION}"/wezfurlong-wezterm-nightly-fedora-"${FEDORA_MAJOR_VERSION}".repo
curl -Lo /etc/yum.repos.d/yadm.repo https://download.opensuse.org/repositories/home:TheLocehiliosan:yadm/Fedora_"${FEDORA_MAJOR_VERSION}"/home:TheLocehiliosan:yadm.repo

sed -i 's@enabled=0@enabled=1@g' /etc/yum.repos.d/keyd.repo
sed -i 's@enabled=0@enabled=1@g' /etc/yum.repos.d/wezterm-nightly.repo
sed -i 's@enabled=0@enabled=1@g' /etc/yum.repos.d/yadm.repo

rpm-ostree install \
        keyd \
        wezterm \
        yadm

systemctl enable keyd

sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/keyd.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/wezterm-nightly.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/yadm.repo

curl -Lo /tmp/vivaldi.rpm https://downloads.vivaldi.com/stable/vivaldi-stable-6.8.3381.46-1.x86_64.rpm
rpm -Uvh /tmp/vivaldi.rpm
