#!/data/data/com.termux/files/usr/bin/bash
set -e
echo "[*] Fake Boot Installer for Termux"

# 1️⃣ Ordner erstellen
mkdir -p ~/.fakeboot
echo "[✓] Folder created: ~/.fakeboot"

# 2️⃣ Fake Boot Script
cat > ~/.fakeboot/boot.sh <<'EOF'
#!/data/data/com.termux/files/usr/bin/bash
clear
echo "Android Bootloader v2.1"
sleep 0.4
for i in {1..25}; do
  printf "[ OK ] Initializing service %02d\n" "$i"
  sleep 0.12
done
echo "[ OK ] Mounting /system"
sleep 0.4
echo "[ OK ] SELinux: permissive"
sleep 0.4
echo "[ OK ] Root access granted"
sleep 0.6
echo
echo "root@android:~#"
EOF

chmod +x ~/.fakeboot/boot.sh
echo "[✓] Fake Boot script created"

# 3️⃣ Auto-Start in .bashrc setzen
if ! grep -q fakeboot "$HOME/.bashrc"; then
  echo "" >> ~/.bashrc
  echo "# Fake Boot Auto Start" >> ~/.bashrc
  echo "if [ -f ~/.fakeboot/boot.sh ]; then" >> ~/.bashrc
  echo "    ~/.fakeboot/boot.sh" >> ~/.bashrc
  echo "fi" >> ~/.bashrc
  echo "[✓] Auto-start added to .bashrc"
else
  echo "[i] Auto-start already exists in .bashrc"
fi

# 4️⃣ Optional: tmux Grid Setup
cat > ~/.fakeboot/grid.sh <<'EOF'
#!/data/data/com.termux/files/usr/bin/bash
tmux new-session -d -s hacker
tmux split-window -h -t hacker
tmux split-window -v -t hacker:0.0
tmux split-window -v -t hacker:0.1
tmux send-keys -t hacker:0.0 "neofetch" C-m
tmux send-keys -t hacker:0.1 "while true; do echo '[SCAN] 192.168.0.$RANDOM'; sleep 0.1; done" C-m
tmux send-keys -t hacker:0.2 "top" C-m
tmux send-keys -t hacker:0.3 "bash" C-m
tmux attach -t hacker
EOF
chmod +x ~/.fakeboot/grid.sh
echo "[✓] tmux Grid script created (~/.fakeboot/grid.sh)"

echo "[✓] Installation complete!"
echo "Run ~/fakeboot/start.sh or reopen Termux for auto-start"