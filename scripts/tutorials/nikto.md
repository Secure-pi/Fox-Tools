# Tutoriel : Nikto, le scanner de vulnérabilités web

Nikto est un scanner de vulnérabilités web open source qui effectue des tests complets contre des serveurs web. Il recherche plus de 6700 fichiers/programmes potentiellement dangereux, vérifie les versions obsolètes de plus de 1250 serveurs, et les problèmes spécifiques à plus de 270 versions de serveurs. C'est un outil essentiel pour une première évaluation de la sécurité d'un serveur web.

---

## À quoi ça sert ?

Nikto est votre première ligne d'attaque contre un serveur web. Il est excellent pour trouver les "fruits mûrs" (low-hanging fruits), c'est-à-dire les vulnérabilités faciles à trouver, comme :

-   Les fichiers et répertoires par défaut (ex: `/admin/`, `/test/`).
-   Les versions de logiciels serveur obsolètes et vulnérables.
-   Les en-têtes HTTP mal configurés.
-   Les injections de contenu, et bien plus.

Nikto n'est pas discret. Il fait beaucoup de requêtes et sera très probablement détecté par un système de détection d'intrusion (IDS).

---

## Utilisation et Exemples

La syntaxe de base est très simple.

```bash
# Scan de base sur un serveur web
nikto -h http://<IP_CIBLE>/

# Spécifier un port différent
nikto -h http://<IP_CIBLE>:8080/

# Sauvegarder la sortie dans un fichier
nikto -h http://<IP_CIBLE>/ -o resultats_nikto.txt
```

- `-h` (`-host`) : Spécifie la cible.
- `-p` (`-port`) : Spécifie le port.
- `-o` (`-output`) : Spécifie le fichier de sortie.

---

### 💡 L'Aide du Copilote

Le menu `Web > Web Vulnerability Scanning` et le menu `Accès Rapide` rendent l'utilisation de Nikto extrêmement simple.

1.  **Sélection de la Cible via le Copilote :** Le script analyse votre butin (`loot.csv`) et vous propose une liste de toutes les cibles web (HTTP/HTTPS) découvertes. Vous choisissez simplement la cible dans un menu.
2.  **Lancement et Sauvegarde Automatisés :** Le copilote construit la commande `nikto` pour vous, la lance, et sauvegarde automatiquement le rapport complet dans un fichier horodaté au sein de votre projet (`web/nikto_...`).
3.  **Résumé Instantané :** Une fois le scan terminé, le copilote ne se contente pas de sauvegarder le fichier. Il analyse les résultats et vous affiche un résumé des 10 premières vulnérabilités (OSVDB) trouvées, vous donnant un aperçu immédiat des points les plus critiques sans avoir à ouvrir le fichier de rapport.

**Avantage :** Le copilote automatise entièrement le processus de ciblage, de scan, de sauvegarde et de résumé, vous faisant gagner un temps précieux et vous permettant de vous concentrer immédiatement sur les résultats importants.
