# Tutoriel : Bettercap, le framework Man-in-the-Middle

Bettercap est un framework puissant et modulaire pour réaliser des attaques Man-in-the-Middle (MitM). Son but est de se placer entre une cible et le reste du réseau pour intercepter, visualiser et modifier le trafic à la volée.

C'est un outil très puissant qui remplace des outils plus anciens comme Ettercap.

---

## Concepts Clés

Bettercap fonctionne avec un système de modules interactifs appelés **"caplets"**. Vous démarrez Bettercap, puis vous activez les modules dont vous avez besoin.

Les modules les plus importants sont :

-   `net.recon` : Pour la découverte des hôtes sur le réseau.
-   `arp.spoof` : Pour réaliser l'attaque de spoofing ARP, qui redirige le trafic de la cible vers votre machine.
-   `net.sniff` : Pour sniffer (capturer) le trafic.
-   `http.proxy` / `https.proxy` : Pour intercepter le trafic web.
-   `dns.spoof` : Pour mentir sur les adresses IP correspondant à des noms de domaine.

---

## Utilisation de base (Session Interactive)

Bettercap s'utilise principalement en mode interactif. Voici un scénario simple pour voir les appareils sur le réseau et sniffer leurs requêtes HTTP.

1.  **Lancer Bettercap** sur une interface réseau.
    ```bash
    sudo bettercap -iface eth0
    ```

2.  **Démarrer la découverte du réseau.** Une fois dans le shell de Bettercap, tapez :
    ```
    net.recon on
    ```
    Bettercap va commencer à lister les appareils qu'il trouve.

3.  **Activer le spoofer et le sniffer.**
    ```
    # Dites à Bettercap de cibler une IP spécifique
    set arp.spoof.targets 192.168.1.42
    arp.spoof on
    net.sniff on
    ```

À partir de ce moment, Bettercap intercepte le trafic de la cible. Vous verrez les URLs visitées, et potentiellement des identifiants et des cookies si les sites ne sont pas en HSTS.

Pour arrêter un module, utilisez `off` (ex: `arp.spoof off`). Pour quitter, tapez `q` ou `quit`.

---

### 💡 L'Aide du Copilote

Le menu `PRO > Bettercap` vous donne un accès direct à cet outil avancé.

1.  **Vérification et Installation :** Le script vérifie si Bettercap est installé. Si ce n'est pas le cas, il vous propose de l'installer automatiquement.
2.  **Lancement Interactif :** Le copilote lance Bettercap pour vous avec les droits `sudo` nécessaires, en s'assurant que l'outil est prêt à l'emploi.
3.  **Gestion du Processus :** Le script gère le processus de Bettercap. Lorsque vous quittez Bettercap (avec `q` ou `Ctrl+C`), vous revenez proprement au menu de FOX, sans que le script principal ne s'arrête.

**Avantage :** Le copilote facilite l'accès et la gestion de cet outil complexe, vous permettant de vous lancer directement dans votre session d'attaque MitM.
