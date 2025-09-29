# 🕷️ Nikto : Le Guide Pratique

Nikto est un scanner de vulnérabilités web. Son but est de tester un serveur web pour des milliers de problèmes connus : fichiers dangereux, configurations obsolètes, et autres failles de sécurité.

**Attention :** Nikto est très "bruyant". Il génère beaucoup de trafic et est facilement détectable par les systèmes de sécurité (IDS/IPS). Utilisez-le sur des cibles où la discrétion n'est pas votre priorité.

## 🔥 Les Commandes Essentielles

| Commande | Description |
|---|---|
| `nikto -h <URL>` | **La base.** Lance un scan complet sur l'URL spécifiée (ex: `http://example.com`). |
| `... -p 80,443,8080` | **Spécifier les ports.** Utile si le serveur web tourne sur des ports non standards. |
| `... -o rapport.html -F html` | **Sauvegarder la sortie.** Enregistre le rapport dans un format spécifié (`html`, `csv`, `xml`, `txt`). |
| `nikto -update` | **Mettre à jour Nikto.** Indispensable à faire régulièrement pour avoir les derniers tests de vulnérabilité. |

### Exemple de scan de base

```bash
# Scanner un site web et sauvegarder les résultats en HTML
nikto -h http://example.com -o rapport_nikto.html -F html
```

## 🎯 Affiner ses Scans avec `-Tuning`

L'option `-Tuning` est la plus importante pour contrôler les tests effectués par Nikto. Vous pouvez combiner les numéros (ex: `-Tuning 125`).

| Option | Description des tests |
|---|---|
| `-Tuning 1` | Fichiers intéressants / Logs |
| `-Tuning 2` | Mauvaises configurations / Fichiers par défaut |
| `-Tuning 3` | Divulgation d'informations (ex: `robots.txt`) |
| `-Tuning 4` | Injection (XSS, etc.) |
| `-Tuning 5` | Opérations de fichiers à distance |
| `-Tuning 9` | Injection SQL |
| `-Tuning x` | **Inverse la sélection.** Exclut les tests dangereux pour ne faire que de la reconnaissance. |

#### Exemples de Tuning

```bash
# Chercher uniquement les failles les plus critiques (Injection, RCE)
nikto -h http://example.com -Tuning 459

# Chercher uniquement des fichiers de configuration et des informations sensibles
nikto -h http://example.com -Tuning 123
```

## 🚀 Nikto + Autres Outils = Efficacité Maximale

Nikto est encore meilleur quand on l'intègre dans une chaîne d'outils.

### Combo avec Nmap

Utilisez Nmap pour trouver tous les serveurs web sur un réseau, puis lancez Nikto sur chacun d'eux.

```bash
# Trouve les ports 80, 443, 8080 ouverts et passe les IPs à Nikto
nmap -p 80,443,8080 192.168.1.0/24 -oG - | awk '/open/{print $2}' | xargs -I{} nikto -h {}
```

### Combo avec Gobuster

Utilisez Gobuster pour trouver des répertoires, puis lancez Nikto sur chaque répertoire trouvé pour une analyse plus profonde.

```bash
# 1. Trouver les répertoires
gobuster dir -u http://example.com -w wordlist.txt -o dirs.txt

# 2. Lancer Nikto sur chaque répertoire qui a un statut 200 OK
while read dir; do nikto -h http://example.com/$dir; done < <(grep "Status: 200" dirs.txt | awk '{print $2}')
```

---
> ⚠️ **ATTENTION AUX FAUX POSITIFS** : Nikto est connu pour remonter des alertes qui ne sont pas de réelles vulnérabilités. Chaque découverte doit être vérifiée manuellement avec des outils comme Burp Suite.