#!/system/bin/sh

URL="https://github.com/fish-shell/fish-shell/releases/download/4.7.1/fish-4.7.1-linux-aarch64.tar.xz"

ARCHIVE="$PKG_TMP/fish.tar.xz"

echo "[+] Downloading fish"

download "$URL" "$ARCHIVE" || exit 1

echo "[+] Extracting"

tar -xJf "$ARCHIVE" -C "$PKG_TMP" || exit 1

# locate fish binary
FISH_BIN=$(find "$PKG_TMP" -type f -name fish | head -n 1)

if [ -z "$FISH_BIN" ]; then
    echo "[-] fish binary not found"
    exit 1
fi

echo "[+] Installing"

mkdir -p "$ADP_BIN"

cp "$FISH_BIN" "$ADP_BIN/fishsh"
chmod 755 "$ADP_BIN/fishsh"

cat > "$ADP_BIN/fish" <<'EOF'
#!/system/bin/sh

su -c '
mkdir -p /data/adb/fish_home

export HOME=/data/adb/fish_home
export PATH=/data/adb/modules/adp/bin:$PATH

exec /data/adb/modules/adp/bin/fishsh -C "cd"
'
EOF

chmod 755 "$ADP_BIN/fish"

mkdir -p "$KSU_BIN"

ln -sf "$ADP_BIN/fish" "$KSU_BIN/fish"

echo "[+] fish installed"

RED='\033[1;31m'
RESET='\033[0m'

echo "${RED}[!] Note: 'fish' is a wrapper that sets up the ADP environment.${RESET}"
echo "${RED}[!] The actual Fish binary is 'fishsh'.${RESET}"
echo "${RED}[!] Use 'fishsh' directly only if you know what you're doing.${RESET}"
