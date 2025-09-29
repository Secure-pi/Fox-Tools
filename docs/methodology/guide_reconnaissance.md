# 🔍 GUIDE MÉTHODOLOGIQUE - PHASE DE RECONNAISSANCE

---

La reconnaissance est la première et l'une des plus importantes phases d'un test d'intrusion. L'objectif est de collecter un maximum d'informations sur la cible.

## 🎯 ÉTAPE 1 : COLLECTE D'INFORMATIONS PASSIVES
Cette étape se fait sans interaction directe avec la cible.

### 1.1 Collecte d'E-mails et d'Informations Publiques
- **Outil**: `theharvester`
- **Commande**:
  ```bash
  theharvester -d example.com -l 500 -b google
  ```
- **Objectif**: Trouver des adresses e-mail, des noms d'employés, des sous-domaines, etc., qui sont publiquement accessibles.

### 1.2 Énumération de Sous-domaines
- **Outil**: `gobuster` (mode `dns`)
- **Commande**:
  ```bash
  gobuster dns -d example.com -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt -o subdomains.txt
  ```
- **Objectif**: Découvrir des sous-domaines qui pourraient héberger des applications moins sécurisées (ex: `dev.example.com`, `test.example.com`).

---

## 🎯 ÉTAPE 2 : SCAN DE PORTS ET SERVICES (RECONNAISSANCE ACTIVE)
Cette étape implique une interaction directe avec la cible.

### 2.1 Scan Initial Rapide
- **Outil**: `nmap`
- **Commande**:
  ```bash
  # Scan rapide des 1000 ports les plus courants
  nmap -F target_ip

  # Scan de tous les ports TCP (plus long)
  nmap -sS -T4 -p- target_ip -oN nmap_all_ports.txt
  ```
- **Objectif**: Identifier rapidement tous les ports ouverts.

### 2.2 Scan Détaillé des Services
Une fois les ports ouverts identifiés, on cherche à savoir ce qui tourne dessus.
- **Outil**: `nmap`
- **Commande**:
  ```bash
  # Remplacez <PORTS> par la liste des ports trouvés (ex: 22,80,443)
  nmap -sV -sC -A -p <PORTS> target_ip -oN nmap_detailed.txt
  ```
- **Objectif**: Obtenir la version des services, lancer des scripts d'énumération de base (`-sC`) et tenter une détection d'OS (`-A`).

### 2.3 Scan de Vulnérabilités (Optionnel)
- **Outil**: `nmap` (avec le "Nmap Scripting Engine")
- **Commande**:
  ```bash
  nmap --script vuln target_ip
  ```
- **Objectif**: Détecter des vulnérabilités connues sur les services identifiés.

---

## 🚨 POINTS DE CONTRÔLE IMPORTANTS
- [ ] Avez-vous sauvegardé tous les résultats de vos scans ?
- [ ] Avez-vous une liste claire des ports ouverts et des services correspondants ?
- [ ] Avez-vous noté les versions des logiciels (ex: Apache 2.4.29, OpenSSH 7.6p1) ?
- [ ] Avez-vous identifié des services potentiellement vulnérables ou mal configurés ?

---

## ➡️ PROCHAINE ÉTAPE
Avec la liste des services web identifiés, la prochaine étape est l'**énumération web** approfondie.
