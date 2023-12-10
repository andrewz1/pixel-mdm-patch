#!/bin/sh

ver=$(grep ^version= module.prop | awk -F= '{ print $2 }')
cat files.txt | zip -9@ pixel-mdm-patch-$ver.zip
