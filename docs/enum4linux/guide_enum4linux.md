# 🐧 Enum4linux : Le Guide Pratique

Enum4linux est un outil essentiel pour l'énumération des informations sur les systèmes Windows via le protocole Samba (SMB). Il permet de découvrir des utilisateurs, des partages, des groupes et d'autres informations sensibles.

## 🔥 La Commande Essentielle : `-A`

Dans la plupart des cas, une seule option suffit pour une énumération complète et agressive.

```bash
# Lance toutes les vérifications possibles sur la cible
enum4linux -A <IP_CIBLE>
```

## 🎯 Options Clés pour une Énumération Ciblée

Si le scan complet est trop bruyant ou si vous cherchez quelque chose de spécifique, vous pouvez utiliser ces options.

| Option | Description |
|---|---|
| `-U` | Énumère les **utilisateurs**. |
| `-S` | Énumère les **partages** (dossiers partagés). |
| `-G` | Énumère les **groupes** et leurs membres. |
| `-P` | Affiche la **politique de mot de passe** du domaine. |
| `-r` | Tente de brute-forcer les utilisateurs via **RID Cycling**. Très utile si `-U` ne donne rien. |

## 🚀 Workflow d'Énumération SMB

1.  **Scan Complet Anonyme**
    C'est toujours la première étape. On voit ce que le serveur expose publiquement.
    ```bash
    enum4linux -A 192.168.1.100
    ```

2.  **Analyser les Résultats**
    -   **Utilisateurs :** Notez les noms d'utilisateurs. Ils serviront pour des attaques de brute-force ou de "password spraying".
    -   **Partages :** Regardez les partages accessibles. Y a-t-il des partages lisibles par tout le monde (`READ`) ?

3.  **Explorer les Partages Accessibles**
    Si vous trouvez un partage intéressant (ex: `IPC$`, `backups`), essayez de vous y connecter. L'outil `smbclient` est parfait pour ça.
    ```bash
    # Lister les partages de manière anonyme (sans mot de passe)
    smbclient -L //192.168.1.100/ -N

    # Se connecter à un partage spécifique
    smbclient //192.168.1.100/backups -N
    ```

4.  **Brute-force des Utilisateurs (si nécessaire)**
    Si l'énumération de base ne révèle aucun utilisateur, le "RID Cycling" peut en forcer la découverte. Cette technique teste tous les identifiants possibles (Relative IDs) pour trouver des comptes valides.
    ```bash
    enum4linux -r 192.168.1.100
    ```

## 💡 Post-Énumération : Et Après ?

Les informations collectées par enum4linux sont le point de départ pour de nombreuses attaques :

-   **Identifiants trouvés ?** Utilisez-les avec `psexec.py`, `crackmapexec`, ou `medusa` pour tenter de prendre le contrôle.
-   **Partage accessible en écriture ?** Essayez d'y déposer un payload.
-   **Politique de mot de passe faible ?** Lancez une attaque par brute-force avec `hydra` en sachant que les mots de passe sont courts ou non complexes.

---
> ⚠️ **Contexte :** Enum4linux est particulièrement efficace contre les anciens systèmes Windows et les contrôleurs de domaine mal configurés. C'est un outil indispensable en pentest interne.
