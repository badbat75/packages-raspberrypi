# raspberrypi-net-mods
PKG_VER="1.4.3"
PKG_URL="https://github.com/RPi-Distro/raspberrypi-net-mods/archive/7294ab832105d36af390a89702cf8f25cba693fb.tar.gz"
BUILD_PROCESS=downloadonly
PKG_PREBUILD="find etc -type f -exec install -v -D -m644 \"{}\" \"\${PKG_PKGPATH}/{}\" \;
    install -v -D -m644 debian/raspberrypi-net-mods.service \${PKG_PKGPATH}/lib/systemd/system/raspberrypi-net-mods.service
    install -d \${PKG_PKGPATH}/etc/systemd/system/multi-user.target.wants
    ln -s /lib/systemd/system/raspberrypi-net-mods.service \${PKG_PKGPATH}/etc/systemd/system/multi-user.target.wants/"
PKG_DEPS="lfs/rfkill"