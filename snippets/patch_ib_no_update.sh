#!/bin/bash
echo "Patches all installed ImageBuilders to not opkg update if NO_UPDATE=1"
RELEASE="17.01.1"
[ ! -d $RELEASE ] && echo "Dir $RELEASE not found" && exit 1
find $RELEASE/ -maxdepth 3 -type d -name 'ib' | while read d; do
    echo "Patching $d..."
    sed -i s/'\($(OPKG) update || true;\)'/'[ -z \"$(NO_UPDATE)\" ] \&\& \1'/g $d/Makefile
done
