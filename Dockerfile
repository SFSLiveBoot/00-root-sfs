# should be built with envsubst:
#  LBU_REPO=xxx ROOT_REPO=yyy ROOT_NAME=zzz envsubst < Dockerfile | docker build -t xyz -
# should be run in privileged mode and /data volume:
#  docker run --privileged -v /some/non-aufs-dir/jessie:/data ...
# can be used to build some other primary sfs files as well:
#  docker run ... /opt/LiveBootUtils/scripts/rebuild-sfs.sh --auto $SOME_SFS_REPO /data/ZZ-xyz.sfs


FROM debian:jessie

RUN apt-get update && apt-get install --no-install-recommends -y \
  ca-certificates \
  lsof \
  cdebootstrap \
  squashfs-tools \
  git

RUN git clone ${LBU_REPO} /opt/LiveBootUtils

VOLUME ["/data"]

RUN rm -r /var/cache/apt/archives /var/lib/apt/lists
RUN ln -s /data/cache/archives /var/cache/apt
RUN ln -s /data/cache/lists /var/lib/apt/lists

ENV dl_cache_dir /data/cache/lbu
CMD ["/bin/sh", "-c", "mkdir -p /data/cache/archives /data/cache/lists; /opt/LiveBootUtils/scripts/rebuild-sfs.sh --auto ${ROOT_REPO}.git /data/00-${ROOT_NAME}.sfs"]
