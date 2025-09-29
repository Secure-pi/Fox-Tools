# 🦈 WIRESHARK - GUIDE COMPLET RED TEAM

## 📋 INTRODUCTION
Wireshark est l'analyseur de protocole réseau le plus utilisé au monde. Il permet de capturer et d'inspecter le trafic sur un réseau en temps réel ou depuis un fichier de capture (`.pcap`). `tshark` est sa version en ligne de commande.

## 🎯 CAPTURE DE TRAFIC
- **GUI (Wireshark)**: Sélectionnez une interface (ex: `eth0`, `wlan0`) et cliquez sur l'icône en forme d'aileron de requin pour démarrer.
- **CLI (TShark)**:
  ```bash
  # Capturer 1000 paquets sur l'interface eth0 et sauvegarder dans un fichier
  sudo tshark -i eth0 -c 1000 -w capture.pcap

  # Capturer pendant 60 secondes
  sudo tshark -i eth0 -a duration:60 -w capture.pcap
  ```

## 🔥 FILTRES
Il existe deux types de filtres : les filtres de **capture** (avant que les paquets ne soient enregistrés) et les filtres d'**affichage** (pour analyser une capture existante).

### Filtres de Capture (Syntaxe BPF)
Utilisés pour réduire la taille des captures.
```bash
# Ne capturer que le trafic de/vers un hôte spécifique
host 192.168.1.100

# Ne capturer que le trafic sur un port
port 80

# Combinaison
tcp and port 80 and host 192.168.1.100
```

### Filtres d'Affichage (Plus puissants)
Utilisés dans la barre de filtre de Wireshark pour analyser les données.
- **Par IP**: `ip.addr == 192.168.1.100`, `ip.src == ...`, `ip.dst == ...`
- **Par Port**: `tcp.port == 80`, `udp.port == 53`
- **Par Protocole**: `http`, `dns`, `ftp`, `ssh`, `icmp`
- **Combinaisons logiques**: `(ip.addr == 1.1.1.1) and (tcp.port == 443)`

## 🚀 ANALYSE DE SÉCURITÉ

### Recherche d'Identifiants en Clair
De nombreux protocoles plus anciens transmettent les mots de passe en clair.
- **FTP**: `ftp.request.command == "PASS"`
- **Telnet**: `telnet.data contains "password"`
- **HTTP Basic Auth**: `http.authbasic`
- **POP3**: `pop.request.command == "PASS"`

### Détection d'Activités Suspectes
- **Outils de pentest**: `http.user_agent contains "sqlmap"` ou `"nmap"`
- **Ports de reverse shells**: `tcp.port == 4444` ou `tcp.port == 1337`
- **Requêtes DNS inhabituelles**: `dns.qry.name matches "[0-9a-f]{20,}"` (pour la détection de DGA - Domain Generation Algorithms)

## 🎭 FOLLOW STREAMS
C'est l'une des fonctionnalités les plus utiles pour reconstituer une conversation complète entre deux hôtes.
- **Dans la GUI**: Clic droit sur un paquet → `Follow` → `TCP Stream` (ou `HTTP Stream`, etc.).
- **En CLI avec TShark**:
  ```bash
  tshark -r capture.pcap -z follow,tcp,ascii,0
  ```
  *Affiche le contenu de la première conversation TCP.*

## 📊 EXPORTATION & EXTRACTION
- **Exporter des objets HTTP**: `File` → `Export Objects` → `HTTP`. Permet de sauvegarder des images, des scripts, des exécutables, etc., qui ont été transférés via HTTP.
- **Exporter en CSV**: `File` → `Export Packet Dissections` → `As CSV...`.

## 🛡️ DÉCRYPTAGE TLS/SSL
Pour analyser le trafic chiffré, vous avez besoin des clés de session.
1.  **Configurer votre navigateur**: Définissez une variable d'environnement `SSLKEYLOGFILE` qui pointe vers un fichier texte.
    ```bash
    export SSLKEYLOGFILE=~/ssl_keys.log
    ```
2.  Lancez votre navigateur depuis le même terminal.
3.  **Dans Wireshark**: Allez dans `Edit` → `Preferences` → `Protocols` → `TLS` et indiquez le chemin vers votre fichier de log de clés (`(Pre)-Master-Secret log filename`).

---
> ⚠️ **LÉGALITÉ** : La capture et l'analyse de trafic réseau sont soumises à des lois strictes. N'effectuez ces opérations que sur des réseaux que vous possédez ou pour lesquels vous avez une autorisation explicite.
