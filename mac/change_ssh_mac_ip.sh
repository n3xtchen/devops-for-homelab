#! /bin/sh
#
# change_ssh_mac_ip.sh
# Copyright (C) 2025 n3xtchen <echenwen@gmail.com>
#
# Distributed under terms of the GPL-2.0 license.
#

new_ip=`ifconfig en0 | grep inet | grep -v inet6 | awk '{print $2}'`
echo $new_ip
old_ip=`awk '/pupu-mac/ {print $2}' ~/.ssh/config`
echo $old_ip

if [ "$new_ip" = "$old_ip" ]; then
  echo "ip not change"
else
  echo "ip change"
  file=`ls -al ~/.ssh/config | awk '{print $11}'`
  echo $file
  sed -i "" "s/HostName        .* # pupu-mac/HostName        ${new_ip} # pupu-mac/" $file
fi
