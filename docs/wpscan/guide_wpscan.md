# 📰 WPScan : Le Guide Pratique

WPScan est le scanner de vulnérabilités de référence pour les sites WordPress. Il permet d'identifier la version de WordPress, les thèmes, les plugins, d'énumérer les utilisateurs et de détecter les vulnérabilités connues.

> **Important :** Pour que la détection de vulnérabilités fonctionne, vous devez vous enregistrer sur [wpscan.com](https://wpscan.com/) pour obtenir un **token API gratuit**.

## 🔥 Commandes Essentielles

| Commande | Description |
|---|---|
| `wpscan --update` | **Indispensable.** Met à jour la base de données de vulnérabilités de WPScan. À faire régulièrement. |
| `wpscan --url <URL>` | **Scan de base.** Détecte la version, le thème et les plugins, puis vérifie les vulnérabilités connues. |
| `... --enumerate <options>` | Lance une énumération spécifique (voir tableau ci-dessous). |
| `... --passwords <wordlist>` | Lance une attaque par brute-force sur les utilisateurs trouvés. |
| `... --api-token <TOKEN>` | Spécifie votre token API pour voir les détails des vulnérabilités. |

### Exemple de scan complet

```bash
# Scan complet : énumération des plugins/thèmes vulnérables et des utilisateurs, avec le token API
wpscan --url http://example.com --enumerate vp,vt,u --api-token <VOTRE_TOKEN>
```

## 🎯 Options d'Énumération (`--enumerate`)

C'est le cœur de WPScan. Vous pouvez combiner plusieurs options (ex: `vp,vt,u`).

| Option | Description | Recommandation |
|---|---|---|
| `vp` | **Plugins Vulnérables** | Recommandé (rapide) |
| `ap` | Tous les Plugins | Très long, à n'utiliser que si nécessaire |
| `vt` | **Thèmes Vulnérables** | Recommandé (rapide) |
| `at` | Tous les Thèmes | Très long |
| `u` | **Utilisateurs** | Énumère les auteurs de 1 à 10 par défaut. |
| `cb` | Fichiers de config en backup | Utile pour trouver des `wp-config.php.bak`. |

## 🚀 Workflow d'un Audit WordPress

1.  **Mise à jour**
    ```bash
    wpscan --update
    ```
2.  **Scan de Reconnaissance**
    Lancez un scan de base pour identifier les versions et les vulnérabilités évidentes.
    ```bash
    wpscan --url http://target.com --enumerate vp,vt --api-token <TOKEN>
    ```
3.  **Analyse des Résultats**
    -   Regardez les `[!]` (rouge) en priorité. Ce sont des vulnérabilités confirmées.
    -   Notez les versions des plugins et du thème.

4.  **Énumération des Utilisateurs**
    ```bash
    wpscan --url http://target.com --enumerate u
    ```

5.  **Brute-force (si autorisé)**
    Si vous avez trouvé des noms d'utilisateurs, vous pouvez tenter une attaque par brute-force.
    ```bash
    wpscan --url http://target.com --usernames admin,user1 --passwords /usr/share/wordlists/rockyou.txt
    ```

6.  **Exploitation Manuelle**
    Pour chaque vulnérabilité trouvée, utilisez `searchsploit` ou Google pour trouver un code d'exploitation (PoC) et l'adapter à votre cible.

---
> ⚠️ **LÉGALITÉ** : N'utilisez WPScan que sur des sites pour lesquels vous avez une autorisation d'audit explicite.
