# Tutoriel : Linpeas pour l'Escalade de Privilèges

Linpeas (Linux Privilege Escalation Awesome Script) est un script qui recherche les chemins possibles d'escalade de privilèges sur une machine Linux. Il ne réalise pas l'exploitation lui-même, mais il scanne le système à la recherche d'informations mal configurées ou de vulnérabilités connues qui pourraient permettre d'élever ses privilèges (par exemple, passer d'un utilisateur normal à `root`).

---

## Comment ça marche ?

Une fois exécuté sur une machine cible, Linpeas va vérifier des centaines de points, notamment :

-   Les informations système de base (version du noyau, etc.).
-   Les droits `sudo` de l'utilisateur.
-   Les fichiers avec des permissions inhabituelles (SUID/SGID).
-   Les tâches planifiées (Cron jobs).
-   Les services qui tournent avec des privilèges élevés.
-   Les mots de passe en clair dans des fichiers de configuration ou des logs.

La sortie de Linpeas est colorée pour attirer l'attention sur les trouvailles potentiellement intéressantes. **Tout ce qui est en rouge et jaune mérite une investigation approfondie.**

---

## Utilisation

Linpeas est un script unique qui doit être **exécuté sur la machine cible**.

1.  **Transférez le script sur la cible.** Vous pouvez utiliser un serveur web simple sur votre machine pour l'héberger.
2.  **Rendez-le exécutable :** `chmod +x linpeas.sh`
3.  **Lancez-le :** `./linpeas.sh`

Il est recommandé de rediriger la sortie vers un fichier pour pouvoir l'analyser tranquillement après son exécution :

```bash
./linpeas.sh > /tmp/linpeas_results.txt
```

---

### 💡 L'Aide du Copilote

Le menu `Exploitation > Privilege Escalation Scanner` vous guide pour utiliser Linpeas.

1.  **Téléchargement Automatique :** Si le script `linpeas.sh` n'est pas présent dans votre boîte à outils, le copilote vous propose de le télécharger automatiquement.
2.  **Instructions Claires :** Le copilote vous fournit les commandes exactes à exécuter. Il vous indique comment démarrer un serveur web sur **votre machine** pour héberger le script.
3.  **Commandes pour la Cible :** Il vous donne ensuite la commande `wget` à copier-coller sur le **shell de la cible** pour télécharger le script, le rendre exécutable et le lancer.

**Avantage :** Le copilote élimine toute confusion sur la manière de transférer et d'exécuter Linpeas. Il vous donne un plan d'action étape par étape, clair et précis.
