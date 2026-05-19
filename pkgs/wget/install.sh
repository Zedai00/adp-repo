#!/system/bin/sh

PKG="wget"
URL="https://pkgs.pkgforge.dev/dl/bincache/aarch64-linux/wget/ppkg/wget/raw.dl"

EXE="$PKG_TMP/$PKG"

echo "[+] Downloading $PKG"

download "$URL" "$EXE" || exit 1

BIN=$(find "$PKG_TMP" -type f -name $PKG | head -n 1)

if [ -z "$BIN" ]; then
    echo "[-] $PKG binary not found"
    exit 1
fi

echo "[+] Installing"

mkdir -p "$ADP_BIN"

cp "$BIN" "$ADP_BIN/$PKG"
chmod 755 "$ADP_BIN/$PKG"

mkdir -p "$KSU_BIN"

ln -sf "$ADP_BIN/$PKG" "$KSU_BIN/$PKG"

echo "[+] $PKG installed"

