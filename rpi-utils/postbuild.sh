# shellcheck shell=bash
# shellcheck disable=SC2154
# rpi-utils: post-build script, sourced by runpostbuild.sh (cwd: ${PKG_BLDPATH}, set -ex).
# Every ALL_CAPS variable visible to package.env is available here as ${VAR}.

### The mailbox device of the firmware belongs to root alone: 99-com.rules of raspberrypi-sys-mods
### covers the input, i2c, spi and gpio devices but not this one. The rule of the recipe gives it to
### the video group the way Raspberry Pi OS does, so vcgencmd, vcmailbox and vclog work for a user of
### that group and not only for root
install -v -D -m644 "${PKG_RECIPEPATH}/files/60-rpi-utils.rules" \
	"${PKG_PKGPATH}${INSTALL_LIBDIR}/udev/rules.d/60-rpi-utils.rules"
