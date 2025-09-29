# 🕵️ Sherlock : Le Guide Pratique

Sherlock est un outil d'OSINT (Open Source Intelligence) qui recherche un nom d'utilisateur sur des centaines de réseaux sociaux et de sites web. C'est un excellent moyen de cartographier la présence en ligne d'une personne ou d'une marque.

## 🔥 Commandes Essentielles

| Commande | Description |
|---|---|
| `sherlock <user>` | **Recherche de base.** Scanne tous les sites pour un nom d'utilisateur. |
| `sherlock <user1> <user2>` | Recherche plusieurs utilisateurs en même temps. |
| `... --output <fichier.txt>` | Sauvegarde les résultats dans un fichier. |
| `... --site <nom_site>` | Recherche uniquement sur un site spécifique (ex: `github`). |
| `... --tor` | Effectue les requêtes via le réseau Tor pour plus d'anonymat et pour contourner certains blocages. |
| `... --print-found` | N'affiche que les résultats positifs, pour une sortie plus propre. |

## 🎯 Workflow de Reconnaissance

1.  **Collecter des Pseudos**
    Pendant votre phase de reconnaissance, notez tous les pseudonymes possibles associés à votre cible.

2.  **Lancer Sherlock**
    Lancez la recherche sur les pseudos collectés et sauvegardez la sortie.
    ```bash
    sherlock pseudo_cible1 pseudo_cible2 --output resultats_sherlock.txt
    ```

3.  **Filtrer les Résultats**
    Utilisez `grep` pour n'afficher que les comptes qui ont été trouvés.
    ```bash
    grep "[+]" resultats_sherlock.txt
    ```

4.  **Investigation Manuelle**
    C'est l'étape la plus importante. Visitez chaque URL trouvée pour confirmer qu'elle appartient bien à votre cible et pour collecter des informations supplémentaires (photos, contacts, publications, etc.).

## 💡 Astuces et Limites

- **Sites bloqués ?** De nombreux sites n'aiment pas ce genre de scan automatisé et peuvent vous bloquer temporairement. L'option `--tor` peut aider à contourner ce problème, mais ralentira considérablement la recherche.
- **Faux positifs :** Un résultat `[+]` signifie seulement qu'un compte avec ce nom existe. Il pourrait appartenir à quelqu'un d'autre. La vérification manuelle est indispensable.

---
> ⚖️ **USAGE ÉTHIQUE** : Utilisez cet outil de manière responsable et dans le respect de la vie privée et de la légalité.
