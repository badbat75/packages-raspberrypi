# shellcheck shell=bash
# shellcheck disable=SC2154
# raspi-config: pre-build script, sourced by runprebuild.sh (cwd: ${PKG_SRCPATH}, set -x, no -e).
# Every ALL_CAPS variable visible to package.env is available here as ${VAR}.

install -d -m755 ${PKG_PKGPATH}{/usr/bin,/etc/systemd/system}
    install -m755 raspi-config ${PKG_PKGPATH}/usr/bin
    install -m644 autologin@.service ${PKG_PKGPATH}/etc/systemd/system
    find usr/lib -type f -exec install -v -D -m755 "{}" "${PKG_PKGPATH}/{}" \;
    find usr/share etc -type f -exec install -v -D -m644 "{}" "${PKG_PKGPATH}/{}" \;
