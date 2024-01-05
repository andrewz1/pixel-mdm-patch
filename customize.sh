if $BOOTMODE; then
	ui_print "- Installing from Magisk app"
else
	ui_print "*********************************************************"
	ui_print "! Install from recovery is NOT supported"
	ui_print "! Please install from Magisk app"
	abort    "*********************************************************"
fi

CODENAME=$(getprop ro.product.vendor.device)
BUILDID=$(getprop ro.vendor.build.id)
MODEMVER=$(getprop gsm.version.baseband)
CFGVER=$(cat /vendor/firmware/carrierconfig/release-label)
CFGHASH=$(toybox sha256sum -b /vendor/firmware/carrierconfig/cfg.db)

ui_print "- Magisk version is: $MAGISK_VER_CODE"
ui_print "- Device is: $CODENAME"
ui_print "- Build ID is: $BUILDID"
ui_print "- Modem version is: $MODEMVER"
ui_print "- CFG version is: $CFGVER"
ui_print "- CFG file state is: $CFGHASH"
ui_print "- Note, that this module is only for SoC Google Tensor devices!"

[ -f /vendor/firmware/carrierconfig/cfg.db ] || abort "configuration not found"
rm -f $MODPATH/system/vendor/firmware/carrierconfig/cfg.db
cp -a /vendor/firmware/carrierconfig/cfg.db $MODPATH/system/vendor/firmware/carrierconfig/
chmod +x $MODPATH/modem-patch
$MODPATH/modem-patch $MODPATH/system/vendor/firmware/carrierconfig/cfg.db
chcon u:object_r:vendor_fw_file:s0 $MODPATH/system/vendor/firmware/carrierconfig/cfg.db
toybox md5sum -b /system/vendor/firmware/carrierconfig/cfg.db >$MODDIR/cfg.md5
