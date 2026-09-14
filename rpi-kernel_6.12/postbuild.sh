# shellcheck shell=bash
# shellcheck disable=SC2154
# rpi-kernel_6.12: post-build script, sourced by runpostbuild.sh (cwd: ${PKG_BLDPATH}, set -ex).
# Every ALL_CAPS variable visible to package.env is available here as ${VAR}.

case ${KERNEL_ARCH:-none} in
	arm64)
		for BOOTDIR in broadcom
		do
			if [ -d ${PKG_PKGPATH}/boot/${BOOTDIR} ]
			then
				mv -f ${PKG_PKGPATH}/boot/${BOOTDIR}/* ${PKG_PKGPATH}/boot/
				rmdir ${PKG_PKGPATH}/boot/${BOOTDIR}
			fi
		done
	;;
esac
