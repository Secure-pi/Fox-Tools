# 🌪️ Wfuzz : Le Guide Pratique

Wfuzz est un fuzzer d'applications web extrêmement flexible. Son principe est simple : vous lui donnez une requête HTTP et une liste de mots (payload), et il remplacera le mot-clé `FUZZ` dans la requête par chaque mot de votre liste.

## 🔥 Syntaxe et Options Clés

La puissance de Wfuzz vient de ses options de payload et de filtrage.

| Option | Description |
|---|---|
| `-c` | Active la sortie en couleur, indispensable pour la lisibilité. |
| `-z <payload>` | **L'option principale.** Définit le payload. Le plus courant est `file,<wordlist>`. |
| `-d <data>` | Spécifie les données pour une requête POST. |
| `-H <header>` | Ajoute ou modifie un en-tête HTTP. |
| `--hc <codes>` | **Filtre essentiel.** Cache les codes de statut HTTP spécifiés (ex: `--hc 404` pour cacher les "Not Found"). |
| `--hs <string>` | Cache les réponses contenant une chaîne de caractères spécifique (ex: `--hs "Login Failed"`). |
| `-t <num>` | Nombre de threads (connexions simultanées). |

## 🎯 Exemples de Fuzzing

### 1. Découverte de Dossiers et Fichiers
Similaire à Gobuster, mais avec plus de flexibilité pour le filtrage.
```bash
wfuzz -c -z file,/usr/share/wordlists/dirb/common.txt --hc 404 http://example.com/FUZZ
```

### 2. Fuzzing de Paramètres GET
Pour découvrir des vulnérabilités comme les IDOR (Insecure Direct Object References).
```bash
# Teste les IDs de 1 à 1000 sur la page `view_profile.php`
wfuzz -c -z range,1-1000 --hc 404 "http://example.com/profiles/view_profile.php?id=FUZZ"
```

### 3. Brute-force d'un Login (POST)
```bash
# Tente de trouver le mot de passe de l'utilisateur "admin"
wfuzz -c -z file,passwords.txt -d "user=admin&password=FUZZ" --hs "Incorrect" http://example.com/login
```
*Ici, `--hs "Incorrect"` cache toutes les réponses qui contiennent le mot "Incorrect", ne vous laissant que les tentatives potentiellement réussies.*

### 4. Fuzzing de Sous-domaines (Virtual Hosts)
On modifie l'en-tête `Host` pour trouver des sous-domaines qui pointent vers la même IP.
```bash
wfuzz -c -z file,subdomains.txt -H "Host: FUZZ.example.com" --hc 404 http://<IP_DU_SERVEUR>/
```

## 🚀 Utilisation de Plusieurs Payloads

Wfuzz peut gérer plusieurs points d'injection (`FUZZ`, `FUZ2Z`, etc.), ce qui est parfait pour le brute-force de formulaires.

```bash
# Brute-force simultané de l'utilisateur et du mot de passe
wfuzz -c -z file,users.txt -z file,passwords.txt -d "user=FUZZ&pass=FUZ2Z" --hs "Error" http://example.com/login
```

---
> ⚠️ **USAGE ÉTHIQUE** : Le fuzzing peut être très intensif pour un serveur web. Utilisez des délais (`-s`) et un nombre de threads (`-t`) raisonnables, et n'effectuez ces tests qu'avec une autorisation.
