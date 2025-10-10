#!/bin/bash
# 🌐 CTPKG INSTALLER
# Erstellt von Anton 💻

echo "🚀 Installiere CTPKG Paket-System..."

# Installationspfad (für Termux)
BIN_DIR="/data/data/com.termux/files/usr/bin"
REPO="https://ctpkgdata.pages.dev"

# Downloader-Funktion (curl oder wget automatisch)
download() {
    url="$1"
    out="$2"
    if command -v curl >/dev/null 2>&1; then
        curl -s -o "$out" "$url"
    elif command -v wget >/dev/null 2>&1; then
        wget -q -O "$out" "$url"
    else
        echo "❌ Weder curl noch wget gefunden. Installiere eins mit:"
        echo "   pkg install curl"
        exit 1
    fi
}

# Erstelle den Hauptordner, falls er fehlt
mkdir -p "$BIN_DIR"

# Lade den Haupt-Installer (ctpkg)
echo "⬇️ Lade Haupt-Installer von $REPO..."
download "$REPO/ctpkg.sh" "$BIN_DIR/ctpkg"

# Falls kein ctpkg.sh online gefunden, leg Standardcode an
if [ ! -s "$BIN_DIR/ctpkg" ]; then
    echo "⚠️ Kein ctpkg.sh online gefunden, erstelle lokale Version..."
    cat > "$BIN_DIR/ctpkg" <<'EOF'
#!/bin/bash
REPO="https://ctpkgdata.pages.dev"
BIN_DIR="/data/data/com.termux/files/usr/bin"

install_pkg() {
    name="$1"
    if [ -z "$name" ]; then
        echo "❌ Kein Paketname angegeben."
        exit 1
    fi
    echo "🔍 Suche $name.sh..."
    if curl --head --silent --fail "$REPO/$name.sh" >/dev/null; then
        echo "⬇️ Lade $name herunter..."
        curl -s -o "$BIN_DIR/$name" "$REPO/$name.sh"
        chmod +x "$BIN_DIR/$name"
        echo "✅ $name wurde installiert!"
        bash "$BIN_DIR/$name"
    else
        echo "❌ Paket nicht gefunden!"
    fi
}

remove_pkg() {
    name="$1"
    if [ -f "$BIN_DIR/$name" ]; then
        rm -f "$BIN_DIR/$name"
        echo "🗑️ $name wurde deinstalliert."
    else
        echo "❌ Paket nicht installiert."
    fi
}

case "$1" in
  install) install_pkg "$2" ;;
  remove) remove_pkg "$2" ;;
  *) echo "📦 Nutzung: ctpkg [install|remove] <name>" ;;
esac
EOF
fi

# Mach alles ausführbar
chmod +x "$BIN_DIR/ctpkg"

echo "✅ CTPKG erfolgreich installiert!"
echo "👉 Nutze: ctpkg install <paketname>"
echo "👉 oder: ctpkg remove <paketname>"