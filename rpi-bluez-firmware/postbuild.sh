# shellcheck shell=bash
# shellcheck disable=SC2154
# rpi-bluez-firmware: post-build script, sourced by runpostbuild.sh (cwd: ${PKG_BLDPATH}, set -ex).
# Every ALL_CAPS variable visible to package.env is available here as ${VAR}.

### make install only installs the Debian bluez-firmware (BCM203x, STLC2500). The patch files of the
### Raspberry Pi Bluetooth chips are in debian/firmware, installed by debian/rules: without them the
### kernel logged "BCM: firmware Patch file not found", the Pi 3 BCM43430 kept its ROM firmware and
### the UART kept logging "Frame reassembly failed"
install -v -d -m755 ${PKG_PKGPATH}/lib/firmware/brcm ${PKG_PKGPATH}/lib/firmware/synaptics
install -v -m644 ${PKG_SRCPATH}/debian/firmware/broadcom/*.hcd ${PKG_PKGPATH}/lib/firmware/brcm/
install -v -m644 ${PKG_SRCPATH}/debian/firmware/synaptics/*.hcd ${PKG_PKGPATH}/lib/firmware/synaptics/
### The board names the kernel tries first (brcm/BCM43430A1.raspberrypi,3-model-b.hcd) are the
### links of debian/bluez-firmware.links: /usr/lib/firmware there, /lib/firmware here (--libdir=/lib)
while read -r FW_TARGET FW_LINK
do
	if [ -n "${FW_LINK}" ]
	then
		ln -svfr ${PKG_PKGPATH}/lib/${FW_TARGET#/usr/lib/} ${PKG_PKGPATH}/lib/${FW_LINK#/usr/lib/}
	fi
done < ${PKG_SRCPATH}/debian/bluez-firmware.links
