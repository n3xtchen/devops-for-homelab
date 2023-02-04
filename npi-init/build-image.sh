cp config.tmpl pi-gen/config

# add docker & cloud-init
cp -r 04-docker/ pi-gen/stage2
cp -r 05-cloud-init pi-gen/stage2/

cd pi-gen

PI_ARCH="armhf"
BRANCH=`git branch --show-current`

if [ "${BRANCH}" = "arm64" ];
then
    PI_ARCH="arm64"
    sh ../replace_sources.sh
else
    sh ../replace_sources_armhf.sh
fi

sed -i "s/BUILD_ARCH/${PI_ARCH}/g" stage2/04-docker/files/docker.list

./build-docker.sh

# 清除代码
git checkout -- .
rm -r stage2/04-docker stage2/05-cloud-init
rm config

cd -
