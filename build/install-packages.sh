#!/bin/bash

set -ouex pipefail

# curl -Lo /etc/pki/rpm-gpg/1password.asc https://downloads.1password.com/linux/keys/1password.asc
curl -Lo /etc/pki/rpm-gpg/RPM-GPG-KEY-vivaldi https://repo.vivaldi.com/archive/linux_signing_key.pub
curl -Lo /etc/yum.repos.d/wezterm-nightly.repo https://copr.fedorainfracloud.org/coprs/wezfurlong/wezterm-nightly/repo/fedora-"${FEDORA_MAJOR_VERSION}"/wezfurlong-wezterm-nightly-fedora-"${FEDORA_MAJOR_VERSION}".repo

# sed -i 's@enabled=0@enabled=1@g' /etc/yum.repos.d/1password.repo
sed -i 's@enabled=0@enabled=1@g' /etc/yum.repos.d/vivaldi.repo
sed -i 's@enabled=0@enabled=1@g' /etc/yum.repos.d/wezterm-nightly.repo

# rpm-ostree install 1password
# rpm-ostree install 1password-cli
# NOTES:
# - zlib-ng-compat & zlib-ng-compat-devel:
#   needed for python installation on Fedora 40
#   https://fedoraproject.org/wiki/Changes/ZlibNGTransition
rpm-ostree install \
        vivaldi \
        wezterm \
        zlib-ng-compat \
        zlib-ng-compat-devel

# sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/1password.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/vivaldi.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/wezterm-nightly.repo
