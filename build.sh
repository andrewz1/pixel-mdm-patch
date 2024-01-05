#!/bin/sh

ver=$(grep ^version= module.prop | awk -F= '{ print $2 }')
rm -f pixel-mdm-patch-$ver.zip
cat files.txt | zip -9@ pixel-mdm-patch-$ver.zip
