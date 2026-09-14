# rpi-kernel_6.12
PKG_SUFFIX=.1
PKG_URL="https://github.com/raspberrypi/linux/archive/614fa9b0b1a21c0cc320b9915393bdaa31357de9.tar.gz"
PKG_DEPS="lfs/bison:native lfs/flex:native lfs/elfutils:cross"
BUILD_PROCESS=kernelbuild
PKG_MAKEVARS="INSTALL_MOD_STRIP=1"
CONF_FLAGS="-d WERROR"
CONF_FLAGS+=" -d DEBUG_INFO_BTF"
### To enable systemd oom support
CONF_FLAGS+=" -e MEMCG -e PSI"
### To enable systemd iptables support
CONF_FLAGS+=" -e BPF_SYSCALL -e CGROUP_BPF"
### To enable BFQ scheduler
CONF_FLAGS+=" -e IOSCHED_BFQ -e BFQ_GROUP_IOSCHED"
### To enable needed Filesystems
PKG_KERNEL_INITRAMFS=${WITH_INITRAMFS:-0}
case ${PKG_KERNEL_INITRAMFS} in
	1)
		PKG_DEPS+=" lfs/dracut"
		PKG_KERNEL_INITRAMFS_DRIVERS="${WITH_KERNEL_FS}"
		for filesystem in ${PKG_KERNEL_INITRAMFS_DRIVERS}
		do
			case ${filesystem} in
				ext4)  CONF_FLAGS+=" -m EXT4_FS -e EXT4_USE_FOR_EXT2 -e EXT4_FS_POSIX_ACL -e EXT4_FS_SECURITY" ;;
				xfs)   CONF_FLAGS+=" -m XFS_FS -e XFS_QUOTA -e XFS_POSIX_ACL -e XFS_RT" ;;
				btrfs) CONF_FLAGS+=" -m BTRFS_FS -e BTRFS_FS_POSIX_ACL" ;;
				f2fs)  CONF_FLAGS+=" -m F2FS_FS -e F2FS_CHECK_FS -e F2FS_FAULT_INJECTION -e F2FS_FS_SECURITY -e F2FS_FS_COMPRESSION" ;;
			esac
		done
	;;
	0)
		PKG_KERNEL_INITRAMFS_DRIVERS="${WITH_KERNEL_FS}"
		for filesystem in ${PKG_KERNEL_INITRAMFS_DRIVERS}
		do
			case ${filesystem} in
				ext4)  CONF_FLAGS+=" -e EXT4_FS -e EXT4_USE_FOR_EXT2 -e EXT4_FS_POSIX_ACL -e EXT4_FS_SECURITY" ;;
				xfs)   CONF_FLAGS+=" -e XFS_FS -e XFS_QUOTA -e XFS_POSIX_ACL -e XFS_RT" ;;
				btrfs) CONF_FLAGS+=" -e BTRFS_FS -e BTRFS_FS_POSIX_ACL" ;;
				f2fs)  CONF_FLAGS+=" -e F2FS_FS -e F2FS_CHECK_FS -e F2FS_FAULT_INJECTION -e F2FS_FS_SECURITY -e F2FS_FS_COMPRESSION" ;;
			esac
		done
	;;
esac

case ${WITH_RT:-0} in
	yes|1)
	# Enable preemptive/realtime kernel
		CONF_FLAGS+=" -d PREEMPT_NONE -d PREEMPT_VOLUNTARY -e PREEMPT"
	;;
esac

case ${KERNEL_ARCH:-none} in
	arm)
		PKG_PREBUILD="sed -i '/select TRACE_IRQFLAGS_SUPPORT if/a \        select ARCH_SUPPORTS_LTO_CLANG \n        select ARCH_SUPPORTS_LTO_CLANG_THIN' arch/arm/Kconfig"
		;;
	arm64)
		PKG_POSTBUILD+="
			for p in broadcom
			do
				if [ -d \${PKG_PKGPATH}/boot/\${p} ]
				then
					mv -f \${PKG_PKGPATH}/boot/\${p}/* \${PKG_PKGPATH}/boot/
					rmdir \${PKG_PKGPATH}/boot/\${p}
				fi
			done"
		;;
esac
case ${PKG_TOOLCHAIN:-${TOOLCHAIN}} in
	gnu) PKG_OVERRIDELD=bfd;;
	llvm) PKG_MAKEVARS=LLVM_IAS=0;;
esac

# LLVM fails to build ARM binaries if using integrater Assembler. Disabled it to override this issue.