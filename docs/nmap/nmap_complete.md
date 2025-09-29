# 🗺️ Nmap : Le Guide Complet

Nmap ("Network Mapper") est un outil open source essentiel pour l'exploration de réseaux et l'audit de sécurité. C'est le couteau suisse pour découvrir des machines, les services qu'elles exposent, et les systèmes d'exploitation qu'elles utilisent.

## 🔥 Les Commandes Essentielles

Voici les commandes que vous utiliserez 90% du temps.

| Commande | Description |
|---|---|
| `nmap -sS -T4 <cible>` | **Scan de base, rapide et discret.** C'est le point de départ pour la plupart des situations. |
| `nmap -sn 192.168.1.0/24` | **Découverte d'hôtes.** Permet de lister rapidement toutes les machines actives sur votre réseau local. |
| `nmap -sV -sC -p- <cible>` | **Scan complet et détaillé.** Scanne tous les 65535 ports, détecte les versions (`-sV`) et lance les scripts par défaut (`-sC`). C'est long, mais très complet. |
| `nmap -A -T4 <cible>` | **Scan "Agressif".** Un excellent compromis qui lance la détection d'OS et de versions, les scripts par défaut et un traceroute. |
| `nmap --script vuln <cible>` | **Scan de vulnérabilités.** Utilise le Nmap Scripting Engine (NSE) pour chercher des failles de sécurité connues. |

**Astuce :** Ajoutez `-oA <nom_fichier>` à n'importe quelle commande pour sauvegarder les résultats dans tous les formats (normal, XML et "grepable").

## 💡 Astuces de Pro

- **L'hôte semble hors ligne ?** Utilisez `-Pn` pour forcer le scan de ports même si la machine ne répond pas au ping.
- **Pourquoi un port est "filtré" ?** Ajoutez `--reason` pour que Nmap vous explique pourquoi il a classé un port dans un certain état.
- **Besoin de vitesse ?** `-T4` est votre ami. Pour les CTF ou les labs où le bruit n'est pas un problème, vous pouvez même tenter `-T5` et `--min-rate 1000` (1000 paquets par seconde).
- **Cible en IPv6 ?** Utilisez l'option `-6`.

##  скрипти Scripts NSE : La puissance cachée de Nmap

Le Nmap Scripting Engine (NSE) vous permet d'automatiser des tâches en utilisant des scripts. La commande `--script` est votre porte d'entrée.

### Exemples de scripts utiles :

| Commande de script | Utilité |
|---|---|
| `--script http-enum` | Énumère les dossiers et fichiers intéressants sur un serveur web. |
| `--script smb-enum-shares` | Liste les partages de fichiers SMB (Windows) ouverts. |
| `--script ssl-cert` | Récupère et analyse le certificat SSL d'un site web. |
| `--script ftp-anon` | Vérifie si un serveur FTP autorise les connexions anonymes. |
| `--script dns-brute` | Tente de trouver des sous-domaines par brute-force. |
| `--script "smb-vuln-*"` | Lance tous les scripts de vulnérabilité liés au protocole SMB. Très utile ! |

## 🎭 Techniques de Discrétion

Pour éviter de déclencher les systèmes de détection d'intrusion (IDS) :

- **Fragments :** Utilisez `-f` pour fragmenter les paquets, ce qui peut rendre le scan plus difficile à détecter.
- **Leurres (Decoys) :** Utilisez `-D RND:10 <cible>` pour lancer le scan depuis 10 adresses IP leurres aléatoires en plus de la vôtre. La cible aura plus de mal à savoir d'où vient réellement le scan.

---
> ⚠️ **USAGE ÉTHIQUE** : Nmap est un outil puissant. N'effectuez des scans que sur des réseaux pour lesquels vous avez une autorisation explicite.