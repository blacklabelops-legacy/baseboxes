#!/bin/sh

# clean up redhat interface persistence
rm -f /etc/udev/rules.d/70-persistent-net.rules

for ndev in $(ls /etc/sysconfig/network-scripts/ifcfg-*); do
  if [ "$(basename ${ndev})" != "ifcfg-lo" ]; then
    sed -i '/^HWADDR/d' ${ndev}
    sed -i '/^UUID/d' ${ndev}
  fi
done

swapuuid=$(/sbin/blkid -o value -l -s UUID -t TYPE=swap)
swappart=$(readlink -f /dev/disk/by-uuid/"$swapuuid")
/sbin/swapoff "$swappart"
dd if=/dev/zero of="$swappart" bs=1M || echo "dd exit code $? is suppressed"
/sbin/mkswap -U "$swapuuid" "$swappart"

dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

unset HISTFILE
rm -f /root/.bash_history
rm -f /home/vagrant/.bash_history

find /var/log -type f | while read f; do echo -ne '' > $f; done;

count=`df --sync -kP / | tail -n1  | awk -F ' ' '{print $4}'`;
let count--
dd if=/dev/zero of=/tmp/whitespace bs=1024 count=$count;
rm /tmp/whitespace;

count=`df --sync -kP /boot | tail -n1 | awk -F ' ' '{print $4}'`;
let count--
dd if=/dev/zero of=/boot/whitespace bs=1024 count=$count;
rm /boot/whitespace;

swappart=$(cat /proc/swaps | grep -v Filename | tail -n1 | awk -F ' ' '{print $1}')
if [ "$swappart" != "" ]; then
  swapoff $swappart;
  dd if=/dev/zero of=$swappart;
  mkswap $swappart;
  swapon $swappart;
fi

sync
