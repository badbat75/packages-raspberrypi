# pi-bluetooth
PKG_SUFFIX=".1.19"
PKG_URL="https://github.com/RPi-Distro/pi-bluetooth/archive/87248a382d1a81b80a62730975135d87fffd7ef1.tar.gz"
BUILD_PROCESS=downloadonly
PKG_DEPS="raspberrypi/raspberrypi-sys-mods"
PKG_PREBUILD="install -d -m0755 \${PKG_PKGPATH}\${INSTALL_PREFIX}/bin
    install -d -m0755 \${PKG_PKGPATH}\${INSTALL_SYSCONFDIR}/systemd/system
    install -d -m0755 \${PKG_PKGPATH}/lib/udev/rules.d
    install -m 0755 -D usr/bin/btuart \${PKG_PKGPATH}\${INSTALL_PREFIX}/bin/
    install -m 0755 -D usr/bin/bthelper \${PKG_PKGPATH}\${INSTALL_PREFIX}/bin/
    install -m 0644 -D debian/pi-bluetooth.hciuart.service \${PKG_PKGPATH}\${INSTALL_SYSCONFDIR}/systemd/system/hciuart.service
    install -m 0644 -D debian/pi-bluetooth.bthelper@.service \${PKG_PKGPATH}\${INSTALL_SYSCONFDIR}/systemd/system/bthelper@.service
    install -m 0644 -D lib/udev/rules.d/90-pi-bluetooth.rules \${PKG_PKGPATH}/lib/udev/rules.d/90-pi-bluetooth.rules
    systemctl --root=\${PKG_PKGPATH} enable hciuart"