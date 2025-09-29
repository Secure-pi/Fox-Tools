# 🕷️ Burp Suite : Le Guide Pratique

Burp Suite est l'outil incontournable pour tester la sécurité des applications web. Il se place entre votre navigateur et le serveur de l'application pour vous permettre d'intercepter, d'analyser et de manipuler tout le trafic.

## 🚀 Démarrage Rapide : 5 minutes pour être prêt

1.  **Lancer Burp :**
    ```bash
    burpsuite
    ```
2.  **Configurer le Proxy du Navigateur :** Dans les paramètres de votre navigateur (Firefox est recommandé), configurez un proxy manuel :
    -   **Adresse :** `127.0.0.1`
    -   **Port :** `8080`
3.  **Installer le Certificat :** Avec le proxy activé, allez sur l'adresse `http://burp`. Cliquez sur "CA Certificate" pour télécharger le certificat. Installez-le dans l'onglet "Autorités" des paramètres de votre navigateur pour pouvoir intercepter le trafic HTTPS.
4.  **Commencer l'audit :** Dans l'onglet `Proxy > Intercept` de Burp, activez l'interception (`Intercept is on`). Chaque requête que vous ferez dans votre navigateur apparaîtra maintenant dans Burp.

## 🔥 Les Modules Clés et leur Utilisation

Un workflow de pentest typique avec Burp se déroule comme suit :

1.  **Target (Cible) :** Naviguez sur l'application. Burp va automatiquement construire une carte du site (`Site map`). C'est votre base de travail. Clic droit sur le domaine principal -> "Add to Scope" pour vous concentrer sur votre cible.

2.  **Repeater (Répéteur) :** C'est votre laboratoire. Vous y envoyez des requêtes intéressantes pour les modifier et les rejouer à volonté. C'est l'outil le plus utilisé pour le test manuel.
    *   **Raccourci :** `Ctrl+R` pour envoyer une requête vers Repeater.

3.  **Intruder (Intrus) :** Pour l'automatisation. Vous l'utilisez pour fuzzer des paramètres, brute-forcer des mots de passe ou énumérer des utilisateurs.
    *   **Raccourci :** `Ctrl+I` pour envoyer une requête vers Intruder.

4.  **Decoder & Comparer :** Des utilitaires pratiques. Decoder pour manipuler des données (Base64, URL encoding...). Comparer pour voir les différences entre deux requêtes ou réponses.

## 🎯 Techniques d'Attaque Courantes

### Intruder : Brute-force d'un formulaire de login

1.  Envoyez une requête de connexion (avec un mauvais mot de passe) à **Intruder**.
2.  Allez dans l'onglet `Positions`. Cliquez sur `Clear §`. Sélectionnez uniquement la valeur du mot de passe et cliquez sur `Add §`.
3.  Allez dans l'onglet `Payloads`. Collez ou chargez une liste de mots de passe.
4.  Lancez l'attaque. Triez les résultats par "Length" (longueur) ou "Status" pour repérer la connexion réussie.

### Repeater : Test d'une injection SQL

1.  Trouvez une requête avec un paramètre (ex: `GET /produit?id=12`). Envoyez-la à **Repeater**.
2.  Ajoutez une apostrophe (`'`) à la fin de la valeur du paramètre (`id=12'`).
3.  Envoyez la requête. Si vous recevez une erreur SQL, une page blanche ou un comportement inattendu, le paramètre est probablement vulnérable.

## ⚡ Extensions (BApps) : Passez à la vitesse supérieure

Allez dans l'onglet `Extender > BApp Store` pour installer des extensions qui décuplent la puissance de Burp.

- **Logger++ :** Des logs beaucoup plus clairs et filtrables que ceux de base.
- **Param Miner :** Découvre des paramètres cachés que vous auriez pu manquer.
- **Autorize :** Indispensable pour tester les droits d'accès. Il rejoue automatiquement chaque requête avec les cookies d'un utilisateur moins privilégié pour voir s'il a accès à des ressources non autorisées.
- **Turbo Intruder :** Une version ultra-rapide et plus flexible d'Intruder, écrite en Python.

## ⌨️ Raccourcis à Connaître

- `Ctrl+R` : Envoyer à Repeater
- `Ctrl+I` : Envoyer à Intruder
- `Ctrl+U` / `Ctrl+Shift+U` : URL-encoder / URL-décoder
- `Ctrl+B` / `Ctrl+Shift+B` : Base64-encoder / Base64-décoder

---
> ⚠️ **USAGE LÉGAL ET ÉTHIQUE** : N'utilisez Burp Suite que sur des applications pour lesquelles vous avez une autorisation explicite.