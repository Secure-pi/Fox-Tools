# Tutoriel : Hydra

Hydra est souvent décrit comme "la brute des services en ligne". C'est un outil de craquage de mots de passe en réseau, extrêmement rapide et flexible, qui permet de tenter de se connecter à un très grand nombre de services en essayant une liste de noms d'utilisateurs et de mots de passe.

---

## À quoi ça sert ?

Si un scan Nmap révèle un port ouvert pour un service d'authentification (comme SSH, FTP, Telnet, ou un formulaire web), Hydra est l'outil à utiliser pour tenter de deviner les identifiants.

Services supportés :

-   SSH, FTP, Telnet
-   HTTP/HTTPS (formulaires de connexion)
-   Bases de données (MySQL, Postgres...)
-   SMB, RDP, et bien d'autres.

---

## Utilisation et Exemples

La syntaxe de base d'Hydra peut sembler complexe, mais elle est très puissante.

```bash
# Syntaxe générale
hydra -l <utilisateur> -P <fichier_mots_de_passe> <IP_cible> <service>
```

- `-l` : Spécifie un nom d'utilisateur unique.
- `-L` : Spécifie un fichier contenant une liste de noms d'utilisateurs.
- `-p` : Spécifie un mot de passe unique.
- `-P` : Spécifie un fichier contenant une liste de mots de passe.
- `-t` : Nombre de tâches parallèles (threads) pour accélérer l'attaque.

### Exemples concrets

```bash
# Attaquer un service SSH avec l'utilisateur 'root' et une liste de mots de passe
hydra -l root -P /usr/share/wordlists/rockyou.txt 192.168.1.5 ssh

# Attaquer un service FTP avec une liste d'utilisateurs et un seul mot de passe
hydra -L users.txt -p password123 ftp://192.168.1.5

# Attaquer un formulaire de connexion web (plus complexe)
hydra -l admin -P pass.txt 192.168.1.5 http-post-form "/login.php:user=^USER^&pass=^PASS^:F=Login incorrect"
```

---

### 💡 L'Aide du Copilote

Le menu `Password Attacks > Hydra` est l'un des meilleurs exemples d'assistance du copilote.

1.  **Sélection de la Cible :** Le script vous propose automatiquement une liste de cibles issues du butin. Fini les copier-coller d'adresses IP.
2.  **Guidage :** Il vous demande simplement le nom d'utilisateur et le service à attaquer.
3.  **Sélection de Wordlist :** Il vous propose un choix de wordlists (rapide, complète, personnalisée) pour vous éviter de chercher les chemins.
4.  **Automatisation et Analyse :** Le script construit la commande complexe pour vous, la lance, et **analyse les résultats**. S'il trouve un mot de passe valide, il l'affiche en grand, le surligne, et surtout, **l'ajoute automatiquement au butin (`loot.csv`)** avec le type `CREDENTIAL`.

**Avantage :** Le copilote ne se contente pas de lancer l'outil. Il vous guide, automatise la commande, et surtout, il interprète le résultat pour enrichir intelligemment votre base de connaissances sur la cible. C'est un gain de temps et d'efficacité considérable.
