# Tutoriel : Attaquer le Wi-Fi avec la suite Aircrack-ng

La suite Aircrack-ng est un ensemble d'outils permettant d'auditer la sécurité des réseaux sans fil. Le scénario le plus courant est de cracker une clé WPA/WPA2 en capturant un "handshake" (poignée de main) puis en utilisant une attaque par dictionnaire hors ligne.

Ce processus implique plusieurs outils de la suite qui fonctionnent ensemble.

---

## Les 4 Étapes Clés et les Outils Associés

### Étape 1 : Activer le Mode Moniteur avec `airmon-ng`

Pour pouvoir écouter tout le trafic Wi-Fi qui passe dans l'air (et pas seulement celui destiné à votre machine), vous devez mettre votre carte Wi-Fi en "mode moniteur".

-   **Rôle :** Transforme votre carte Wi-Fi en un sniffer réseau.

### Étape 2 : Capturer le Trafic avec `airodump-ng`

Une fois en mode moniteur, `airodump-ng` est utilisé pour scanner les réseaux aux alentours et, une fois une cible choisie, pour écouter et capturer le trafic de ce réseau spécifique.

-   **Objectif :** Capturer une **"poignée de main WPA" (WPA handshake)**. C'est un échange de 4 paquets qui se produit lorsqu'un appareil se connecte légitimement au réseau. Ce handshake contient les informations nécessaires pour tenter de cracker le mot de passe.

### Étape 3 : Forcer un Handshake avec `aireplay-ng` (Optionnel mais recommandé)

Parfois, aucun appareil ne se connecte pendant que vous écoutez. Pour accélérer les choses, vous pouvez utiliser `aireplay-ng` pour envoyer des paquets de "désauthentification" à un appareil déjà connecté. Cela va le déconnecter brièvement et le forcer à se reconnecter immédiatement, produisant ainsi le précieux handshake que `airodump-ng` pourra capturer.

-   **Rôle :** Accélérer la capture du handshake.

### Étape 4 : Cracker le mot de passe avec `aircrack-ng`

C'est l'étape finale. `aircrack-ng` prend le fichier de capture contenant le handshake et une wordlist (liste de mots de passe), et essaie chaque mot de passe de la liste jusqu'à trouver le bon.

-   **Rôle :** Craquage hors ligne par dictionnaire.

---

### 💡 L'Aide du Copilote

Réaliser ce processus manuellement nécessite souvent plusieurs terminaux et des commandes complexes. Le menu `Wireless Attacks` de FOX a été conçu pour orchestrer ce ballet complexe.

1.  **`[1] Monitor Mode Setup` :** Vous aide à choisir votre carte Wi-Fi et la passe en mode moniteur avec `airmon-ng`.
2.  **`[2] Network Scanning` :** Lance `airodump-ng` pour vous montrer les réseaux disponibles, leur BSSID, leur canal, et les clients connectés.
3.  **`[4] Handshake Capture` :** C'est ici que la magie opère. Le script vous demande le BSSID et le canal de la cible, puis lance `airodump-ng` configuré spécifiquement pour n'écouter que cette cible et sauvegarder la capture dans un fichier `.cap` au sein de votre projet.
4.  **`[3] Deauth Attack` :** Pendant que la capture tourne (dans un autre terminal ou via le script), cette option vous guide pour utiliser `aireplay-ng` et envoyer des paquets de deauth, accélérant la capture.

**Avantage :** Le copilote transforme un processus d'attaque Wi-Fi complexe en une série d'étapes guidées. Il automatise les commandes, organise les fichiers de capture, et vous permet de vous concentrer sur la stratégie plutôt que sur la syntaxe, rendant l'audit de réseaux sans fil beaucoup plus accessible.
