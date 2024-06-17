#!/bin/bash

set -ouex pipefail

curl -Lo /etc/yum.repos.d/wezterm-nightly.repo https://copr.fedorainfracloud.org/coprs/wezfurlong/wezterm-nightly/repo/fedora-"${FEDORA_MAJOR_VERSION}"/wezfurlong-wezterm-nightly-fedora-"${FEDORA_MAJOR_VERSION}".repo

sed -i 's@enabled=0@enabled=1@g' /etc/yum.repos.d/1password.repo
sed -i 's@enabled=0@enabled=1@g' /etc/yum.repos.d/vivaldi.repo
sed -i 's@enabled=0@enabled=1@g' /etc/yum.repos.d/wezterm-nightly.repo

rpm-ostree install 1password
echo 'hello after 1pass'
rpm-ostree install 1password-cli
echo 'hello after op'
rpm-ostree install vivaldi
echo 'hello after vivaldi'
rpm-ostree install wezterm
echo 'hello after wezterm'

sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/1password.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/vivaldi.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/wezterm-nightly.repo

echo 'HELLOOOOOOOOOOOO'
