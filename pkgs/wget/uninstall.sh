#!/system/bin/sh

PKG="wget"

echo "[+] Uninstalling $PKG"

rm -f "$KSU_BIN/$PKG"

rm -f "$ADP_BIN/$PKG"

echo "[+] $PKG removed"


