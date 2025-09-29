# 🔍 SearchSploit : Le Guide Pratique

SearchSploit est l'interface en ligne de commande de la base de données Exploit-DB. Il vous permet de rechercher rapidement et localement des exploits pour des logiciels et des versions spécifiques.

**Le réflexe à avoir :** Dès que vous identifiez une version de logiciel (ex: Apache 2.4.49, OpenSSH 8.2), lancez une recherche avec `searchsploit`.

## 🔥 Commandes Essentielles

| Commande | Description |
|---|---|
| `searchsploit <terme>` | **Recherche de base.** Cherche un mot-clé dans les titres et les chemins des exploits. |
| `searchsploit -e <terme>` | **Recherche exacte.** Très utile pour cibler une version précise (ex: `searchsploit -e "Wordpress 5.8"`). |
| `searchsploit -t <terme>` | Recherche uniquement dans le **titre** de l'exploit. |
| `searchsploit -x <ID>` | **Examine un exploit.** Affiche son contenu directement dans le terminal. |
| `searchsploit -m <ID>` | **Copie un exploit** dans votre dossier actuel pour que vous puissiez le modifier et l'utiliser. |
| `searchsploit -u` | **Met à jour** la base de données locale d'exploits. À faire régulièrement ! |

## 🎯 Workflow Typique : de Nmap à l'Exploit

1.  **Scanner les services et leurs versions avec Nmap.**
    ```bash
    nmap -sV target.com
    ```
    *Sortie de Nmap : `Apache httpd 2.4.51 ((Unix))`*

2.  **Rechercher un exploit pour la version identifiée.**
    ```bash
    searchsploit "Apache 2.4.51"
    ```

3.  **Analyser et préparer l'exploit.**
    - Si un exploit intéressant est trouvé (ex: ID `12345`), examinez son code source pour comprendre ce qu'il fait.
      ```bash
      searchsploit -x 12345
      ```
    - Copiez-le localement pour pouvoir le modifier.
      ```bash
      searchsploit -m 12345
      ```

4.  **Adapter et exécuter.**
    - La plupart des exploits nécessitent des modifications (changer une adresse IP, un port, etc.). Lisez attentivement les commentaires dans le code de l'exploit.
    - Exécutez l'exploit en suivant les instructions.

---
> 💡 **Astuce :** Vous pouvez combiner les options. `searchsploit -w "Apache 2.4"` vous montrera les URL Exploit-DB correspondantes, ce qui est pratique pour partager des liens.
