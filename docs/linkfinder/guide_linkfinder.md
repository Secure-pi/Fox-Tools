# 🔗 LinkFinder : Le Guide Pratique

LinkFinder est un outil Python qui fouille dans les fichiers JavaScript d'un site web pour y trouver des "endpoints" : des URL, des chemins d'API, et d'autres liens qui ne sont pas visibles directement sur la page. C'est un excellent moyen de découvrir la surface d'attaque cachée d'une application.

## 🔥 Commandes Essentielles

| Option | Description |
|---|---|
| `linkfinder -i <URL>` | **Commande de base.** Analyse une URL, trouve les `.js` et en extrait les liens. |
| `... -d` | Analyse en profondeur en utilisant le crawler de `jsbeautifier`. |
| `... -o <fichier.html>` | Sauvegarde les résultats dans un fichier HTML pour une lecture facile. |
| `... -c <cookie>` | Fournit un cookie de session pour analyser des zones authentifiées du site. |

## 🎯 Workflow : de la Découverte à l'Exploitation

1.  **Lancer l'analyse**
    Commencez par scanner l'URL principale de votre cible.
    ```bash
    linkfinder -i https://example.com -o results.html
    ```

2.  **Analyser les résultats**
    Ouvrez le fichier `results.html`. Cherchez des chemins qui semblent intéressants ou inhabituels :
    -   Endpoints d'API : `/api/v1/users`, `/api/v2/admin`, `/graphql`
    -   Interfaces d'administration : `/admin/panel`, `/dashboard`
    -   Fonctionnalités cachées : `/upload`, `/debug/info`, `/backup`

3.  **Valider les découvertes**
    Chaque lien trouvé n'est pas forcément accessible. Testez-les manuellement avec `curl` pour voir leur statut.
    ```bash
    curl -I https://example.com/api/v1/users
    # Regardez le code de statut HTTP (200 OK, 403 Forbidden, 404 Not Found, etc.)
    ```

4.  **Approfondir l'analyse**
    Utilisez les chemins valides comme nouvelles cibles pour vos autres outils :
    -   **Gobuster / Wfuzz :** Pour fuzzer les paramètres sur ces nouveaux endpoints.
    -   **Burp Suite / SQLMap :** Pour tester ces endpoints à la recherche de vulnérabilités (XSS, SQLi, IDOR...).

## 💡 Astuce de Pro : Analyse en Masse

Si vous avez une liste d'URL à tester, vous pouvez automatiser LinkFinder avec une simple boucle `for`.

```bash
for url in $(cat list_urls.txt); do
  filename=$(echo $url | sed 's|https?://||g' | tr '/' '_')
  linkfinder -i $url -o "linkfinder_$filename.html"
done
```

---
> ⚠️ **PRÉCAUTIONS** : LinkFinder lui-même est un outil passif, mais les actions que vous entreprenez à partir de ses résultats (comme le fuzzing) sont actives. Assurez-vous d'avoir l'autorisation nécessaire.
