# 🌐 GUIDE MÉTHODOLOGIQUE - ÉNUMÉRATION WEB

---

## 🎯 ÉTAPE 1 : ÉNUMÉRATION AUTOMATISÉE
> ⚠️ **Prérequis**: Avoir identifié les services web ouverts (ports 80, 443, 8080, etc.) lors de la phase de scan de ports.

### 1.1 Découverte de Répertoires et Fichiers
- **Outil**: `gobuster` (mode `dir`)
- **Commande de base**:
  ```bash
  gobuster dir -u http://target.com -w /usr/share/seclists/Discovery/Web-Content/common.txt -o gobuster_results.txt
  ```
- **Conseil**: Testez plusieurs wordlists pour une couverture maximale (`common.txt`, `directory-list-2.3-medium.txt`).

### 1.2 Scan de Vulnérabilités Web
- **Outil**: `nikto`
- **Commande**:
  ```bash
  nikto -h http://target.com -o nikto_results.txt
  ```
- **Note**: Nikto est excellent pour trouver des vulnérabilités "low-hanging fruit" (faciles à trouver) comme des fichiers de configuration exposés, des versions de logiciels obsolètes, etc.

### 1.3 Énumération Avancée (si pertinent)
- **Recherche par extensions**:
  ```bash
  gobuster dir -u http://target.com -w wordlist.txt -x php,html,js,config,bak
  ```
- **Recherche de Virtual Hosts**:
  ```bash
  gobuster vhost -u http://target.com -w subdomains.txt
  ```

---

## 🎯 ÉTAPE 2 : ANALYSE MANUELLE
L'automatisation ne trouve pas tout. L'analyse manuelle est cruciale.

### 2.1 Inspection Visuelle
- Ouvrez le site dans un navigateur.
- **Affichez le code source** (`Ctrl+U`) et cherchez des commentaires, des chemins vers des scripts, ou des informations laissées par les développeurs.
- Testez les formulaires (login, contact, recherche) avec des entrées simples pour voir comment ils réagissent.

### 2.2 Interception avec Burp Suite
- **Outil**: `burpsuite`
- **Action**: Configurez votre navigateur pour utiliser Burp comme proxy (`127.0.0.1:8080`). Naviguez sur le site et analysez chaque requête et réponse.
- **Objectif**: Chercher des paramètres cachés, comprendre le fonctionnement des cookies et des tokens, et identifier la logique de l'application.

---

## 🚨 POINTS DE CONTRÔLE IMPORTANTS
- [ ] Avez-vous visité chaque répertoire et fichier découvert par Gobuster ?
- [ ] Avez-vous analysé les en-têtes HTTP (Server, X-Powered-By, etc.) ?
- [ ] Avez-vous noté toutes les technologies utilisées (ex: Apache, PHP, WordPress) ?
- [ ] Avez-vous documenté chaque vulnérabilité potentielle trouvée ?

---

## ➡️ PROCHAINE ÉTAPE
Une fois l'énumération terminée et les vecteurs d'attaque potentiels identifiés, la prochaine étape est la **phase d'exploitation**.
