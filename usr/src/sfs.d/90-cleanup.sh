#!/bin/sh

set -e

. "$(dirname "$0")/.common.sh"
. "$lbu/scripts/common.func"

test ! -d "$extra_deb_dir" || {
  rm -f "$DESTDIR/etc/apt/sources.list.d/$(echo "$extra_deb_dir" | tr / _).list"
  rmdir "$DESTDIR/$extra_deb_dir" || true
}
rm -f "$DESTDIR/$inst_sh"
