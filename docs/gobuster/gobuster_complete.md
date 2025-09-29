# 🔍 Gobuster : Le Guide Pratique

Gobuster est un outil ultra-rapide pour le brute-force. Il est parfait pour découvrir des contenus cachés sur des serveurs web (dossiers, fichiers) ou pour énumérer des sous-domaines.

## 🔥 Le Mode `dir` : Trouver les Dossiers et Fichiers Cachés

C'est le mode que vous utiliserez le plus souvent. L'objectif est de tester une liste de noms possibles (une "wordlist") contre une URL pour voir lesquels existent.

### Les Commandes Essentielles

| Commande | Description |
|---|---|
| `gobuster dir -u <URL> -w <wordlist>` | **La base.** Lance un scan de répertoires sur l'URL avec la wordlist fournie. |
| `... -x php,html,txt` | **Ajouter des extensions.** Très utile pour trouver des fichiers comme `config.php` ou `backup.txt`. |
| `... -t 50` | **Accélérer le scan.** Augmente le nombre de threads (processus simultanés). 50 est une bonne valeur pour commencer. |
| `... -s 200,204,301,302` | **Filtrer par statut.** N'affiche que les codes de statut HTTP intéressants (OK, No Content, Redirections). |
| `... -o resultats.txt` | **Sauvegarder la sortie.** Enregistre les résultats dans un fichier. |

### Exemples Concrets

```bash
# Scan rapide pour une première reconnaissance
gobuster dir -u http://example.com -w /usr/share/wordlists/dirb/common.txt -t 20

# Scan plus approfondi, cherchant des fichiers PHP et des backups
gobuster dir -u http://example.com -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -x php,bak,config -t 50
```

##  dns Mode `dns` : Trouver les Sous-domaines

Ce mode utilise une wordlist pour deviner les sous-domaines d'un domaine principal (ex: `admin.example.com`, `api.example.com`).

```bash
# Brute-force les sous-domaines de example.com
gobuster dns -d example.com -w /usr/share/wordlists/SecLists/Discovery/DNS/subdomains-top1million-5000.txt -i
```
*L'option `-i` est pratique, elle affiche les adresses IP des sous-domaines trouvés.*

## 🎭 Autres Modes Utiles

- **`vhost`** : Tente de trouver d'autres sites web hébergés sur le même serveur (Virtual Hosts).
- **`s3`** : Cherche des "buckets" de stockage Amazon S3 ouverts et mal configurés.

## 💡 Astuces de Pro

- **Exclure les faux positifs :** Si le site a une page d'erreur personnalisée qui renvoie toujours un code 200, utilisez `--exclude-length <taille>` pour ignorer les réponses d'une certaine taille.
- **Rester discret :** Pour éviter de surcharger un serveur ou de vous faire bloquer, vous pouvez ralentir Gobuster avec `--delay 100ms` ou réduire le nombre de threads (`-t 5`).

## 📚 Wordlists Recommandées

La qualité de votre scan dépend de la qualité de votre wordlist. Voici les incontournables (souvent pré-installées ou disponibles dans le paquet `seclists`) :

- **/usr/share/wordlists/dirb/common.txt** (Rapide, pour une première passe)
- **/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt** (Bon équilibre)
- **/usr/share/wordlists/SecLists/Discovery/Web-Content/raft-large-directories.txt** (Très complet)

---
> ⚠️ **USAGE ÉTHIQUE UNIQUEMENT** : Lancer des milliers de requêtes sur un serveur peut être considéré comme une attaque. N'utilisez cet outil que sur des systèmes pour lesquels vous avez une autorisation explicite.