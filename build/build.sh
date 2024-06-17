#!/bin/bash

set -ouex pipefail

. /tmp/build/install-packages.sh

echo "HELLOOOOO FROM BUILD"

ls /etc/yum.repos.d/
