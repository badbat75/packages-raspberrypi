# shellcheck shell=bash
# shellcheck disable=SC2154
# raspberrypi-net-mods: pre-build script, sourced by runprebuild.sh (cwd: ${PKG_SRCPATH}, set -x, no -e).
# Every ALL_CAPS variable visible to package.env is available here as ${VAR}.

find etc -type f -exec install -v -D -m644 "{}" "${PKG_PKGPATH}/{}" \;
    install -v -D -m644 debian/raspberrypi-net-mods.service ${PKG_PKGPATH}/lib/systemd/system/raspberrypi-net-mods.service
    install -d ${PKG_PKGPATH}/etc/systemd/system/multi-user.target.wants
    ln -s /lib/systemd/system/raspberrypi-net-mods.service ${PKG_PKGPATH}/etc/systemd/system/multi-user.target.wants/
