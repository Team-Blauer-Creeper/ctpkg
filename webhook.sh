cat > $PREFIX/bin/whset <<'EOF'
#!/bin/bash
# 🔧 Webhook speichern
mkdir -p ~/.config/wh
echo "$1" > ~/.config/wh/url
echo "✅ Webhook gespeichert!"
EOF

cat > $PREFIX/bin/wh <<'EOF'
#!/bin/bash
# 💬 Nachricht senden
url=$(cat ~/.config/wh/url 2>/dev/null)
if [ -z "$url" ]; then
  echo "❌ Kein Webhook gesetzt! Bitte zuerst: whset <url>"
  exit 1
fi
curl -s -H "Content-Type: application/json" \
 -d "{\"content\":\"$*\"}" "$url" > /dev/null \
 && echo "✅ Nachricht gesendet!" || echo "⚠️ Fehler beim Senden!"
EOF

chmod +x $PREFIX/bin/wh $PREFIX/bin/whset
echo "🎉 wh & whset installiert!"