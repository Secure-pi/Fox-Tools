# Tutoriel : Gobuster

Gobuster est un outil de brute-force ultra-rapide écrit en Go. Sa mission principale est de découvrir des contenus cachés sur des serveurs web, comme des pages d'administration, des fichiers de sauvegarde ou des API non documentées.

---

## Le Mode `dir` : Trouver les Répertoires et Fichiers

C'est le mode le plus utilisé. Il prend une liste de mots (une "wordlist") et essaie chaque mot comme un chemin sur le serveur cible pour voir s'il existe.

### Utilisation de base

```bash
# Scan de répertoires avec une wordlist commune
gobuster dir -u http://<IP_CIBLE> -w /usr/share/wordlists/dirb/common.txt
```

- `-u` : L'URL du site à scanner.
- `-w` : Le chemin vers la wordlist. Le choix de la wordlist est crucial !

### Aller plus loin

```bash
# Scan plus rapide avec 50 threads (processus simultanés)
gobuster dir -u http://<IP_CIBLE> -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -t 50

# Chercher des fichiers avec des extensions spécifiques (ex: .php, .txt)
gobuster dir -u http://<IP_CIBLE> -w /usr/share/wordlists/dirb/common.txt -x .php,.txt,.bak
```

- `-t` : Nombre de threads. Augmenter cette valeur accélère le scan, mais peut surcharger le serveur ou vous faire détecter.
- `-x` : Spécifie les extensions de fichiers à tester pour chaque mot de la wordlist.

---

## Autres Modes Utiles

-   **Mode `dns`** : Utilise une wordlist pour trouver des sous-domaines (ex: `admin.example.com`, `api.example.com`).
    ```bash
    gobuster dns -d example.com -w /path/to/subdomains.txt
    ```
-   **Mode `vhost`** : Tente de trouver des hôtes virtuels configurés sur le serveur web.

---

### 💡 L'Aide du Copilote

Dans le menu `Web > Directory/File Discovery`, le script vous assiste à plusieurs niveaux :

1.  **Sélection de la Cible :** Comme pour WhatWeb, le copilote vous propose une liste des cibles web (HTTP/HTTPS) déjà découvertes, vous évitant de retaper les URL.
2.  **Sélection de la Wordlist :** Le script vous propose un choix de wordlists (rapide, moyenne, complète) pour que vous n'ayez pas à mémoriser leurs chemins.
3.  **Lancement Automatisé :** Une fois la cible et la wordlist choisies, le script lance Gobuster avec les bonnes options et sauvegarde les résultats pour vous.

**Avantage :** Le copilote transforme une commande potentiellement longue et sujette aux erreurs en un simple dialogue interactif. Il vous guide pour choisir les bons outils pour la tâche à accomplir.