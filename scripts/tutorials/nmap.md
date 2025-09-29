# Tutoriel Approfondi : Nmap

Nmap (Network Mapper) est le couteau suisse de l'exploration réseau. Il permet de découvrir quels hôtes sont actifs sur un réseau, quels ports sont ouverts, quels services (et leurs versions) tournent sur ces ports, et même de détecter des vulnérabilités grâce à son moteur de scripts (NSE).

---

## 1. Découverte d'Hôtes (Ping Sweep)

Avant d'attaquer une machine, il faut la trouver. Le "Ping Sweep" permet de lister rapidement les machines actives sur un sous-réseau.

```bash
# Scanne tout le sous-réseau 192.168.1.0/24 pour trouver les hôtes actifs
sudo nmap -sn 192.168.1.0/24
```

- `-sn` : C'est un "scan sans ports". Nmap envoie juste un ping pour voir qui répond. C'est rapide et discret.

### 💡 L'Aide du Copilote
Dans le menu `Réseau > Host Discovery`, le script vous propose automatiquement votre sous-réseau actuel, mais vous pouvez en spécifier un autre. Les résultats sont sauvegardés et les IP découvertes sont ajoutées au butin (`loot.csv`) pour être réutilisées plus tard.

---

## 2. Scan de Ports

Une fois une cible identifiée, on cherche les portes d'entrée : les ports ouverts.

```bash
# Scan les 1000 ports les plus courants (rapide et efficace)
nmap 192.168.1.42

# Scan de ports spécifiques
nmap -p 22,80,443 192.168.1.42

# Scan de TOUS les 65535 ports TCP (très long !)
nmap -p- 192.168.1.42
```

- `-p` : Permet de spécifier les ports. `-p-` est un raccourci pour `-p 1-65535`.

### 💡 L'Aide du Copilote
Dans les menus `Réseau > Port Scanning` ou `Service Detection`, le script vous présente une liste de cibles potentielles issues du butin (la cible principale du projet et les hôtes découverts). **Vous n'avez plus besoin de vous souvenir des IP et de les retaper**, il suffit de choisir dans la liste.

---

## 3. Détection de Services et d'OS

Savoir qu'un port est ouvert, c'est bien. Savoir *quel service* tourne dessus, c'est mieux !

```bash
# Tente d'identifier la version du service et le système d'exploitation
sudo nmap -sV -O 192.168.1.42
```

- `-sV` : Active la détection de version des services. Nmap envoie des sondes pour interroger le service et deviner ce que c'est (ex: "Apache httpd 2.4.41" au lieu de juste "http").
- `-O` : Tente de deviner le système d'exploitation (OS) de la cible. Nécessite les droits `sudo`.

Les informations de version sont cruciales pour trouver des exploits connus.

### 💡 L'Aide du Copilote
La fonction `Service Detection` ajoute automatiquement les services découverts (ex: "ftp", "http") au butin. Le menu principal lira ensuite ce butin et vous proposera des **suggestions contextuelles** ! Par exemple, s'il voit un service "ftp", il vous suggérera de lancer une attaque brute-force avec Hydra.

---

## 4. Scan de Vulnérabilités avec les Scripts NSE

Nmap peut devenir un scanner de vulnérabilités basique grâce au "Nmap Scripting Engine" (NSE).

```bash
# Lance les scripts de la catégorie "vuln" sur les ports ouverts
sudo nmap -sV --script vuln 192.168.1.42
```

- `--script vuln` : Demande à Nmap de lancer tous ses scripts marqués comme étant des recherches de vulnérabilités. C'est un excellent moyen de trouver des failles "faciles" sans sortir l'artillerie lourde.