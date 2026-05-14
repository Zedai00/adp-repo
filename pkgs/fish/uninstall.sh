#!/system/bin/sh

echo "[+] Uninstalling fish"

rm -f "$KSU_BIN/fish"

rm -f "$ADP_BIN/fish"
rm -f "$ADP_BIN/fishsh"

echo "[+] fish removed"

YELLOW='\033[1;33m'
RESET='\033[0m'

echo "${YELLOW}[!] Fish home was NOT removed${RESET}"
echo "${YELLOW}[!] Home: /data/adb/fish_home${RESET}"
echo "${YELLOW}[!] Remove it manually if desired${RESET}"

