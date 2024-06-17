# ublue

This repository contains my personal attempt at a Universal Blue custom image.

## Installation

1. Initial installation should be done using the Aurora ISO found [here](https://getaurora.dev).

2. After first boot, rebase to the unsigned image in order to get the proper signing keys and policies, then reboot.

   ```bash
   rpm-ostree rebase ostree-unverified-registry:ghcr.io/joshuadavidthomas/ublue:latest
   systemctl reboot
   ```

3. After rebooting, rebase to the signed image and reboot to complete the installation.

   ```bash
   rpm-ostree rebase ostree-image-signed:docker://ghcr.io/joshuadavidthomas/ublue:latest
   systemctl reboot
   ```
