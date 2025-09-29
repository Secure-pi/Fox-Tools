# 🗺️ Nmap : Le Couteau Suisse de l'Exploration Réseau

Nmap (Network Mapper) est l'un des outils les plus fondamentaux et les plus puissants de l'arsenal de tout hacker, administrateur système ou professionnel de la sécurité. Pensez-y comme à une carte et un sonar pour n'importe quel réseau.

---

### 🎯 **Objectif Principal**

L'objectif de Nmap est de découvrir des hôtes (ordinateurs, serveurs, etc.) sur un réseau et d'apprendre une quantité massive d'informations à leur sujet, notamment :

*   Quels ports sont ouverts, fermés ou filtrés par un pare-feu.
*   Quels services (applications) tournent sur ces ports (ex: un serveur web, un service SSH).
*   Quel système d'exploitation (OS) est utilisé par la machine cible.
*   Parfois même, des informations sur les vulnérabilités potentielles de ces services.

---

### 🛠️ **Les Recettes Essentielles de Nmap**

Voici des "recettes" pratiques pour utiliser Nmap, de la plus simple à la plus complexe.

#### 1. Le Scan Ping : "Qui est à la maison ?"

C'est le scan le plus basique. Il répond à la question : "Quelles machines sont allumées sur ce réseau ?".

```bash
# Scanne tout le sous-réseau 192.168.1.0/24
sudo nmap -sn 192.168.1.0/24
```

*   `-sn` : C'est un "scan ping". Il ne scanne pas les ports, il se contente de vérifier si les hôtes répondent. C'est rapide et relativement discret.

#### 2. Le Scan des Ports Courants : "Montre-moi tes portes d'entrée"

C'est le scan par défaut et le plus courant. Il teste les 1000 ports les plus utilisés.

```bash
# Scanne les 1000 ports les plus courants sur la machine 192.168.1.10
nmap 192.168.1.10
```

*   **Résultat typique :** Vous verrez une liste de ports avec leur état (`open`, `closed`, `filtered`).

#### 3. Le Scan de Services et Versions : "Qui es-tu et que fais-tu ?"

C'est là que Nmap devient vraiment puissant. Il ne se contente pas de voir si un port est ouvert, il essaie de deviner quel service tourne dessus et sa version.

```bash
# Scanne la cible pour détecter les services et leurs versions
sudo nmap -sV 192.168.1.10
```

*   `-sV` : Demande à Nmap de sonder les ports ouverts pour déterminer la version du service. C'est crucial, car une version obsolète d'un logiciel peut être vulnérable.

#### 4. La Détection d'OS : "Quel est ton ADN ?"

Nmap peut souvent deviner le système d'exploitation de la cible en analysant la façon dont elle répond aux paquets réseau.

```bash
# Tente de deviner l'OS de la cible
sudo nmap -O 192.168.1.10
```

*   `-O` : Active la détection d'OS. Nécessite les privilèges `sudo`.

#### 5. Le Scan "Agressif" : Le Combo Ultime

Le mode agressif est un raccourci qui active plusieurs options en même temps pour un scan très complet.

```bash
# Lance un scan agressif, rapide et bruyant
sudo nmap -A 192.168.1.10
```

*   `-A` : Active la détection d'OS (`-O`), la détection de version (`-sV`), le scan par scripts (`-sC`) et le traceroute. C'est un excellent choix pour les audits rapides où la discrétion n'est pas une priorité (ex: CTF, labs).

---

### ✨ **Astuces de Pro**

*   **Vitesse** : Pour accélérer un scan, vous pouvez utiliser l'option `-T4` (agressif) ou `-T5` (insane). Attention, c'est très bruyant et peut être détecté.
    ```bash
    sudo nmap -T4 -F 192.168.1.10  # -F pour un scan rapide des 100 ports les plus courants
    ```

*   **Scripts (NSE)** : Nmap possède un moteur de scripts (NSE - Nmap Scripting Engine) incroyablement puissant. Le `-sC` (inclus dans `-A`) lance les scripts par défaut. Vous pouvez aussi cibler des scripts spécifiques.
    ```bash
    # Lance tous les scripts de la catégorie "vuln" (vulnérabilité)
    sudo nmap --script vuln 192.168.1.10
    ```

*   **Sauvegarde des résultats** : Pour garder une trace de vos scans, sauvegardez-les dans différents formats.
    ```bash
    # Sauvegarde dans tous les formats (normal, XML, grepable)
    sudo nmap -A -oA mon_scan 192.168.1.10
    ```
    Cela créera `mon_scan.nmap`, `mon_scan.xml`, et `mon_scan.gnmap`.

---

Ce guide ne fait qu'effleurer la surface de ce que Nmap peut faire. C'est un outil profond qui récompense la pratique et l'expérimentation. Lancez-le, testez chaque option, et il deviendra rapidement un de vos meilleurs alliés.
