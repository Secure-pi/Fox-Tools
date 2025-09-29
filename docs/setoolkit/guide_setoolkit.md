# 🎣 SET : Le Guide Pratique du Social-Engineer Toolkit

Le Social-Engineer Toolkit (SET) est un framework complet dédié à l'ingénierie sociale. Son but est de simuler des attaques qui exploitent la psychologie humaine, comme le phishing, pour tester la vigilance des utilisateurs et les défenses d'une organisation.

SET fonctionne entièrement via des menus interactifs en ligne de commande.

## 🚀 Démarrage

```bash
# SET doit souvent être lancé avec des privilèges élevés
sudo setoolkit
```

## 🔥 L'Attaque la Plus Courante : Le Vol d'Identifiants

L'attaque "Credential Harvester" est la plus emblématique de SET. Elle consiste à cloner un site web légitime (comme une page de connexion) pour tromper un utilisateur et lui faire saisir ses identifiants.

Voici le cheminement exact dans les menus de SET :

1.  **Menu Principal :** Choisir `1) Social-Engineering Attacks`
2.  **Vecteurs d'Attaque :** Choisir `2) Website Attack Vectors`
3.  **Type d'Attaque Web :** Choisir `3) Credential Harvester Attack`
4.  **Méthode :** Choisir `2) Site Cloner`

Ensuite, SET vous demandera deux choses :
- **Votre adresse IP :** L'adresse de votre machine, où les identifiants volés seront envoyés.
- **L'URL à cloner :** La page de connexion que vous voulez imiter (ex: `https://www.facebook.com`).

Une fois configuré, SET démarre un serveur web sur votre machine. Il ne vous reste plus qu'à envoyer le lien (`http://<VOTRE_IP>`) à votre cible. Dès qu'elle entrera ses identifiants, ils apparaîtront dans votre terminal.

## 🎯 Aperçu des Autres Modules d'Attaque

Le menu `Social-Engineering Attacks` est le cœur de l'outil.

| Option | Description |
|---|---|
| `1) Spear-Phishing` | Permet de créer et d'envoyer des e-mails de phishing ciblés à une ou plusieurs victimes. |
| `2) Website Attack` | Contient le "Credential Harvester", mais aussi des attaques par applet Java ou exploit de navigateur. |
| `4) Create a Payload` | Génère un exécutable malveillant (payload) et démarre un listener Metasploit pour recevoir la connexion. |
| `6) Wireless Access Point` | Crée un faux point d'accès Wi-Fi pour intercepter le trafic. |

---
> ⚠️ **USAGE ÉTHIQUE** : SET est un outil puissant pour les audits de sécurité et la formation. Son utilisation à des fins malveillantes est illégale. Une campagne de phishing réussie combine toujours un bon prétexte (OSINT) et un bon outil technique.
