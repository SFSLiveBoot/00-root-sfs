#!/bin/sh

: ${lbu:=/opt/LiveBootUtils}

: ${dist:=$(awk '/^deb /{print $3}' $DESTDIR/etc/apt/sources.list | head -1)}
: ${repo:=$(awk '/^deb /{print $2}' $DESTDIR/etc/apt/sources.list | head -1)}

: "${pkgs:=$(sed -Ee 's/(^|[[:space:]])#.*//' "$(dirname "$0")/.pkgs" | grep -v '^$' | tr '\n' ' ')}"

: "${apt_prx_conf:=/etc/apt/apt.conf.d/99-install-proxy}"

: "${inst_sh:=/.install_pkgs.sh}"
