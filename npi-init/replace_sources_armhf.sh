# git clone https://hub.fastgit.xyz/RPI-Distro/pi-gen

DEBIAN_PRIMARY_SOURCE='ftp.cn.debian.org/debian'
DEBIAN_SECURITY_SOURCE='ftp.cn.debian.org/debian-security'
BOOTSTRAP_URL_ORIG='http://raspbian.raspberrypi.org/raspbian/'
BOOTSTRAP_URL='http://ftp.cn.debian.org/raspbian/raspbian/'
PI_PRIMARY_SOURCE_ORIG='raspbian.raspberrypi.org/raspbian'
PI_PRIMARY_SOURCE='ftp.cn.debian.org/raspbian/raspbian'
PI_ARCHIVE_SOURCE='ftp.cn.debian.org/raspberrypi/debian'

sed -i 's/x86_64|aarch64/x86_64/g' build-docker.sh

# 替换中文源
REPLECE_SOURCE='RUN sed -i '"'"'s|deb.debian.org/debian|'"$DEBIAN_PRIMARY_SOURCE"'|g'"'"' /etc/apt/sources.list'
sed -i 's#^\(RUN apt-get -y update .*\)#'"$REPLECE_SOURCE"'\n\1#g' Dockerfile

sed -i 's#\(.*bootstrap.*\) '"$BOOTSTRAP_URL_ORIG"'#\1 '"$BOOTSTRAP_URL"'#g' stage0/prerun.sh

# 替换镜像中的中文源
sed -i 's#'"$PI_PRIMARY_SOURCE_ORIG"'#'"$PI_PRIMARY_SOURCE"'#g' stage0/00-configure-apt/files/sources.list

sed -i 's#archive.raspberrypi.org/debian#'"$PI_ARCHIVE_SOURCE"'#g' stage0/00-configure-apt/files/raspi.list

# 替换 DNS
NEW_DNS='233.6.6.6'
sed -i 's#8.8.8.8#'"$NEW_DNS"'#g' export-image/03-network/files/resolv.conf

# fastgit 加速
sed -i 's#github.com/\(raspberrypi/firmware\)/raw#raw.fastgit.org/\1/#g' export-image/05-finalise/01-run.sh
