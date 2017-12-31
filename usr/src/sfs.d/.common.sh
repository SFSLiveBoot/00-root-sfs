#!/bin/sh

: ${lbu:=/opt/LiveBootUtils}

: ${dist:=$(awk '/^deb /{print $3}' $DESTDIR/etc/apt/sources.list | head -1)}
: ${repo:=$(awk '/^deb /{print $2}' $DESTDIR/etc/apt/sources.list | head -1)}

# python libraries
: ${libs_py:=python-usb python-lzma python-pypcap python-psycopg2 python-netsnmp python-openssl python-pyasn1 python-unicodecsv python-pycurl python-xapian python-m2crypto python-pcapy python-pyxattr python-paramiko python-protobuf python-mysqldb python-fuse python-plist python-enum34 python-serial python-libxml2 python-pylibacl }
# perl libraries
: ${libs_pl:=libcrypt-cbc-perl libarchive-zip-perl libdatetime-perl libperlio-gzip-perl libnet-daemon-perl libjson-xs-perl libparse-win32registry-perl libimage-exiftool-perl libuuid-perl libhtml-parser-perl libjson-perl libcrypt-ssleay-perl }
# libnss
: ${libs_nss:=libnss-mdns libnss-myhostname libnss-extrausers }
# other libs
: ${libs:=libsysfs2 libengine-pkcs11-openssl libgettextpo0 libdb1-compat $libs_py $libs_pl $libs_nss }

# hardware support
: ${hw_pkgs:=usbmuxd atmel-firmware firmware-b43-installer pcmciautils hwdata dmidecode socat libimobiledevice-utils ipheth-utils rfkill vbetool fbterm gpm obexfs bluetooth kbd usb-modeswitch firmware-linux firmware-realtek firmware-intelwimax firmware-bnx2 firmware-iwlwifi firmware-atheros firmware-brcm80211 tlp }

# networking
: ${net_pkgs:=xnbd-client ifenslave-2.6 cifs-utils tcptraceroute freetds-bin hostapd winbind tcpdump tcpxtract aria2 ftp-ssl atftp avahi-utils avahi-autoipd dhcpcd5 dnsmasq xnbd-server ethtool ipcalc ipset iputils-arping ipv6calc ipsec-tools traceroute sshfs ssh msmtp cadaver urlview bridge-utils netcat-openbsd rsync smitools ntpdate madwimax sipcalc snmp-mibs-downloader crda vtun telnet-ssl radvd ndisc6 nfs-kernel-server pppoeconf ldap-utils mysql-client snmp smbclient macchanger tcpreplay tshark curl mosh }

# file format support
: ${fmt_pkgs:=p7zip-rar unrar exfat-utils cpio nkf pxz elfutils cdrdao lzop lzip gzip binutils-multiarch unzip libxml2-utils genisoimage xsltproc xorriso db-util xmlstarlet exiv2 zip vmfs-tools pax plzip pigz tnef cabextract fuseext2 lzma }

# filesystem/disk related
: ${disk_pkgs:=dump jfsutils dosfstools exfat-fuse lvm2 zfs-fuse reiserfsprogs xfsdump copyfs encfs bindfs e2fsprogs autofs squashfs-tools mbr kpartx gpart gdisk grub2 grub-efi-amd64-bin mpt-status reiser4progs eject dmraid partimage sdparm }

# virtualization
: ${virt_pkgs:=v86d kexec-tools open-vm-tools lxc qemu-utils vde2-cryptcab }

# basic packages
: ${base_pkgs:=$fmt_pkgs $hw_pkgs $net_pkgs $virt_pkgs $disk_pkgs systemd-sysv vim-tiny strace apt-transport-https klibc-utils libpam-modules-bin grep pcscd base-passwd inotify-tools gsfonts ltrace fdupes multitail powertop lsof hostname bash-completion multiarch-support unison sharutils cpuid dash acpi syslinux bximage pppconfig command-not-found ascii syslinux-common lshw uidmap libmtp-runtime ruby-sqlite3 auditd hexedit rdiff-backup udpcast nano bar dkms console-data ncurses-base pcregrep silversearcher-ag alsa-utils cdebootstrap libnss3-tools inxi mtr-tiny ebtables netpbm tmux iotop diffutils libpam-ck-connector resolvconf busybox-static screen pwgen wamerican-small findutils xml-core runit tre-agrep gnutls-bin htop login lockfile-progs idn irqbalance locales lksctp-tools libplist-utils krb5-user libjpeg-turbo-progs less at bc cryptsetup dc expect info sqlite3 time ed vim jq uuid-runtime uuid tree python-qrcode zbar-tools sl }

# security
: ${sec_pkgs:=tpm-tools opensc opensc-pkcs11 pkcs11-data scdaemon gnupg-pkcs11-scd zerofree chntpw fcrackzip rifiuti2 flashrom bluez-hcidump upx-ucl p0f skipfish scrounge-ntfs paxctl scalpel testdisk ewf-tools md5deep medusa geoip-database geoip-bin ike-scan ssldump dns2tcp ext3grep rsh-client netcat-traditional aircrack-ng foremost ophcrack-cli android-tools-fastboot pkcs11-dump tsocks dumpasn1 hping3 python-scapy makedumpfile fping kismet-plugins pnscan fpdns ssdeep extundelete arpwatch proxychains gvpe nss-passwords mdns-scan ptunnel android-tools-adb dcfldd bkhive ngrep tor dirmngr sleuthkit }

# gnome
: ${gnome_pkgs:=eog file-roller vinagre nautilus-share libpam-gnome-keyring gstreamer1.0-libav network-manager-vpnc-gnome libgnomevfs2-0 gnome-online-accounts gnome-session-flashback network-manager-gnome network-manager-openvpn-gnome network-manager-openconnect-gnome gnome-shell-extensions gnome-tweak-tool gnome-shell-timer gnome-screenshot gnome-system-monitor ssh-askpass-gnome gnome-disk-utility gnome-nettool network-manager-iodine-gnome gnome-power-manager network-manager-pptp-gnome gstreamer1.0-tools gstreamer1.0-plugins-ugly gvfs-backends gvfs-fuse gvfs-bin telepathy-idle telepathy-salut telepathy-gabble seahorse baobab gkbd-capplet gnome-terminal gdm3 gnome-control-center brasero cheese colord evince empathy gucharmap polari transmission totem-plugins gnome-themes-standard gnome-bluetooth gnome-clocks pk-update-icon }

# programs depending on X11 libraries etc.
: ${guilib_based:=libqtwebkit4 libqt5x11extras5 gphoto2 wireshark tcpflow x11vnc virt-viewer avahi-discover qemu-kvm zenmap dsniff guymager xvfb ecryptfs-utils wkhtmltopdf mutt ht pcsc-tools consolekit poppler-utils poppler-data sqsh imagemagick gitk git-gui meld dosbox zim rdesktop unison-gtk gtkterm ddd gparted virtualbricks libtxc-dxtn-s2tc }

# other gui
: ${gui_pkgs:=$gnome_pkgs $guilib_based libgtk2.0-bin python-gconf pavucontrol im-config vim-gtk nvidia-installer-cleanup sound-theme-freedesktop ttf-unifont gedit-plugins twm xclip gksu gnome-calculator software-properties-common xfonts-unifont xfonts-terminus xserver-xorg-input-wacom xserver-xephyr xserver-xorg-video-qxl xserver-xorg-input-joystick xserver-xorg-input-void xserver-xorg-video-dummy gir1.2-webkit-3.0 synaptic xvnc4viewer terminator libfreerdp-plugins-standard mousetweaks libcanberra-gtk-module xpad pulseaudio-module-bluetooth blueman xzoom xinput mesa-utils task-desktop xterm ghex smart-notifier conky xbacklight keepassx glx-alternative-nvidia gtk2-engines-pixbuf }

# input_pkgs
: ${im_pkgs:=ibus-clutter ibus-gtk ibus-input-pad ibus-wayland ibus-gtk3}

# development
: ${dev_pkgs:=libtool debhelper libasound2-dev python-setuptools python-lazr.restfulclient flex libssl-dev bzr dwarfdump libxml2-dev libncurses5-dev automake nasm subversion libpcap-dev bundler gdb-multiarch manpages-dev cvs build-essential fakeroot g++ bison mercurial libelf-dev }

# all together
: ${pkgs:=$libs $base_pkgs $sec_pkgs $gui_pkgs $dev_pkgs }
