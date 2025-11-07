#!/bin/bash
# ctpkg installer for lolcat
# Autor: Anton & ChatGPT 😎
# Beschreibung: Installiert lolcat (bunte Textausgabe)

echo "[ctpkg] Installing lolcat..."

# Installationspfad
INSTALL_DIR="$PREFIX/bin"
SCRIPT_NAME="lolcat"
SCRIPT_PATH="$INSTALL_DIR/$SCRIPT_NAME"

# Falls Ordner fehlt
mkdir -p "$INSTALL_DIR"

# lolcat Script erstellen
cat > "$SCRIPT_PATH" << 'EOF'
#!/usr/bin/env bash
# lolcat - simple rainbow text

colors=(196 202 226 82 45 93)   # red, orange, yellow, green, cyan, magenta
c_len=${#colors[@]}
idx=0

while IFS= read -r -n1 ch || [ -n "$ch" ]; do
  if [ "$ch" = $'\n' ]; then
    printf "\n"
  else
    printf "\e[38;5;%sm%s\e[0m" "${colors[$((idx % c_len))]}" "$ch"
    ((idx++))
  fi
done
EOF

# Rechte setzen
chmod +x "$SCRIPT_PATH"

echo "[ctpkg] ✅ lolcat installed successfully!"
echo "Usage example: echo 'Hello Anton 😎' | lolcat"