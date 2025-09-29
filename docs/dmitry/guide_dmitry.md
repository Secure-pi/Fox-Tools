# 🔍 Dmitry : Le Guide Pratique

Dmitry (Deepmagic Information Gathering Tool) est un outil de reconnaissance simple et rapide, utile pour une première passe d'information sur une cible.

**Note :** Dmitry est un outil plus ancien. Pour une reconnaissance approfondie, il doit être complété par des outils plus modernes comme Nmap ou theHarvester.

## 🔥 Options et Commandes Essentielles

Dmitry fonctionne en combinant des options pour collecter différentes informations.

| Option | Description |
|---|---|
| `-i` | Effectue une recherche **whois** sur le nom de domaine. |
| `-n` | Récupère les informations depuis **Netcraft.com** (technos, hébergement). |
| `-s` | Recherche des **sous-domaines**. |
| `-e` | Recherche des **adresses e-mail**. |
| `-p` | Effectue un **scan de ports TCP** basique. |
| `-b` | Lit les **bannières** des services sur les ports ouverts. |

## 🎯 Exemples de Scans Combinés

La force de Dmitry réside dans la combinaison de ses options.

```bash
# Le scan le plus complet : Whois, Netcraft, Sous-domaines, Emails, Ports
dmitry -winsep <cible.com>

# Recherche rapide d'informations passives (sans scan de ports)
dmitry -winse <cible.com>

# Scan de ports rapide avec récupération des bannières
dmitry -pb <cible.com>

# Sauvegarder la sortie complète dans un fichier
dmitry -winsepo <cible.com> > dmitry_results.txt
```

## 🚀 Intégration dans un Workflow

Dmitry est surtout utile comme point de départ avant de passer à des outils plus puissants.

1.  **Lancer un scan de base avec Dmitry** pour avoir une vue d'ensemble rapide.
    ```bash
    dmitry -winsepo target.com
    ```
2.  **Utiliser les résultats pour affiner les scans suivants** :
    - Les **sous-domaines** trouvés peuvent être scannés avec Nmap.
    - Les **adresses e-mail** trouvées peuvent être utilisées pour des recherches de fuites de données ou des campagnes de phishing.
    - Les **ports ouverts** peuvent être analysés plus en détail avec Nmap :
      ```bash
      # Si Dmitry trouve les ports 80 et 443, on lance un scan Nmap détaillé dessus
      nmap -sV -sC -p80,443 target.com
      ```

---
> 💡 **Conclusion :** Voyez Dmitry comme un outil de "dégrossissage". Il est rapide et simple, mais ses résultats doivent toujours être vérifiés et approfondis avec des outils plus spécialisés.
