#!/usr/bin/env bash
# mc-color.sh - Minecraft-Farbcode-Support (&a, &b, &c, usw.)

# Map für Farbcodes nach Minecraft-Stil
declare -A colors=(
  ["0"]="\e[30m"  # schwarz
  ["1"]="\e[34m"  # dunkelblau
  ["2"]="\e[32m"  # dunkelgrün
  ["3"]="\e[36m"  # türkis
  ["4"]="\e[31m"  # dunkelrot
  ["5"]="\e[35m"  # lila
  ["6"]="\e[33m"  # gold
  ["7"]="\e[37m"  # hellgrau
  ["8"]="\e[90m"  # dunkelgrau
  ["9"]="\e[94m"  # blau
  ["a"]="\e[92m"  # hellgrün
  ["b"]="\e[96m"  # helltürkis
  ["c"]="\e[91m"  # hellrot
  ["d"]="\e[95m"  # rosa
  ["e"]="\e[93m"  # gelb
  ["f"]="\e[97m"  # weiß
  ["r"]="\e[0m"   # reset
  ["l"]="\e[1m"   # fett
  ["n"]="\e[4m"   # unterstrichen
  ["o"]="\e[3m"   # kursiv
  ["m"]="\e[9m"   # durchgestrichen
)

# Eingabe lesen (Pipe oder Parameter)
input=""
if [ -t 0 ]; then
  input="$*"
else
  input="$(cat)"
fi

# Ersetzung: &a -> ANSI-Farben
for code in "${!colors[@]}"; do
  input=$(echo -e "$input" | sed "s/&$code/${colors[$code]//\\/\\\\}/g")
done

# Reset am Ende
echo -e "$input\e[0m"