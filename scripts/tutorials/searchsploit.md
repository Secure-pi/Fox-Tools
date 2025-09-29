# Tutoriel : SearchSploit

SearchSploit est la version en ligne de commande de la base de données Exploit-DB. Il vous permet de rechercher rapidement des exploits pour des logiciels et des versions spécifiques, directement depuis votre terminal, sans avoir besoin d'une connexion internet (une fois la base de données synchronisée).

---

## Utilisation de base

L'utilisation la plus simple consiste à rechercher un terme, comme le nom d'un logiciel.

```bash
# Chercher des exploits pour "vsftpd 2.3.4"
searchsploit vsftpd 2.3.4

# Chercher des vulnérabilités pour "WordPress 4.7"
searchsploit wordpress 4.7
```

Les résultats sont affichés avec un titre et le chemin vers le fichier de l'exploit sur votre système.

---

## Examiner et Utiliser un Exploit

Une fois que vous avez trouvé un exploit qui semble intéressant, vous pouvez l'examiner et le copier dans votre répertoire de travail.

```bash
# Afficher le contenu d'un exploit avec l'option -p (path)
searchsploit -p exploits/linux/remote/17491.rb

# Copier l'exploit dans le répertoire courant avec l'option -m (mirror)
searchsploit -m exploits/linux/remote/17491.rb
```

- `-p` est très utile pour lire rapidement le code source de l'exploit et comprendre comment il fonctionne avant de l'utiliser.
- `-m` est la manière la plus simple de récupérer l'exploit pour le compiler ou l'exécuter.

### Mettre à jour la base de données

Pour vous assurer d'avoir les derniers exploits, pensez à mettre à jour la base de données régulièrement.

```bash
searchsploit -u
```

---

### 💡 L'Aide du Copilote

Actuellement, SearchSploit est un outil que vous utilisez manuellement. Cependant, le copilote intègre une logique similaire dans ses suggestions.

- **Logique Interne :** Le script `fox` contient une petite base de données interne (`exploit_db.sh`) qui associe des services très connus (comme `vsftpd 2.3.4`) à des modules Metasploit spécifiques.
- **Suggestions Futures :** À l'avenir, le copilote pourrait être amélioré pour lancer automatiquement une recherche `searchsploit` en arrière-plan lorsqu'un service avec une version précise est découvert, et vous suggérer les exploits les plus pertinents directement dans le menu principal.

**Avantage actuel :** Bien que l'intégration ne soit pas encore directe, la philosophie de SearchSploit (chercher un exploit basé sur une version) est au cœur de la logique du copilote.
