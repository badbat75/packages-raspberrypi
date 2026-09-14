# shellcheck shell=bash
# shellcheck disable=SC2154
# raspberrypi-sys-mods: pre-build script, sourced by runprebuild.sh (cwd: ${PKG_SRCPATH}, set -x, no -e).
# Every ALL_CAPS variable visible to package.env is available here as ${VAR}.

install -d -m755 ${PKG_PKGPATH}/etc/udev/rules.d
    install -m644 etc.armhf/udev/rules.d/99-com.rules ${PKG_PKGPATH}/etc/udev/rules.d/
    install -d -m755 ${PKG_PKGPATH}/lib/systemd/system
    install -v -D -m644 debian/raspberrypi-sys-mods.regenerate_ssh_host_keys.service ${PKG_PKGPATH}/lib/systemd/system/regenerate_ssh_host_keys.service
    install -v -D -m644 debian/raspberrypi-sys-mods.rpi-display-backlight.service ${PKG_PKGPATH}/lib/systemd/system/rpi-display-backlight.service
    install -v -D -m644 debian/raspberrypi-sys-mods.sshswitch.service ${PKG_PKGPATH}/lib/systemd/system/sshswitch.service
    install -d -m755 ${PKG_PKGPATH}/etc/systemd/system/multi-user.target.wants
    ln -s /lib/systemd/system/rpi-display-backlight.service ${PKG_PKGPATH}/etc/systemd/system/multi-user.target.wants/rpi-display-backlight.service
    ln -s /lib/systemd/system/regenerate_ssh_host_keys.service ${PKG_PKGPATH}/etc/systemd/system/multi-user.target.wants/regenerate_ssh_host_keys.service
    ln -s /lib/systemd/system/sshswitch.service ${PKG_PKGPATH}/etc/systemd/system/multi-user.target.wants/sshswitch.service
    #install -d -m755 ${PKG_PKGPATH}/etc/sudoers.d
    #echo 'pi ALL=(ALL) NOPASSWD: ALL' > ${PKG_PKGPATH}/etc/sudoers.d/010_pi-nopasswd
