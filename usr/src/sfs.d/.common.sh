#!/bin/sh

: "${lbu:=/opt/LiveBootUtils}"

: "${dist:=$(lsb_release -sc)}"
: "${repo:=$(awk '/^deb /{print $2}' $DESTDIR/etc/apt/sources.list | head -1)}"

: "${pkgs:=$(sed -Ee 's/(^|[[:space:]])#.*//' "$(dirname "$0")/.pkgs" | grep -v '^$' | tr '\n' ' ')}"
