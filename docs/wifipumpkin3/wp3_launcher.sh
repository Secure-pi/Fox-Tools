#!/bin/bash
# WiFi-Pumpkin3 Quick Launcher

echo "🍃 WIFI-PUMPKIN3 LAUNCHER 🍃"
echo "=========================="

if [[ $EUID -ne 0 ]]; then
   echo "❌ Ce script doit être lancé en root (sudo)"
   exit 1
fi

cd /opt/wifipumpkin3

echo "🎯 Options disponibles:"
echo "1) Console interactive"
echo "2) Interface graphique"
echo "3) Mode standard"
echo "4) Aide"

read -p "Choix (1-4): " choice

case $choice in
    1)
        echo "🚀 Lancement console..."
        ./venv/bin/python -c "
import sys
sys.path.insert(0, '.')
from wifipumpkin3 import PumpkinShell
shell = PumpkinShell()
shell.cmdloop()
"
        ;;
    2)
        echo "🖥️ Lancement GUI..."
        ./venv/bin/python -m wifipumpkin3 --xpulp
        ;;
    3)
        echo "💻 Mode standard..."
        ./venv/bin/python -m wifipumpkin3
        ;;
    4)
        echo "📋 Aide..."
        ./venv/bin/python -m wifipumpkin3 --help
        ;;
    *)
        echo "❌ Choix invalide"
        ;;
esac
