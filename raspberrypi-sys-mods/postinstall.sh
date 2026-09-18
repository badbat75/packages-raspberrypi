# shellcheck shell=bash
# shellcheck disable=SC2154
# raspberrypi-sys-mods: post-install script, sourced as root inside the target chroot.
# Every ALL_CAPS variable visible to package.env is available here as ${VAR}.

groupadd --system i2c
groupadd --system spi
groupadd --system gpio
### apply_noobs_os_config.service is gone from the sources (only the udev rule of NOOBS is left): a unit
### systemctl does not find makes the whole disable fail
systemctl disable regenerate_ssh_host_keys.service
