#!/data/data/com.termux/files/usr/bin/bash

# ===== PROMPT & LOOK =====
cat >> ~/.bashrc <<'EOF'

# Cinema clean prompt
PS1='\[\033[1;32m\]termux@node\[\033[0m\]:\[\033[1;34m\]\w\[\033[0m\]$ '

clear
echo -e "\033[1;32mnode-access shell initialized\033[0m"
echo
EOF

# ===== CINEMA COMMAND =====
cat > $PREFIX/bin/starthack <<'EOF'
#!/data/data/com.termux/files/usr/bin/bash

G="\033[1;32m"
Y="\033[1;33m"
R="\033[1;31m"
B="\033[1;34m"
END="\033[0m"

clear
echo -e "${G}node-access v2.8${END}"
sleep 0.6

echo -e "${B}[INIT] loading runtime modules${END}"
sleep 0.4
echo -e "${B}[INIT] sync interfaces${END}"
sleep 0.4
echo -e "${G}[OK] environment ready${END}"
sleep 0.6

echo
echo -e "${B}[SCAN] mapping nearby nodes${END}"
sleep 0.6
echo "ID        SIGNAL   MODE"
echo "A91F      -42      secure"
echo "B77C      -61      secure"
echo "C102      -79      open"
sleep 0.8

echo
echo -e "${Y}[LOCK] target node selected${END}"
sleep 0.6

echo -e "${B}[SYNC] negotiating session keys${END}"
sleep 0.6
echo -e "${B}[SYNC] handshake complete${END}"
sleep 0.6

echo
echo -e "${B}[PROCESS] executing access routine${END}"
for p in 14 29 41 58 73 86 100; do
  echo -e "${Y}progress $p%${END}"
  sleep 0.5
done

echo
echo -e "${R}[STATUS] elevated session granted${END}"
sleep 0.6
echo -e "${G}[STREAM] data channel active${END}"
sleep 0.4

for i in 1 2 3 4 5; do
  echo "[STREAM] packet $i received"
  sleep 0.35
done

echo
echo -e "${G}session closed normally${END}"
EOF

chmod +x $PREFIX/bin/starthack

echo "installed"