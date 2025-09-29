# 🎣 SocialFish : Le Guide Pratique

SocialFish est un framework de phishing simple et rapide, idéal pour des démonstrations ou des tests d'intrusion rapides. Il permet de cloner une page de connexion pour capturer les identifiants saisis par une victime.

> ⚠️ **Outil Ancien :** SocialFish n'est plus activement maintenu. Pour des campagnes de phishing plus avancées et robustes, considérez des alternatives modernes comme **Gophish** ou **Evilginx2**.

## 🚀 Lancement

SocialFish est un script Python. Vous devez d'abord naviguer vers son dossier d'installation.

```bash
# Le chemin peut varier selon votre installation
cd /path/to/SocialFish/

# Lancer l'outil
python3 SocialFish.py
```

## 🎯 Workflow d'une Attaque de Phishing

L'outil vous guide à travers un menu interactif.

1.  **Lancement**
    - Exécutez `python3 SocialFish.py`.
    - Il vous sera demandé l'URL de la page de connexion que vous souhaitez cloner.

2.  **Configuration**
    - **URL à cloner :** Entrez l'URL cible (ex: `https://www.instagram.com/accounts/login/`).
    - **Redirection (Optionnel) :** Vous pouvez fournir une URL légitime (ex: `https://www.instagram.com`) vers laquelle la victime sera redirigée après avoir entré ses informations. Cela rend l'attaque plus crédible.

3.  **Déploiement**
    - SocialFish démarre un serveur web et vous donne une URL (ex: `http://<VOTRE_IP>:80`).
    - C'est cette URL que vous devez envoyer à votre cible.

4.  **Récolte**
    - Lorsqu'une victime visite votre URL et soumet le formulaire, les identifiants (nom d'utilisateur et mot de passe) sont affichés en temps réel dans votre terminal.

## 🛡️ Comment se Protéger du Phishing ?

- **Toujours vérifier l'URL** dans la barre d'adresse avant de saisir des identifiants.
- **Rechercher le cadenas HTTPS.** La plupart des sites de phishing sont en simple HTTP.
- **Activer l'authentification à deux facteurs (2FA)** sur tous vos comptes. Même si un attaquant vole votre mot de passe, il ne pourra pas se connecter sans le deuxième facteur.

---
> ⚖️ **ASPECTS LÉGAUX** : Le phishing est illégal. N'utilisez cet outil que dans un cadre professionnel et autorisé (test d'intrusion, campagne de sensibilisation) et avec une **autorisation écrite**.
