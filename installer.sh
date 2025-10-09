#!/bin/bash
# 🌐 CTPKG INSTALLER
# Erstellt von Anton 💻

echo "🚀 Installiere CTPKG Paket-System..."

# Installationspfad (für Termux)
BIN_DIR="/data/data/com.termux/files/usr/bin"

# Erstelle den Hauptordner, falls er fehlt
mkdir -p "$BIN_DIR"

# Lade den Haupt-Installer (ctpkg)
echo "⬇️ Lade Haupt-Installer von GitHub oder deinem Repo..."
curl -s -o "$BIN_DIR/ctpkg" "https://ctpkgdata.pages.dev/ctpkg.sh"

# Falls kein ctpkg.sh existiert, leg Standardcode an
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
    if curl --head --silent --fail "$REPO/$name.sh" > /dev/null; then
        echo "⬇️ Lade $name herunter..."
        curl -s -o "$BIN_DIR/$name" "$REPO/$name.sh"
        chmod +x "$BIN_DIR/$name"
        echo "✅ $name wurde installiert!"
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