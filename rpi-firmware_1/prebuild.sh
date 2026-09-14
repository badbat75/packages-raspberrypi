# shellcheck shell=bash
# shellcheck disable=SC2154
# rpi-firmware_1: pre-build script, sourced by runprebuild.sh (cwd: ${PKG_SRCPATH}, set -x, no -e).
# Every ALL_CAPS variable visible to package.env is available here as ${VAR}.

mkdir -pv ${PKG_PKGPATH}/boot
	cp -fv boot/{bootcode.bin,fixup4cd.dat,fixup4.dat,fixup4db.dat,fixup4x.dat,fixup_cd.dat,fixup.dat,fixup_db.dat,fixup_x.dat,\
LICENCE.broadcom,start4cd.elf,start4db.elf,start4.elf,start4x.elf,start_cd.elf,start_db.elf,start.elf,start_x.elf} ${PKG_PKGPATH}/boot
