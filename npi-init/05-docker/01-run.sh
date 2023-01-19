#!/bin/bash -e

install -m 644 files/docker.list "${ROOTFS_DIR}/etc/apt/sources.list.d/"
sed -i "s/RELEASE/${RELEASE}/g" "${ROOTFS_DIR}/etc/apt/sources.list.d/docker.list"

cat files/docker-ce.gpg.key | gpg --dearmor > "${ROOTFS_DIR}/usr/share/keyrings/docker-ce.gpg"
on_chroot << EOF
apt-get update
apt-get install docker-ce docker-compose-plugin
systemctl enable docker
systemctl start docker

sudo tee /etc/docker/daemon.json <<-'EOFF'
{
    "registry-mirrors": ["http://docker.mirrors.ustc.edu.cn"]
}
EOFF

systemctl daemon-reload
systemctl restart docker
EOF

