# 📡 Kismet : Le Guide Pratique

Kismet est bien plus qu'un simple scanner Wi-Fi. C'est une plateforme complète de détection de réseaux sans fil, capable d'identifier le trafic Wi-Fi, Bluetooth, et même certains drones ou autres appareils radio.

Il fonctionne sur un modèle client-serveur : vous lancez le serveur Kismet sur une machine (votre Rapsberry Pi, par exemple), et vous vous y connectez via une interface web depuis n'importe quel autre appareil sur le réseau.

## 🚀 Démarrage Rapide

1.  **Passer votre carte Wi-Fi en mode "Monitor"**
    Kismet a besoin d'une interface en mode monitor pour écouter le trafic. La méthode la plus simple est avec `airmon-ng`.
    ```bash
    # Tuer les processus qui peuvent gêner
    sudo airmon-ng check kill

    # Activer le mode monitor sur votre interface wlan0
    sudo airmon-ng start wlan0
    ```
    *Cela créera une nouvelle interface, souvent nommée `wlan0mon`.*

2.  **Lancer le serveur Kismet**
    ```bash
    sudo kismet -c wlan0mon
    ```
    *L'option `-c` spécifie la source de capture à utiliser.*

3.  **Accéder à l'Interface Web**
    - **URL :** `http://<IP_DE_VOTRE_PI>:2501`
    - **Identifiants par défaut :** `kismet` / `kismet` (il vous sera demandé de changer le mot de passe à la première connexion).

## 📊 Explorer l'Interface Web

- **Dashboard :** Une vue d'ensemble en temps réel de l'activité.
- **Devices :** La liste de **tous** les appareils détectés (points d'accès, clients, appareils Bluetooth, etc.). C'est ici que vous passerez le plus de temps.
- **Networks :** Une vue filtrée qui ne montre que les points d'accès Wi-Fi.

## 💡 Analyse Post-Scan

Kismet sauvegarde tout ce qu'il trouve dans des fichiers de log dans le dossier où vous l'avez lancé. Les deux plus importants sont :

| Extension | Description |
|---|---|
| `.kismet` | Une base de données SQLite contenant toutes les informations sur les réseaux et les appareils. Vous pouvez l'explorer avec des outils comme `sqlite3`. |
| `.pcapng` | Une capture complète de tous les paquets. C'est ce fichier que vous ouvrirez avec **Wireshark** pour une analyse en profondeur du trafic. |

```bash
# Exemple d'analyse d'une capture Kismet avec Wireshark
wireshark Kismet-20230101-01-02-03_1.pcapng
```

## 🔧 Dépannage

- **Problème de permissions ?** Assurez-vous que votre utilisateur fait partie du groupe `kismet`. `sudo usermod -aG kismet $USER` (nécessite de se déconnecter/reconnecter).
- **Aucune source de capture ?** Vérifiez que votre carte Wi-Fi est bien en mode monitor et que vous avez spécifié la bonne interface au lancement avec `-c`.

---
> 🎭 **USAGE ÉTHIQUE UNIQUEMENT** : La capture de trafic réseau sans autorisation est illégale. Utilisez Kismet de manière responsable.
