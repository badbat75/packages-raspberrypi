# shellcheck shell=bash
# shellcheck disable=SC2154
# pi-bluetooth_0: pre-build script, sourced by runprebuild.sh (cwd: ${PKG_SRCPATH}, set -x, no -e).
# Every ALL_CAPS variable visible to package.env is available here as ${VAR}.

install -d -m0755 ${PKG_PKGPATH}${INSTALL_PREFIX}/bin
    install -d -m0755 ${PKG_PKGPATH}${INSTALL_SYSCONFDIR}/systemd/system
    install -d -m0755 ${PKG_PKGPATH}/lib/udev/rules.d
    install -m 0755 -D usr/bin/btuart ${PKG_PKGPATH}${INSTALL_PREFIX}/bin/
    install -m 0755 -D usr/bin/bthelper ${PKG_PKGPATH}${INSTALL_PREFIX}/bin/
    install -m 0644 -D debian/pi-bluetooth.hciuart.service ${PKG_PKGPATH}${INSTALL_SYSCONFDIR}/systemd/system/hciuart.service
    install -m 0644 -D debian/pi-bluetooth.bthelper@.service ${PKG_PKGPATH}${INSTALL_SYSCONFDIR}/systemd/system/bthelper@.service
    install -m 0644 -D lib/udev/rules.d/90-pi-bluetooth.rules ${PKG_PKGPATH}/lib/udev/rules.d/90-pi-bluetooth.rules
    systemctl --root=${PKG_PKGPATH} enable hciuart
    ### hci_uart after brcmfmac on the Pi 3 Model B, Zero W and Zero 2 W: their Bluetooth stops answering when the WiFi
    ### firmware starts during its patch download (files/hci-uart-after-wifi)
    install -v -D -m755 ${PKG_RECIPEPATH}/files/hci-uart-after-wifi ${PKG_PKGPATH}/usr/lib/pi-bluetooth/hci-uart-after-wifi
    install -v -D -m644 ${PKG_RECIPEPATH}/files/pi-bluetooth.conf ${PKG_PKGPATH}/usr/lib/modprobe.d/pi-bluetooth.conf
