# 🚧 Gobuster : Le Bulldozer à la recherche de trésors cachés

Gobuster est un outil de brute-force ultra-rapide écrit en Go. Son but principal est de découvrir des URL (dossiers et fichiers) et des sous-domaines cachés sur des serveurs web. 

Pensez-y comme un agent qui essaie des milliers de clés sur des milliers de portes pour voir lesquelles s'ouvrent.

---

### 🎯 **Objectif Principal**

Sur un site web, de nombreux fichiers et dossiers ne sont pas directement liés depuis la page d'accueil (ex: pages d'administration, fichiers de sauvegarde, API internes). Gobuster utilise des listes de mots (wordlists) pour deviner les noms de ces ressources et vous révéler ce qui est caché.

---

### 🛠️ **Les Modes Essentiels de Gobuster**

Gobuster a plusieurs modes, mais deux sont absolument fondamentaux.

#### 1. Mode `dir` : La Chasse aux Dossiers et Fichiers

C'est le mode le plus utilisé. Il cherche des répertoires et des fichiers sur un site web.

```bash
# Scan de répertoires basique
gobuster dir -u http://example.com -w /usr/share/wordlists/dirb/common.txt
```

*   `dir` : Spécifie le mode de brute-force de répertoires.
*   `-u` : L'URL de la cible.
*   `-w` : Le chemin vers la "wordlist" (le dictionnaire de noms à essayer).

**Ajouter des extensions de fichiers**

Souvent, vous ne cherchez pas que des dossiers, mais aussi des fichiers avec des extensions spécifiques (`.php`, `.txt`, `.bak`, etc.).

```bash
# Cherche des fichiers PHP, TXT et des sauvegardes (.bak)
gobuster dir -u http://example.com -w /usr/share/wordlists/dirb/common.txt -x php,txt,bak
```

*   `-x` : Permet de spécifier une liste d'extensions à ajouter à chaque mot de la wordlist.

#### 2. Mode `dns` : La Chasse aux Sous-domaines

Ce mode utilise une wordlist pour deviner les sous-domaines d'un domaine principal (ex: `admin.example.com`, `api.example.com`).

```bash
# Scan de sous-domaines
gobuster dns -d example.com -w /usr/share/wordlists/seclists/Discovery/DNS/subdomains-top1million-5000.txt
```

*   `dns` : Spécifie le mode de brute-force DNS.
*   `-d` : Le domaine cible (sans `http://`).
*   `-w` : Une wordlist de sous-domaines courants.

---

### ✨ **Astuces de Pro**

*   **Le choix de la Wordlist est CRUCIAL** : La qualité de votre scan dépend à 90% de la qualité de votre wordlist. Le projet **SecLists** (souvent dans `/usr/share/seclists`) est la référence absolue et contient des listes pour toutes les situations.

*   **Augmenter la vitesse (avec prudence)** : Gobuster est déjà très rapide, mais vous pouvez augmenter le nombre de threads (processus simultanés) avec l'option `-t`.
    ```bash
    # Utilise 50 threads au lieu des 10 par défaut
    gobuster dir -u http://example.com -w ... -t 50
    ```
    **Attention :** Un nombre trop élevé de threads peut faire tomber le serveur cible ou vous faire bannir.

*   **Filtrer par code de statut HTTP** : Parfois, un site renvoie un code `200 OK` pour des pages qui n'existent pas vraiment. Vous pouvez demander à Gobuster de ne vous montrer que certains codes.
    ```bash
    # Ne montre que les pages avec les codes 200, 204, 301, 302, 307
    gobuster dir -u http://example.com -w ... -s 200,204,301,302,307
    ```

*   **Sauvegarder la sortie** : Pour ne pas perdre vos résultats.
    ```bash
    gobuster dir -u http://example.com -w ... -o gobuster_results.txt
    ```

---

Gobuster est un outil simple en apparence, mais sa puissance réside dans sa vitesse et sa flexibilité. Maîtrisez ses modes et, surtout, apprenez à connaître vos wordlists, et vous découvrirez des pans cachés du web.
