# 🔓 JOHN THE RIPPER - GUIDE COMPLET RED TEAM

## 🎯 SYNTAXE DE BASE
```bash
john [options] [fichier_hash]
```

## 🔥 MODES DE CRACK
- `--single`: **Mode "Single"**. Utilise les informations du nom d'utilisateur pour générer des mots de passe potentiels (ex: pour l'utilisateur `jsmith`, il tentera `jsmith`, `smith`, `john`, `smith123`, etc.). Très rapide et efficace.
- `--wordlist=<FILE>`: **Attaque par dictionnaire**. Tente les mots de passe d'une liste fournie.
- `--incremental`: **Attaque incrémentale (Brute-force)**. Tente toutes les combinaisons de caractères. Lent mais exhaustif.
- `--rules`: **Applique des règles de mutation** à une attaque par dictionnaire pour augmenter les chances (ex: `password` -> `P@ssword1`).

## ⚡ FORMATS DE HASH (EXEMPLES)
John détecte souvent le format automatiquement, mais on peut le forcer avec `--format=<NAME>`.
- `--format=crypt`: Hashes `crypt(3)` traditionnels (vieux Linux/Unix).
- `--format=sha512crypt`: Hashes modernes de Linux (SHA-512).
- `--format=NT`: Hashes NTLM de Windows.
- `--format=Raw-MD5`: Hashes MD5 bruts.
- `--format=Raw-SHA1`: Hashes SHA1 bruts.

## 🛡️ PRÉPARATION DES HASHES
John a besoin d'un fichier contenant les hashes à cracker.
```bash
# Extraire les hashes depuis un système Linux
unshadow /etc/passwd /etc/shadow > hashes_linux.txt

# Extraire les hashes depuis un dump de la SAM Windows
samdump2 SYSTEM SAM > hashes_windows.txt
```

## 🚀 ATTAQUES PAR DICTIONNAIRE
```bash
# Attaque simple avec la wordlist rockyou.txt
john --wordlist=/usr/share/wordlists/rockyou.txt hashes.txt

# Attaque sur des hashes NTLM en spécifiant le format
john --format=NT --wordlist=/usr/share/wordlists/rockyou.txt ntlm_hashes.txt

# Attaque avec des règles de mutation
john --wordlist=wordlist.txt --rules hashes.txt
```

## 🔥 ATTAQUES AVANCÉES
```bash
# Mode Single (très efficace pour commencer)
john --single hashes.txt

# Mode incrémental (brute-force de A à Z)
john --incremental hashes.txt

# Mode incrémental limité aux chiffres
john --incremental=Digits hashes.txt
```

## 🎭 GESTION DES SESSIONS ET RÉSULTATS
```bash
# Reprendre une session interrompue
john --restore

# Afficher les mots de passe déjà crackés
john --show hashes.txt

# Afficher uniquement les hashes non-crackés
john --show --left hashes.txt
```

## 🛡️ CRACK DE FICHIERS (ZIP, PDF, SSH)
John (surtout la version "Jumbo") peut cracker des mots de passe de fichiers en extrayant d'abord le hash.
```bash
# 1. Extraire le hash d'une archive ZIP
zip2john archive.zip > zip.hash

# 2. Cracker le hash
john --wordlist=wordlist.txt zip.hash
```
*Des outils similaires existent : `pdf2john`, `ssh2john`, `office2john`, etc.*

---
> ⚠️ **USAGE ÉTHIQUE** : N'utilisez John the Ripper que sur des hashes que vous avez l'autorisation de cracker.
