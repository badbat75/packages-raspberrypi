# shellcheck shell=bash
# shellcheck disable=SC2154
# rpi-kernel_7.2: pre-build script, sourced by runprebuild.sh (cwd: ${PKG_SRCPATH}, set -x, no -e).
# Every ALL_CAPS variable visible to package.env is available here as ${VAR}.

case ${KERNEL_ARCH:-none} in
	arm)
		sed -i '/select TRACE_IRQFLAGS_SUPPORT if/a \        select ARCH_SUPPORTS_LTO_CLANG \n        select ARCH_SUPPORTS_LTO_CLANG_THIN' arch/arm/Kconfig
	;;
esac
