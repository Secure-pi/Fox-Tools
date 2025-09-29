# 🐉 Hydra : Le Monstre à Plusieurs Têtes du Brute-Force

Hydra est un outil de brute-force en ligne, parallèle et très rapide. Son but est de deviner des mots de passe pour s'authentifier sur une multitude de services réseau.

Pensez-y comme un voleur de banque mythologique qui peut essayer des milliers de combinaisons sur des milliers de coffres-forts simultanément.

---

### 🎯 **Objectif Principal**

Hydra tente de se connecter à un service (SSH, FTP, HTTP, etc.) en essayant une liste de noms d'utilisateurs et de mots de passe jusqu'à ce qu'il trouve une combinaison valide.

**⚠️ Avertissement Éthique :** N'utilisez Hydra que sur des systèmes pour lesquels vous avez une autorisation explicite. Tenter de brute-forcer un système sans permission est illégal.

---

### 🛠️ **Les Recettes Essentielles d'Hydra**

Hydra peut sembler complexe, mais sa syntaxe suit toujours le même modèle.

#### 1. Brute-Force SSH : "Sésame, ouvre-toi !"

C'est l'un des usages les plus courants : trouver le mot de passe d'un utilisateur sur un service SSH.

```bash
# Tente de trouver le mot de passe pour l'utilisateur 'root' sur la machine 192.168.1.10
hydra -l root -P /usr/share/wordlists/rockyou.txt ssh://192.168.1.10
```

*   `-l root` : Spécifie un seul nom d'utilisateur (`login`).
*   `-P rockyou.txt` : Spécifie une liste de mots de passe (`Password list`).
*   `ssh://192.168.1.10` : Spécifie le service (`ssh`) et la cible.

#### 2. Brute-Force FTP avec une liste d'utilisateurs

Parfois, vous avez une liste d'utilisateurs potentiels et une liste de mots de passe.

```bash
# Utilise une liste d'utilisateurs et une liste de mots de passe pour un service FTP
hydra -L users.txt -P passwords.txt ftp://192.168.1.10
```

*   `-L users.txt` : Spécifie une liste de noms d'utilisateurs (`Login list`).

#### 3. Brute-Force d'un Formulaire Web (HTTP POST)

C'est une technique très puissante. Hydra peut simuler l'envoi d'un formulaire de connexion sur une page web.

```bash
# Exemple pour un formulaire de connexion simple
hydra -l admin -P passwords.txt 192.168.1.10 http-post-form "/login.php:username=^USER^&password=^PASS^:F=Invalid username or password"
```

*   `http-post-form` : Le nom du module Hydra pour les formulaires POST.
*   `"/login.php:..."` : C'est la partie la plus importante.
    *   `/login.php` : L'URL de la page de connexion.
    *   `username=^USER^&password=^PASS^` : La structure des données du formulaire. Hydra remplacera `^USER^` par le login et `^PASS^` par le mot de passe.
    *   `:F=Invalid...` : Le message d'échec. Hydra sait qu'une tentative a échoué s'il voit ce texte dans la réponse de la page.

---

### ✨ **Astuces de Pro**

*   **Vitesse et Parallélisme (`-t`)** : Comme Gobuster, vous pouvez spécifier le nombre de tâches parallèles. Pour les services web, restez bas (ex: `-t 4`) pour ne pas surcharger le serveur. Pour des services robustes comme SSH, vous pouvez augmenter (`-t 16`).

*   **Verbosité (`-V`)** : Utilisez l'option `-V` pour qu'Hydra vous montre chaque tentative de connexion en temps réel. C'est très utile pour déboguer.

*   **Stopper dès qu'un mot de passe est trouvé (`-f`)** : Si vous cherchez le mot de passe pour un seul utilisateur, utilisez `-f` pour qu'Hydra s'arrête dès qu'il a trouvé la bonne combinaison.

*   **Spécifier un port non standard** : Si un service ne tourne pas sur son port par défaut, utilisez l'option `-s`.
    ```bash
    # Tente un brute-force SSH sur le port 2222
    hydra -l user -P pass.txt -s 2222 ssh://192.168.1.10
    ```

*   **Sauvegarder la sortie (`-o`)** : Très important pour ne pas perdre les mots de passe trouvés !
    ```bash
    hydra ... -o hydra_results.txt
    ```

---

Hydra est un outil incroyablement versatile. La clé de son succès est de bien comprendre le service que vous attaquez et, bien sûr, d'utiliser des wordlists de bonne qualité. Prenez le temps de lire son aide (`hydra -h`) pour voir la liste impressionnante de services qu'il supporte.
