
IMAGE_FILE=$1
DEVICE=$2

diskutil unmountDisk /dev/disk7
dd if="$IMAGE_FILE" of="$DEVICE" bs=4M conv=fsync status=progress
