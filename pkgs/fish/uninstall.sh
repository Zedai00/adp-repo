#!/system/bin/sh

MOD_HOME="/data/adb/modules/adp"
BIN="$MOD_HOME/system/bin"

rm -f "$BIN/fish"
rm -f "$BIN/fishsh"

rm -rf /data/adb/fish_home

echo "[+] fish removed"
