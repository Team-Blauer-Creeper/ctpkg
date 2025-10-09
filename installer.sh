#!/bin/bash

# 🌐 Dein Online-Repository
REPO="https://ctpkgdata.pages.dev"

# 📦 Installationspfad
BIN_DIR="/data/data/com.termux/files/usr/bin"

# 🔧 Paket installieren
install_pkg() {
    name="$1"
    if [ -z "$name" ]; then
        echo "❌ Kein Paketname angegeben."
        exit 1
    fi

    echo "🔍 Suche $name.sh im Repository..."
    if curl --head --silent --fail "$REPO/$name.sh" > /dev/null; then
        echo "⬇️ Lade $name herunter..."
        curl -s -o "$BIN_DIR/$name" "$REPO/$name.sh"
        chmod +x "$BIN_DIR/$name"
        echo "✅ Paket '$name' wurde erfolgreich installiert!"
    else
        echo "❌ Paket '$name' wurde nicht gefunden!"
    fi
}

# 🗑️ Paket deinstallieren
remove_pkg() {
    name="$1"
    if [ -f "$BIN_DIR/$name" ]; then
        rm -f "$BIN_DIR/$name"
        echo "🗑️  Paket '$name' wurde deinstalliert."
    else
        echo "❌ Paket '$name' ist nicht installiert."
    fi
}

# 📚 Hilfe
help_menu() {
    echo "📦 ctpkg - dein Paket-System"
    echo "-----------------------------"
    echo "ctpkg install <name>   → Installiert ein Paket"
    echo "ctpkg remove <name>    → Deinstalliert ein Paket"
    echo "ctpkg help             → Zeigt diese Hilfe"
    echo
    echo "🔹 Pakete werden von $REPO geladen"
}

# ⚙️ Befehlsauswertung
case "$1" in
  install) install_pkg "$2" ;;
  remove) remove_pkg "$2" ;;
  help|"") help_menu ;;
  *) echo "❌ Unbekannter Befehl. Nutze 'ctpkg help'" ;;
esac