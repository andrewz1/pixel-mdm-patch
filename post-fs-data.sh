#!/system/bin/sh

MODDIR=${0%/*}

# not our device
if [ ! -f /system/vendor/firmware/carrierconfig/cfg.db ]; then
	exit 0
fi

[ -f $MODDIR/cfg.md5 ] || touch $MODDIR/cfg.md5
cfgsum=$(toybox md5sum -b /system/vendor/firmware/carrierconfig/cfg.db)
cursum=$(cat $MODDIR/cfg.md5)
# update if new cfg.db found
if [ "$cfgsum" != "$cursum" ]; then
	rm -f $MODDIR/system/vendor/firmware/carrierconfig/cfg.db
	cp -a /system/vendor/firmware/carrierconfig/cfg.db $MODDIR/system/vendor/firmware/carrierconfig/
	chmod +x $MODDIR/modem-patch
	$MODDIR/modem-patch $MODDIR/system/vendor/firmware/carrierconfig/cfg.db
	chcon u:object_r:vendor_fw_file:s0 $MODPATH/system/vendor/firmware/carrierconfig/cfg.db
	echo $cfgsum >$MODDIR/cfg.md5
fi
