# git clone https://hub.fastgit.xyz/RPI-Distro/pi-gen

NEW_SOURCE='ftp.cn.debian.org/debian'

# 替换中文源
REPLECE_SOURCE='RUN sed -i '"'"'s|deb.debian.org/debian|'"$NEW_SOURCE"'|g'"'"' /etc/apt/sources.list'
sed -i 's#^\(RUN apt-get -y update .*\)#'"$REPLECE_SOURCE"'\n\1#g' pi-gen/Dockerfile


BOOTSTRAP_URL=http://ftp.cn.debian.org/debian/
sed -i 's#\(.*bootstrap.*\) http://deb.debian.org/debian/#\1'"$BOOTSTRAP_URL"'#g' pi-gen/stage0/prerun.sh

# 替换镜像中的中文源
SECURITY_SOURCE='ftp.cn.debian.org/debian-security'
sed -i 's#deb.debian.org/debian#'"$NEW_SOURCE"'#g;s#security.debian.org/debian-security#'"$SECURITY_SOURCE"'#g' pi-gen/stage0/00-configure-apt/files/sources.list

PI_SOURCE='ftp.cn.debian.org/raspberrypi/debian'
sed -i 's#archive.raspberrypi.org/debian#'"$PI_SOURCE"'#g' pi-gen/stage0/00-configure-apt/files/raspi.list

# 替换 DNS
NEW_DNS='233.6.6.6'
sed -i 's#8.8.8.8#'"$NEW_DNS"'#g' pi-gen/export-image/03-network/files/resolv.conf

# fastgit 加速
sed -i 's#github.com/\(raspberrypi/firmware\)/raw#raw.fastgit.org/\1/#g' pi-gen/export-image/05-finalise/01-run.sh
