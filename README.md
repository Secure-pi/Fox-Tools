# 🦊 Fox V2.0 - Ultimate Pentesting Toolkit

Fox V2.0 est un framework en ligne de commande, **optimisé pour les environnements légers comme le Raspberry Pi**, conçu pour simplifier et automatiser les différentes phases d'un test d'intrusion. Il agit comme un "copilote", en vous guidant à travers les menus et en lançant les outils de pentesting les plus courants de manière structurée.

## 🚀 Démarrage Rapide

Le cœur du projet est le script `fox.sh`.

```bash
# Assurez-vous que le script est exécutable
chmod +x scripts/fox.sh

# Lancez le toolkit
./scripts/fox.sh
```

## ⚙️ Installation (Recommandé)

Pour une utilisation simplifiée, vous pouvez installer le script `fox` comme une commande globale sur votre système. Cela vous permettra de lancer le toolkit en tapant simplement `fox` depuis n'importe quel dossier.

L'installateur va créer un raccourci dans `/usr/local/bin/fox`.

```bash
# Lancez le script d'installation
./install.sh
```

Une fois l'installation terminée, vous pouvez simplement utiliser la commande `fox` :

```bash
# Lancez le toolkit de n'importe où
fox
```

## 🎯 Le Concept de "Projet"

Au premier lancement, le script vous demandera de définir une **cible**. C'est le concept central du toolkit.

1.  **Créer un Projet :** Entrez un nom pour votre cible (ex: `test_lab`, `client_x`).
2.  **Structure de Dossiers :** Le script créera automatiquement une arborescence de dossiers dédiée à votre projet dans le répertoire `projects/`.
    ```
    projects/
    └── test_lab/
        ├── exploits/
        ├── loot/
        ├── reports/
        ├── scans/
        └── web/
    ```
3.  **Centralisation :** Tous les résultats de vos scans, les rapports, et le "butin" (credentials, etc.) seront automatiquement sauvegardés dans le dossier de votre projet actif. Cela garde votre travail propre et organisé.

##  navigating_the_menus Naviguer dans les Menus

Le toolkit est entièrement piloté par des menus en ligne de commande. La structure est conçue pour suivre les phases d'un pentest.

| Menu | Description |
|---|---|
| `[1] Web Testing` | Outils pour le web (Gobuster, SQLMap, Nikto...). |
| `[2] Network Recon` | Scans réseau (Nmap, Masscan...). |
| `[3] Wireless Attacks` | Outils pour le Wi-Fi (Aircrack-ng...). |
| `[4] Exploitation` | Accès aux frameworks comme Metasploit. |
| `[5] Forensics` | Outils d'analyse (Binwalk, Foremost...). |
| `[6] OSINT & Recon` | Outils de reconnaissance (Sherlock, theHarvester...). |
| `[8] Reporting` | Génération de rapports à partir de vos résultats. |
| `[9] System Maintenance` | Mise à jour des outils, nettoyage du système. |

## 📚 Accéder à la Documentation

Besoin d'un rappel sur une commande ? Le toolkit intègre toute la documentation que nous avons finalisée.

-   Depuis le menu principal, choisissez l'option `[d] Documentation`.
-   Un menu dynamique vous listera tous les guides disponibles.
-   Vous pourrez y lire des guides pratiques et des antisèches pour chaque outil, directement depuis votre terminal.

---
> 🛡️ **Rappel Éthique :** Ce toolkit est conçu pour des tests d'intrusion légaux et autorisés. Assurez-vous toujours d'avoir une permission écrite avant de lancer un audit.
