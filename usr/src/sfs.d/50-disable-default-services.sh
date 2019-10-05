#!/bin/sh

# disable some services which are enabled by default in upstream, but might conflict
# with other installed packages or should be manually configured/started, and could
# cause problems or fail ungracefully otherwise

. "$(dirname "$0")/.common.sh"
. "$lbu/scripts/common.func"

find "$DESTDIR/etc/systemd/system/multi-user.target.wants" \
  \( -false $(for svc in $disable_defsvc; do echo -or -name $svc.service;done) \) \
  -delete
