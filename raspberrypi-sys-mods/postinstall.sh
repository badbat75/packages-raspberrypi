# shellcheck shell=bash
# shellcheck disable=SC2154
# raspberrypi-sys-mods: post-install script, sourced as root inside the target chroot.
# Every ALL_CAPS variable visible to package.env is available here as ${VAR}.

groupadd --system i2c
groupadd --system spi
groupadd --system gpio
systemctl disable regenerate_ssh_host_keys.service apply_noobs_os_config
