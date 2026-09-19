# shellcheck shell=bash
# shellcheck disable=SC2154
# raspberrypi-sys-mods: pre-build script, sourced by runprebuild.sh (cwd: ${PKG_SRCPATH}, set -x, no -e).
# Every ALL_CAPS variable visible to package.env is available here as ${VAR}.

install -d -m755 ${PKG_PKGPATH}/etc/udev/rules.d
    install -m644 etc.armhf/udev/rules.d/99-com.rules ${PKG_PKGPATH}/etc/udev/rules.d/
    ### The helpers the units and the udev rules run (sshswitch, get_fw_loc, i2cprobe, imager_custom).
    ### sshswitch enables ssh, the unit of Debian: the one of lfs/openssh is sshd
    install -v -d -m755 ${PKG_PKGPATH}/usr/lib/raspberrypi-sys-mods
    install -v -m755 usr/lib/raspberrypi-sys-mods/* ${PKG_PKGPATH}/usr/lib/raspberrypi-sys-mods/
    sed -i 's/systemctl enable --now --no-block ssh$/systemctl enable --now --no-block sshd/' ${PKG_PKGPATH}/usr/lib/raspberrypi-sys-mods/sshswitch
    install -d -m755 ${PKG_PKGPATH}/lib/systemd/system
    install -v -D -m644 debian/raspberrypi-sys-mods.regenerate_ssh_host_keys.service ${PKG_PKGPATH}/lib/systemd/system/regenerate_ssh_host_keys.service
    install -v -D -m644 debian/raspberrypi-sys-mods.sshswitch.service ${PKG_PKGPATH}/lib/systemd/system/sshswitch.service
    install -d -m755 ${PKG_PKGPATH}/etc/systemd/system/multi-user.target.wants
    ln -s /lib/systemd/system/regenerate_ssh_host_keys.service ${PKG_PKGPATH}/etc/systemd/system/multi-user.target.wants/regenerate_ssh_host_keys.service
    ln -s /lib/systemd/system/sshswitch.service ${PKG_PKGPATH}/etc/systemd/system/multi-user.target.wants/sshswitch.service
    ### The module options of the board (SYSMODS_MODPROBE_CONF, set by the platform variants). The
    ### etc/modprobe.d/rfkill_default.conf of the sources stays out: it blocks the radios until raspi-config sets a country
    for MODPROBE_CONF in ${SYSMODS_MODPROBE_CONF}
    do
        install -v -D -m644 ${PKG_RECIPEPATH}/files/${MODPROBE_CONF} ${PKG_PKGPATH}/usr/lib/modprobe.d/${MODPROBE_CONF}
    done
    #install -d -m755 ${PKG_PKGPATH}/etc/sudoers.d
    #echo 'pi ALL=(ALL) NOPASSWD: ALL' > ${PKG_PKGPATH}/etc/sudoers.d/010_pi-nopasswd
