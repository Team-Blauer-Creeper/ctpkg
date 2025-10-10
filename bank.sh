#!/bin/bash
# bank.sh – simples Banksystem für Termux

bankfile="bankdata.txt"

# Datei erstellen falls nicht existiert
[ ! -f "$bankfile" ] && touch "$bankfile"

function list_bank() {
  if [ ! -s "$bankfile" ]; then
    echo "Keine Benutzer vorhanden."
  else
    echo "=== Bankkonto-Liste ==="
    cat "$bankfile"
  fi
}

function add_money() {
  user=$1
  amount=$2
  if grep -q "^$user:" "$bankfile"; then
    oldmoney=$(grep "^$user:" "$bankfile" | cut -d':' -f2)
    newmoney=$((oldmoney + amount))
    sed -i "s/^$user:.*/$user:$newmoney/" "$bankfile"
    echo "$amount€ zu $user hinzugefügt (jetzt $newmoney€)"
  else
    echo "$user:$amount" >> "$bankfile"
    echo "Neuer Nutzer $user mit $amount€ erstellt."
  fi
}

function remove_money() {
  user=$1
  amount=$2
  if grep -q "^$user:" "$bankfile"; then
    oldmoney=$(grep "^$user:" "$bankfile" | cut -d':' -f2)
    newmoney=$((oldmoney - amount))
    [ $newmoney -lt 0 ] && newmoney=0
    sed -i "s/^$user:.*/$user:$newmoney/" "$bankfile"
    echo "$amount€ von $user entfernt (jetzt $newmoney€)"
  else
    echo "Fehler: Benutzer $user existiert nicht."
  fi
}

function del_user() {
  user=$1
  if grep -q "^$user:" "$bankfile"; then
    sed -i "/^$user:/d" "$bankfile"
    echo "Benutzer $user gelöscht."
  else
    echo "Fehler: Benutzer $user existiert nicht."
  fi
}

function reset_system() {
  echo "" > "$bankfile"
  echo "Banksystem wurde zurückgesetzt."
}

function delete_system() {
  rm -f "$bankfile"
  echo "Banksystem vollständig gelöscht (Datei entfernt)."
}

case "$1" in
  list)
    list_bank
    ;;
  add)
    add_money "$2" "$3"
    ;;
  remove)
    remove_money "$2" "$3"
    ;;
  deluser)
    del_user "$2"
    ;;
  reset)
    reset_system
    ;;
  deletesystem)
    delete_system
    ;;
  *)
    echo "Benutzung:"
    echo "bank list                      - Zeigt alle Nutzer"
    echo "bank add <user> <betrag>       - Fügt Geld hinzu oder erstellt Nutzer"
    echo "bank remove <user> <betrag>    - Entfernt Geld"
    echo "bank deluser <user>            - Löscht einen Nutzer"
    echo "bank reset                     - Setzt alle Daten zurück"
    echo "bank deletesystem              - Löscht das ganze System"
    ;;
esac