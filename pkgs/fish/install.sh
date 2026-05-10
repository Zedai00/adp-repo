#!/system/bin/sh

URL="https://github.com/fish-shell/fish-shell/releases/download/4.7.1/fish-4.7.1-linux-aarch64.tar.xz"

MOD_HOME="/data/adb/modules/adp"
BIN="$MOD_HOME/system/bin"
TMP="/data/local/tmp/adp"

mkdir -p "$BIN"
mkdir -p "$TMP"

ARCHIVE="$TMP/fish.tar.xz"

echo "[+] Downloading fish"

busybox wget "$URL" -O "$ARCHIVE" || exit 1

echo "[+] Extracting"

tar -xJf "$ARCHIVE" -C "$TMP" || exit 1

# locate fish binary
FISH_BIN=$(find "$TMP" -type f -name fish | head -n 1)

if [ -z "$FISH_BIN" ]; then
    echo "[-] fish binary not found"
    exit 1
fi

echo "[+] Installing"

cp "$FISH_BIN" "$BIN/fishsh"
chmod 755 "$BIN/fishsh"

cat > "$BIN/fish" <<'EOF'
#!/system/bin/sh

su -c '
mkdir -p /data/adb/fish_home

export HOME=/data/adb/fish_home
export PATH=/data/adb/modules/adp/system/bin:$PATH

exec fishsh -C "cd"
'
EOF

chmod 755 "$BIN/fish"

echo "[+] fish installed"
