# 🐍 Medusa : Le Guide Pratique

Medusa est un outil de brute-force de login rapide, parallèle et modulaire. Il est réputé pour sa stabilité, ce qui en fait une excellente alternative à Hydra, notamment contre des services réseau peu fiables.

## Medusa vs. Hydra : Lequel Choisir ?

| Caractéristique | Medusa | Hydra |
|---|---|---|
| **Stabilité** | ⭐⭐⭐⭐⭐ (Très stable) | ⭐⭐⭐ (Parfois instable) |
| **Vitesse** | ⭐⭐⭐⭐ (Très rapide) | ⭐⭐⭐⭐ (Très rapide) |
| **Flexibilité** | ⭐⭐ (Moins d'options) | ⭐⭐⭐⭐⭐ (Très flexible, surtout pour le web) |
| **Modules** | Bon support des protocoles standards | Supporte plus de protocoles et de cas spécifiques |

**Conclusion :** Commencez avec Hydra pour sa flexibilité. Si Hydra est instable ou échoue, passez à Medusa pour sa robustesse.

## 🔥 Syntaxe et Options Clés

| Option | Description |
|---|---|
| `-h <HÔTE>` | Hôte cible unique. |
| `-H <FICHIER>` | Fichier contenant une liste d'hôtes. |
| `-u <USER>` | Nom d'utilisateur unique. |
| `-U <FICHIER>` | Fichier de noms d'utilisateur. |
| `-p <PASS>` | Mot de passe unique. |
| `-P <FICHIER>` | Fichier de mots de passe. |
| `-M <MODULE>` | Module à utiliser (ex: `ssh`, `ftp`, `rdp`). |
| `-t <NUM>` | Nombre de threads (connexions parallèles). |
| `-f` | Arrête l'attaque dès qu'une combinaison valide est trouvée. |

## 🎯 Exemples d'Attaques

```bash
# Attaque SSH simple avec une liste de mots de passe
medusa -h 192.168.1.100 -u root -P passwords.txt -M ssh

# Attaque RDP (Remote Desktop) sur un hôte Windows
medusa -h 192.168.1.200 -u Administrator -P passwords.txt -M rdp -f

# Attaque sur plusieurs hôtes en même temps
medusa -H hosts.txt -U users.txt -P passwords.txt -M ssh
```

## 🚀 Stratégies d'Attaque

### 1. Attaque Ciblée
Si vous avez un nom d'utilisateur, concentrez-vous sur le brute-force de son mot de passe.
```bash
medusa -h target.com -u user_connu -P /usr/share/wordlists/rockyou.txt -M ssh -f
```

### 2. "Password Spraying" (Pulvérisation de Mots de Passe)
C'est une technique plus discrète. On essaie un ou deux mots de passe très courants (ex: `Password123`, `Summer2024`) contre une longue liste d'utilisateurs. Cela évite de bloquer les comptes.
```bash
medusa -h target.com -U users.txt -p "Summer2024" -M ssh
```

---
> ⚠️ **USAGE ÉTHIQUE** : Les attaques par force brute sont bruyantes et facilement détectables. N'utilisez Medusa que sur des systèmes pour lesquels vous avez une autorisation explicite.
