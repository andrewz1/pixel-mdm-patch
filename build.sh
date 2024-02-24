#!/bin/sh

mid=$(grep ^id= module.prop | awk -F= '{ print $2 }')
ver=$(grep ^version= module.prop | awk -F= '{ print $2 }')
mname="$mid-$ver.zip"
rm -f $mname
cat files.txt | zip -9@ $mname
