#!/bin/bash -e

install -d				"${ROOTFS_DIR}/etc/cloud"
install -m 755 files/cloud.cfg	"${ROOTFS_DIR}/etc/cloud/"

# bulleyes security key bullseye-security not bullseye
install -d				"${ROOTFS_DIR}/etc/cloud/templates"
install -m 755 files/sources.list.debian.tmpl	"${ROOTFS_DIR}/etc/cloud/templates/"
 
install -m 644 files/meta-data	"${ROOTFS_DIR}/boot/"
install -m 644 files/user-data	"${ROOTFS_DIR}/boot/"
install -m 644 files/vendor-data	"${ROOTFS_DIR}/boot/"

# on_chroot << EOF
# cloud-init init --local
# EOF

# install -d				"${ROOTFS_DIR}/var/lib/cloud/scripts/per-boot"
# install -m 755 files/00_run-parts.sh    "${ROOTFS_DIR}/var/lib/cloud/scripts/per-boot/"
