# Tutoriel : WhatWeb

WhatWeb est un outil de reconnaissance web qui permet d'identifier les technologies utilisées par un site. C'est comme regarder la carte d'identité d'un site web pour connaître sa langue, son moteur, et les briques logicielles qui le composent.

---

## À quoi ça sert ?

Savoir qu'un site tourne sous une vieille version de WordPress ou utilise une bibliothèque JavaScript vulnérable est une information capitale. WhatWeb vous donne ces informations en détectant :

-   Le Système de Gestion de Contenu (CMS) : WordPress, Joomla, Drupal...
-   Les frameworks : React, Angular, Vue.js...
-   Le langage serveur : PHP, Ruby, Python...
-   Le serveur web : Apache, Nginx...
-   Les bibliothèques JavaScript : jQuery, Bootstrap...

---

## Utilisation et Exemples

La syntaxe de base est très simple.

```bash
# Scan de base, rapide et discret
whatweb example.com

# Scan verbeux pour afficher plus de détails sur les plugins
whatweb -v example.com
```

### Niveaux d'agressivité

WhatWeb possède des niveaux d'agressivité (`-a`) qui déterminent la profondeur du scan.

```bash
# Niveau 1 (par défaut) : Rapide et discret.
whatweb -a 1 example.com

# Niveau 3 : Plus approfondi, peut faire plus de requêtes pour tenter de deviner des technologies cachées.
whatweb -a 3 example.com
```

Un niveau plus élevé donne plus d'informations mais est plus "bruyant" et peut être détecté.

---

### 💡 L'Aide du Copilote

Dans le menu `Web > Web Technology Detection`, le script vous facilite la vie.

1.  **Sélection de la cible :** Le copilote analyse votre butin (`loot.csv`) et vous propose une liste de toutes les cibles web (HTTP/HTTPS) qui ont été découvertes lors des scans de ports. 
2.  **Lancement Automatisé :** Une fois la cible choisie dans le menu, le script lance `whatweb` pour vous.

**Avantage :** Plus besoin de jongler entre les résultats de Nmap et votre terminal. Si Nmap trouve un port 80, le copilote vous le propose directement comme cible pour WhatWeb. C'est simple et rapide.