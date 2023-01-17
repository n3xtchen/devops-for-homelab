
cp config.tmpl pi-gen/config
cp -r 04-cloud-init pi-gen/stage2/

cd pi-gen

touch ./stage3/SKIP ./stage4/SKIP ./stage5/SKIP
touch ./stage4/SKIP_IMAGES ./stage5/SKIP_IMAGES
./build-docker.sh

cd -
