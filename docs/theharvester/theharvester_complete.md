# 🔍 THEHARVESTER - GUIDE COMPLET RED TEAM

## 🎯 DESCRIPTION
`theHarvester` est un outil de collecte d'informations open source (OSINT) simple mais puissant. Il rassemble des e-mails, des noms, des sous-domaines, des adresses IP et des URL à partir de différentes sources publiques comme les moteurs de recherche et Shodan.

## 🚀 SYNTAXE DE BASE
```bash
theharvester -d <DOMAINE> -b <SOURCE> -l <LIMITE> -f <FICHIER_SORTIE>
```

## 🔥 SOURCES PRINCIPALES (`-b`)
- **Moteurs de recherche**: `google`, `bing`, `yahoo`, `duckduckgo`
- **DNS Passif**: `dnsdumpster`, `crtsh`, `virustotal`
- **Réseaux Sociaux**: `linkedin`, `twitter`
- **Scanners Publics (Clé API requise)**: `shodan`, `censys`
- **Raccourcis**:
  - `passive`: Utilise toutes les sources passives qui ne nécessitent pas de clé API.
  - `all`: Utilise **toutes** les sources disponibles (peut être très long).

## ⚡ COMMANDES ESSENTIELLES
```bash
# Recherche de base via Google, limite de 100 résultats
theharvester -d target.com -b google -l 100

# Utiliser plusieurs sources
theharvester -d target.com -b google,bing,yahoo -l 150

# Reconnaissance passive complète (recommandé pour commencer)
theharvester -d target.com -b passive -l 300

# Sauvegarder les résultats en XML et JSON
theharvester -d target.com -b google -l 100 -f results
```
*Les résultats sont sauvegardés dans `results.xml` and `results.json`.*

## 🛡️ SCÉNARIOS RED TEAM

### Phase 1 : Reconnaissance Passive Initiale
L'objectif est de collecter des informations sans alerter la cible.
```bash
theharvester -d client.com -b dnsdumpster,crtsh,virustotal -l 200 -f recon_passive
```

### Phase 2 : Recherche d'E-mails et de Personnel
Idéal pour préparer des campagnes de phishing.
```bash
theharvester -d client.com -b google,linkedin,twitter -l 100 -f recon_personnel
```

## 📊 ANALYSE DES RÉSULTATS
Les résultats sont souvent dans un fichier JSON ou XML. Vous pouvez utiliser `grep` et `jq` pour les analyser.
```bash
# Extraire les e-mails uniques d'un fichier JSON
cat results.json | jq -r '.emails[]' | sort -u

# Extraire les hôtes uniques
cat results.json | jq -r '.hosts[]' | sort -u | cut -d':' -f1
```

## 🔧 CONFIGURATION AVANCÉE
Les clés d'API pour les services comme Shodan, Censys, Hunter.io, etc., se configurent dans le fichier `api-keys.yaml`.
- **Emplacement**: `~/.theHarvester/api-keys.yaml` ou `/etc/theHarvester/api-keys.yaml`.

---
> 💡 **BONNES PRATIQUES**
> - Toujours commencer par des sources passives (`-b passive`).
> - Sauvegarder les résultats avec `-f`.
> - Croiser les informations de plusieurs sources pour une meilleure fiabilité.
> - Respecter les limites de requêtes (`-l`) pour ne pas se faire bloquer.
