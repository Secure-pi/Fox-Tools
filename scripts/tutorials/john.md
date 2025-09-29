# Tutoriel : John the Ripper (John)

John the Ripper, souvent appelé simplement "John", est l'un des outils de craquage de mots de passe hors ligne les plus connus et les plus polyvalents. Son travail consiste à prendre un fichier contenant des "hashes" de mots de passe et à essayer de retrouver les mots de passe en clair correspondants.

---

## Qu'est-ce qu'un Hash ?

Un hash est une empreinte numérique d'un mot de passe. Les systèmes ne stockent (normalement) pas vos mots de passe en clair, mais plutôt leur hash. Quand vous vous connectez, le système hashe le mot de passe que vous avez tapé et le compare au hash stocké. C'est une mesure de sécurité.

Le but de John est de prendre un hash (ex: `5f4dcc3b5aa765d61d8327deb882cf99`) et de retrouver le mot de passe original (ex: `password`).

---

## Utilisation et Exemples

Le flux de travail est généralement le suivant : obtenir un fichier de hashes, puis lancer John dessus.

### Étape 1 : Obtenir les hashes

Vous pouvez les obtenir de plusieurs manières :
- Depuis un fichier `/etc/shadow` sur un système Linux.
- Depuis une base de données compromise.
- Capturés lors d'une attaque réseau.

Souvent, vous devrez utiliser un outil comme `unshadow` pour combiner `/etc/passwd` et `/etc/shadow` dans un format que John comprend.

### Étape 2 : Lancer John

```bash
# Lancer John en mode simple (utilise des règles de mutation de base)
john hashes.txt

# Utiliser une wordlist (liste de mots de passe potentiels)
john --wordlist=/usr/share/wordlists/rockyou.txt hashes.txt

# Spécifier un format de hash (si John ne le devine pas)
john --format=NT --wordlist=... hashes_windows.txt
```

### Étape 3 : Voir les résultats

John sauvegarde les mots de passe qu'il a crackés dans un fichier appelé "pot file" (`~/.john/john.pot` par défaut).

```bash
# Afficher les mots de passe crackés pour un fichier de hash donné
john --show hashes.txt
```

---

### 💡 L'Aide du Copilote

Le menu `Password Attacks > John The Ripper` est conçu pour vous assister à chaque étape.

1.  **Sélection du Fichier de Hashes :** Le copilote vous aide à trouver et à sélectionner votre fichier de hashes directement depuis votre projet, en affichant les fichiers les plus récents en premier.
2.  **Sélection Guidée de la Wordlist :** Plus besoin de connaître les chemins par cœur. Le script vous propose un menu pour choisir entre les wordlists les plus communes (`fasttrack.txt`, `rockyou.txt`) ou spécifier un chemin personnalisé.
3.  **Gestion du Pot File :** C'est un avantage majeur. Le copilote crée un `john.pot` **spécifique à votre projet** (`projects/VOTRE_CIBLE/exploits/john.pot`). Cela garde les mots de passe crackés organisés par projet et évite les conflits.
4.  **Affichage Automatique :** Une fois l'attaque terminée, le script lance automatiquement la commande `john --show` pour vous montrer immédiatement les résultats, sans que vous ayez à la taper.

**Avantage :** Le copilote structure votre attaque, gère l'organisation des fichiers pour vous, et vous présente les résultats de manière proactive, rendant le processus de craquage hors ligne beaucoup plus fluide.
