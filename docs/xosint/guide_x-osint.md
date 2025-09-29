# 🔍 X-OSINT : Le Guide Pratique

X-OSINT est un framework Python qui regroupe plusieurs outils d'OSINT (Open Source Intelligence) sous une seule interface interactive. Son but est de vous guider dans la collecte d'informations sur une personne ou une entreprise à partir de sources publiques.

## 🚀 Lancement

L'outil se lance en ligne de commande et vous présente un menu.

```bash
# Le chemin peut varier selon votre installation
cd /path/to/X-osint/
python3 xosint
```

## 🎯 Workflow : Comment Utiliser X-OSINT

L'approche de X-OSINT est de vous guider à travers des modules. Vous ne tapez pas de commandes complexes, vous suivez les menus.

1.  **Lancer l'outil** et choisir une catégorie dans le menu principal (ex: `Domain Analysis`).
2.  **Entrer votre cible** (ex: `example.com`).
3.  **Choisir les actions** à effectuer depuis le sous-menu (ex: `Run all checks`, `DNS Enumeration`).
4.  **Analyser les résultats** qui sont affichés à l'écran et souvent sauvegardés dans des fichiers.
5.  **Pivoter :** Utiliser une information trouvée (ex: une adresse e-mail) comme nouvelle cible dans un autre module (ex: `Email Harvesting`).

## 🔥 Fonctionnalités Clés

| Module (Exemple) | Ce qu'il fait |
|---|---|
| `Domain Analysis` | Récupère les informations `whois`, les enregistrements DNS, et les sous-domaines. |
| `Google Dorking` | Automatise des recherches Google avancées pour trouver des fichiers ou des pages sensibles. |
| `Email Harvesting` | Tente de trouver toutes les adresses e-mail associées à un domaine. |
| `Social Recon` | Recherche des profils sur les réseaux sociaux. |
| `Report Generation` | Compile toutes les informations trouvées dans un rapport. |

## X-OSINT vs. Autres Outils

- **vs. Recon-ng :** X-OSINT est plus simple et plus guidé par les menus, ce qui le rend plus facile pour les débutants. Recon-ng est plus puissant, plus scriptable, et s'intègre mieux dans des workflows automatisés.
- **vs. Sherlock :** Sherlock est spécialisé dans la recherche de noms d'utilisateur. X-OSINT fait cela et bien plus, mais Sherlock est souvent plus rapide et plus complet pour cette tâche spécifique.
- **vs. theHarvester :** theHarvester est excellent pour la collecte d'e-mails et de sous-domaines. X-OSINT propose une gamme de modules plus large.

**Conclusion :** X-OSINT est un excellent point de départ pour l'OSINT, car il regroupe de nombreuses fonctionnalités. Pour des besoins plus spécifiques ou plus avancés, vous utiliserez ensuite des outils spécialisés.

---
> ⚖️ **USAGE ÉTHIQUE** : L'OSINT consiste à collecter des informations publiques. Assurez-vous de toujours agir dans un cadre légal et éthique.
