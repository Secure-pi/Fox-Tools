# ⚡ HASHCAT - GUIDE COMPLET RED TEAM

## 🎯 SYNTAXE DE BASE
```bash
hashcat [options] [hashfile] [wordlist/mask]
```

## 🔥 MODES DE HASH (EXEMPLES)
- `0`: MD5
- `100`: SHA1
- `1400`: SHA256
- `1700`: SHA512
- `1000`: NTLM (Hashes de mots de passe Windows)
- `3000`: LM (Anciens hashes Windows)
- `1800`: sha512crypt (Hashes de mots de passe Linux modernes)
- `13400`: KeePass 1 (AES)

*Utilisez `hashcat --help` pour voir la liste complète des milliers de modes de hash supportés.*

## ⚡ TYPES D'ATTAQUES (`-a`)
- `-a 0`: **Attaque par dictionnaire**: Tente des mots de passe depuis une wordlist.
- `-a 1`: **Attaque par combinaison**: Combine des mots de deux dictionnaires.
- `-a 3`: **Attaque par masque (Brute-force)**: Tente toutes les combinaisons possibles selon un masque défini.
- `-a 6`: **Attaque hybride (Dico + Masque)**: Ajoute un masque à la fin des mots d'un dictionnaire.
- `-a 7`: **Attaque hybride (Masque + Dico)**: Ajoute un masque au début des mots d'un dictionnaire.

## 🛡️ ATTAQUE PAR DICTIONNAIRE (`-a 0`)
```bash
# Attaque simple sur des hashes MD5
hashcat -m 0 -a 0 hashes.txt /usr/share/wordlists/rockyou.txt

# Attaque sur des hashes NTLM (Windows)
hashcat -m 1000 -a 0 ntlm_hashes.txt /usr/share/wordlists/rockyou.txt

# Attaque en utilisant des règles de mutation pour augmenter les chances
# (ex: password -> Password, p@ssword, Password123)
hashcat -m 0 -a 0 -r /usr/share/hashcat/rules/best64.rule hashes.txt wordlist.txt
```

## 🚀 ATTAQUE PAR MASQUE (`-a 3`)
### Masques de caractères
- `?l`: Lettre minuscule (a-z)
- `?u`: Lettre majuscule (A-Z)
- `?d`: Chiffre (0-9)
- `?s`: Symbole spécial
- `?a`: Tous les caractères (`?l?u?d?s`)

### Exemples d'attaques par masque
```bash
# Brute-force de tous les mots de passe de 6 chiffres
hashcat -m 0 -a 3 hashes.txt ?d?d?d?d?d?d

# Brute-force d'un mot de passe comme "PasswordXX"
hashcat -m 0 -a 3 hashes.txt Password?d?d

# Brute-force de tous les mots de passe de 8 caractères
hashcat -m 0 -a 3 hashes.txt ?a?a?a?a?a?a?a?a
```

## 🔥 ATTAQUES HYBRIDES
```bash
# Dictionnaire + masque à la fin (ex: mot_de_passe123)
hashcat -m 0 -a 6 hashes.txt wordlist.txt ?d?d?d

# Masque au début + dictionnaire (ex: 123mot_de_passe)
hashcat -m 0 -a 7 hashes.txt ?d?d?d wordlist.txt
```

## ⚡ RÈGLES DE MUTATION
Les règles transforment les mots de votre dictionnaire pour créer de nouvelles tentatives.
- **Emplacement des règles :** `/usr/share/hashcat/rules/`
- **Règles populaires :** `best64.rule`, `rockyou-30000.rule`, `d3ad0ne.rule`.
```bash
hashcat -m 0 -a 0 -r /usr/share/hashcat/rules/best64.rule hashes.txt wordlist.txt
```

## 🎭 OPTIONS DE PERFORMANCE
- `-w <level>`: Niveau de charge de travail (`1`=léger, `3`=intense).
- `-O`: Active les optimisations du noyau (recommandé pour les mots de passe < 16 caractères).
- `--force`: Force le lancement même si des avertissements sont présents.
- `-d <id>`: Utiliser un GPU spécifique (lister avec `hashcat -I`).

## 🚀 SESSIONS & RÉSULTATS
```bash
# Nommer une session pour pouvoir la mettre en pause et la reprendre
hashcat -m 0 -a 0 --session=mysession hashes.txt wordlist.txt

# Reprendre une session
hashcat --restore --session=mysession

# Afficher les mots de passe déjà trouvés
hashcat -m 0 --show hashes.txt

# Afficher uniquement les hashes qui n'ont pas été cassés
hashcat -m 0 --left hashes.txt
```

---
> ⚠️ **PERFORMANCE & USAGE ÉTHIQUE** : Hashcat est extrêmement puissant sur GPU. Surveillez la température de votre matériel. N'utilisez cet outil que pour des audits autorisés.
