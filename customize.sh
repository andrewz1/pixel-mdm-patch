if $BOOTMODE; then
	[ -f /vendor/firmware/carrierconfig/cfg.db ] || abort "- Modem configuration not found"
	ui_print "- Installing Google Tensor Modem patch"
else
	abort "- Only Magisk is supported"
fi

# old versions cleanup
rm -f $MODPATH/system/vendor/firmware/carrierconfig/cfg.db
rm -f $MODPATH/cfg.md5

chmod +x $MODPATH/modem-patch
cp -a /vendor/firmware/carrierconfig/cfg.db $MODPATH/system/vendor/firmware/carrierconfig/
$MODPATH/modem-patch $MODPATH/system/vendor/firmware/carrierconfig/cfg.db 250 255 257 400 401 282 283 289
set_perm $MODPATH/vendor/firmware/carrierconfig/cfg.db root root 0644 u:object_r:vendor_fw_file:s0
