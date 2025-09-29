# 🃏 John the Ripper : Le Briseur de Mots de Passe

John the Ripper (souvent appelé "John" ou "JtR") est un célèbre cracker de mots de passe. À l'origine conçu pour les hashs de mots de passe Unix, il supporte aujourd'hui des centaines de types de hashs et de chiffrements.

Pensez-y comme un artisan serrurier qui, au lieu de clés physiques, utilise des dictionnaires et des règles pour forger la clé numérique parfaite.

---

### 🎯 **Objectif Principal**

Le but de John est de prendre un "hash" (une version chiffrée d'un mot de passe) et de trouver le mot de passe en clair qui lui correspond. Il ne "casse" pas le chiffrement, il essaie des milliers de possibilités jusqu'à trouver la bonne.

---

### 🛠️ **Le Processus avec John the Ripper**

Le travail avec John se fait généralement en deux ou trois étapes.

#### Étape 1 : Préparer le Fichier de Hashs

John a besoin d'un fichier contenant un ou plusieurs hashs à cracker. Souvent, ces hashs sont extraits de fichiers système (`/etc/shadow`), de bases de données ou interceptés sur le réseau.

Pour les hashs Linux, John fournit un outil appelé `unshadow` pour combiner les fichiers `/etc/passwd` et `/etc/shadow` dans un format qu'il comprend.

```bash
# Crée un fichier 'my_hashes.txt' prêt à être cracké
unshadow /etc/passwd /etc/shadow > my_hashes.txt
```

Pour d'autres types de hashs (MD5, SHA256, etc.), il suffit de les mettre dans un fichier texte, un par ligne.

#### Étape 2 : Lancer l'Attaque

John possède plusieurs modes d'attaque. Voici les plus importants.

**1. Mode Simple (par défaut)**

Ce mode est très basique et essaie des variations du nom d'utilisateur et d'autres informations simples. C'est rapide mais peu efficace.

```bash
john my_hashes.txt
```

**2. Mode Dictionnaire (le plus courant)**

C'est le mode le plus puissant. Vous fournissez une liste de mots de passe potentiels (une "wordlist") et John les essaie tous.

```bash
# Utilise la célèbre wordlist 'rockyou.txt'
john --wordlist=/usr/share/wordlists/rockyou.txt my_hashes.txt
```

*   `--wordlist=...` : Spécifie le chemin vers votre dictionnaire.

**3. Mode Incrémental (la force brute pure)**

Si le dictionnaire échoue, ce mode va essayer toutes les combinaisons de caractères possibles. C'est **extrêmement lent** et n'est utilisé qu'en dernier recours.

```bash
# Tente une attaque de force brute sur les hashs
john --incremental my_hashes.txt
```

#### Étape 3 : Afficher les Mots de Passe Trouvés

Une fois que John a trouvé un mot de passe, il le sauvegarde dans un fichier appelé `john.pot` (le "pot de miel"). Vous n'avez pas besoin de relancer l'attaque pour voir ce qu'il a trouvé.

```bash
# Affiche les mots de passe déjà crackés pour ce fichier de hashs
john --show my_hashes.txt
```

---

### ✨ **Astuces de Pro**

*   **Spécifier le format du hash (`--format`)** : Parfois, John a du mal à deviner le type de hash. Vous pouvez l'aider.
    ```bash
    # Force John à traiter les hashs comme du NTLM (hash Windows)
    john --format=NT --wordlist=... my_hashes.txt
    ```

*   **Utiliser les Règles de Mangle (`--rules`)** : C'est la fonctionnalité la plus puissante de John. Les règles permettent de muter les mots de votre dictionnaire. Par exemple, si votre dictionnaire contient "password", les règles vont automatiquement essayer "Password", "p@ssword", "password123", etc. Cela augmente considérablement vos chances.
    ```bash
    # Active les règles par défaut avec une wordlist
    john --wordlist=... --rules my_hashes.txt
    ```

*   **Utiliser plusieurs cœurs CPU (`--fork`)** : Pour accélérer le processus, vous pouvez dire à John d'utiliser plusieurs cœurs de votre processeur.
    ```bash
    # Lance 4 processus John en parallèle
    john --fork=4 --wordlist=... my_hashes.txt
    ```

---

John the Ripper est un outil classique qui reste incroyablement pertinent. Sa force ne réside pas dans une interface graphique tape-à-l'œil, mais dans la puissance brute de ses modes d'attaque et, surtout, de son moteur de règles. Apprendre à combiner des wordlists de qualité avec des règles de mutation est la clé pour devenir un expert du cassage de mots de passe.
