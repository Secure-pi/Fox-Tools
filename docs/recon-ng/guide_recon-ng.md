# 🔍 Recon-ng : Le Guide Pratique

Recon-ng est un framework de reconnaissance web puissant et modulaire. Pensez-y comme un "Metasploit pour l'OSINT". Son point fort est sa structure qui vous guide à travers la collecte d'informations de manière organisée.

## 🔥 Les Commandes Essentielles

L'interface de Recon-ng est interactive. Voici les commandes que vous utiliserez constamment.

| Commande | Description |
|---|---|
| `workspaces create <nom>` | **CRUCIAL :** Crée un espace de travail pour séparer vos cibles. |
| `db insert domains` | Ajoute un domaine cible à la base de données du workspace. |
| `modules search <terme>` | Cherche un module (ex: `modules search google`). |
| `use <module>` | Charge un module (ex: `use recon/domains-hosts/google_site_web`). |
| `info` | Affiche les détails et les options du module chargé. |
| `run` | Exécute le module. |
| `show hosts` | Affiche tous les hôtes trouvés et stockés dans la base de données. |
| `back` | Revient au menu principal. |

## 🎯 Workflow Typique : Énumérer un Domaine

1.  **Créer un Workspace**
    C'est la toute première chose à faire pour rester organisé.
    ```bash
    [recon-ng][default] > workspaces create exemple_cible
    ```

2.  **Ajouter le Domaine Cible**
    Insérez le domaine principal dans la base de données de votre workspace.
    ```bash
    [recon-ng][exemple_cible] > db insert domains
    domain (TEXT): exemple.com
    ```

3.  **Utiliser un Module pour Trouver des Sous-domaines**
    Chargez un module, vérifiez ses options avec `info`, puis lancez-le.
    ```bash
    [recon-ng][exemple_cible] > use recon/domains-hosts/google_site_web
    [recon-ng][exemple_cible][google_site_web] > run
    ```
    *Le module utilisera automatiquement le domaine `exemple.com` que vous avez ajouté à la base de données.*

4.  **Consulter les Résultats**
    Une fois le module exécuté, les résultats sont automatiquement ajoutés à la base de données. Vous pouvez les consulter.
    ```bash
    [recon-ng][exemple_cible] > show hosts
    ```

## 💡 Astuces de Pro

- **Clés d'API :** De nombreux modules (comme Shodan, HaveIBeenPwned, etc.) nécessitent une clé d'API pour fonctionner. Utilisez la commande `keys` pour les gérer.
  ```bash
  # Ajouter une clé
  keys add shodan_api <VOTRE_CLÉ>
  ```
- **Automatisation :** Vous pouvez créer des scripts (`.rc` files) pour automatiser une série de commandes et les lancer avec `recon-ng -r mon_script.rc`.

---
> ⚠️ **BONNES PRATIQUES**
> - **Toujours créer un workspace par cible.** C'est la règle d'or de Recon-ng.
> - Prenez le temps de configurer vos clés d'API. Plus vous en avez, plus l'outil est puissant.
> - Recon-ng est un outil de **reconnaissance passive**. Il n'envoie pas de paquets malveillants, mais respectez les limites d'utilisation des API que vous interrogez.
