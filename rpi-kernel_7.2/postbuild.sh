# shellcheck shell=bash
# shellcheck disable=SC2154
# rpi-kernel_7.2: post-build script, sourced by runpostbuild.sh (cwd: ${PKG_BLDPATH}, the kernel tree, set -ex).
# Every ALL_CAPS variable visible to package.env is available here as ${VAR}.

### The initramfs is part of the package (PKG_KERNEL_INITRAMFS=1), made by the dracut of the sysroot on
### the build host (dracut-sysroot of lfs/dracut:native). dracut takes the kernel modules from the
### sysroot, so the ones of this build go there first (the package installs them there anyway)
if [ "${PKG_KERNEL_INITRAMFS:-0}" -eq 1 ]
then
	KERNEL_RELEASE=$(cat include/config/kernel.release)
	mkdir -pv "${BIN_PATH}/lib/modules/${KERNEL_RELEASE}"
	rsync -a --delete "${PKG_PKGPATH}/lib/modules/${KERNEL_RELEASE}/" "${BIN_PATH}/lib/modules/${KERNEL_RELEASE}/"
	DRACUT_ARCH=${HM} "${GLOBAL_TOOLCHAIN_PATH}/bin/dracut-sysroot" "${BIN_PATH}" "${KERNEL_RELEASE}" \
		"${PKG_PKGPATH}/boot/initramfs-${KERNEL_RELEASE}.img" --tmpdir "${PKG_BLDPATH}" \
		-N -a drm --fstab --zstd --filesystems "${PKG_KERNEL_INITRAMFS_DRIVERS:-ext4}"
	### The post install script that made it inside the image, left in the sysroot by earlier builds
	rm -fv "${BIN_PATH}/postinst_scripts/99_kernel"
fi

### The boot partition is /boot/firmware, as on Raspberry Pi OS: /boot keeps vmlinuz-<release>,
### System.map-<release>, config-<release> and initramfs-<release>.img of kernelbuild and dracut, the
### firmware reads copies of the kernel and of the initramfs under its own names (KERNEL_NAME of the
### platform, kernel8.img, and the initramfs auto_initramfs=1 of config.txt looks for next to it,
### initramfs8), and the device trees and overlays/ (emulator_cmdgen QEMU_DTB from ${BIN_PATH}/boot, the
### overlays next to it). dtbs_install of arm64 puts the device trees in the directory of the vendor,
### broadcom/: the firmware wants them in the root of the partition. A FAT file system: copies, no links
KERNEL_RELEASE=$(cat include/config/kernel.release)
FIRMWARE_PATH=${PKG_PKGPATH}/boot/firmware
mkdir -pv "${FIRMWARE_PATH}"
cp -v "${PKG_PKGPATH}/boot/vmlinuz-${KERNEL_RELEASE}" "${FIRMWARE_PATH}/${KERNEL_NAME}"
if [ -f "${PKG_PKGPATH}/boot/initramfs-${KERNEL_RELEASE}.img" ]
then
	FIRMWARE_INITRAMFS=${KERNEL_NAME%.img}
	cp -v "${PKG_PKGPATH}/boot/initramfs-${KERNEL_RELEASE}.img" "${FIRMWARE_PATH}/${FIRMWARE_INITRAMFS/kernel/initramfs}"
fi
### The device trees of the boards only: overlays/ has its own (overlay_map.dtb, hat_map.dtb)
find "${PKG_PKGPATH}/boot" "${PKG_PKGPATH}/boot/broadcom" -maxdepth 1 -name '*.dtb' -exec mv -vt "${FIRMWARE_PATH}/" {} + 2>/dev/null || true
rmdir -v "${PKG_PKGPATH}/boot/broadcom" 2>/dev/null || true
mv -v "${PKG_PKGPATH}/boot/overlays" "${FIRMWARE_PATH}/"
### optimize-initramfs.sh of lfs/lfs-utils makes the initramfs of /boot again on the board: this hook
### refreshes the copy the firmware reads
install -v -D -m755 "${PKG_RECIPEPATH}/files/rpi-firmware-initramfs" "${PKG_PKGPATH}/etc/initramfs/post-update.d/rpi-firmware-initramfs"
