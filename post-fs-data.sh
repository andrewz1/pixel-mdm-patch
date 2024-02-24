#!/system/bin/sh

MODPATH=${0%/*}

if [ ! -f /system/vendor/firmware/carrierconfig/cfg.db ]; then
	exit 0
fi

$MODPATH/modem-patch $MODPATH/system/vendor/firmware/carrierconfig/cfg.db 250 255 257 400 401 282 283 289
chcon u:object_r:vendor_fw_file:s0 $MODPATH/system/vendor/firmware/carrierconfig/cfg.db
