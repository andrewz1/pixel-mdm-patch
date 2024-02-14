#!/system/bin/sh

MODDIR=${0%/*}

# not our device
if [ ! -f /system/vendor/firmware/carrierconfig/cfg.db ]; then
	exit 0
fi

rm -f $MODDIR/system/vendor/firmware/carrierconfig/cfg.db
cp -a /system/vendor/firmware/carrierconfig/cfg.db $MODDIR/system/vendor/firmware/carrierconfig/
chmod +x $MODDIR/modem-patch
$MODDIR/modem-patch $MODDIR/system/vendor/firmware/carrierconfig/cfg.db
chcon u:object_r:vendor_fw_file:s0 $MODPATH/system/vendor/firmware/carrierconfig/cfg.db
