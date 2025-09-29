# ⚡ Masscan : Le Guide Pratique

Masscan est un scanner de ports TCP incroyablement rapide, conçu pour scanner de très larges plages d'adresses IP (y compris tout Internet) en quelques minutes. Il est l'outil parfait pour la phase de découverte initiale.

**Masscan vs Nmap :**
- **Masscan** est optimisé pour la **vitesse** et la **découverte** de ports ouverts sur un grand nombre de cibles.
- **Nmap** est optimisé pour la **précision** et l'**analyse approfondie** d'une seule cible ou d'un petit réseau.

## 🔥 Commandes Essentielles

| Commande | Description |
|---|---|
| `masscan <plage_IP> -p <ports>` | **La base.** Scanne une plage d'IP sur des ports spécifiques. |
| `... --rate <pps>` | **L'option la plus importante.** Définit la vitesse en paquets par seconde (commencez avec `1000`). |
| `... --banners` | Tente de récupérer les bannières des services (peut ralentir le scan). |
| `... -oG <fichier>` | Sauvegarde les résultats dans un format "grepable", facile à traiter. |

### Exemples Concrets

```bash
# Scanner les ports web communs sur un sous-réseau, à 1000 paquets/seconde
sudo masscan 192.168.1.0/24 -p80,443,8080 --rate=1000

# Scanner tous les ports d'une seule IP, et sauvegarder le résultat
sudo masscan 192.168.1.100 -p1-65535 --rate=1000 -oG resultats.gnmap
```
*Note : `sudo` est souvent nécessaire pour que Masscan puisse envoyer des paquets à haute vitesse.*

## 🚀 Le Workflow Parfait : Masscan + Nmap

La meilleure stratégie est de combiner la vitesse de Masscan et la précision de Nmap.

1.  **Découvrir les ports ouverts avec Masscan.**
    ```bash
    sudo masscan 192.168.1.100 -p1-65535 --rate=1000 -oG scan_masscan.txt
    ```

2.  **Analyser les ports trouvés avec Nmap.**
    Utilisez une petite commande `awk` pour extraire les ports du fichier de résultats de Masscan et les passer à Nmap.
    ```bash
    sudo nmap -sV -sC -p$(awk -F'[ /]' '/open/{print $5}' scan_masscan.txt | tr '\n' ',') 192.168.1.100
    ```
    *Cette commande lance un scan Nmap détaillé (`-sV`, `-sC`) **uniquement** sur les ports que Masscan a trouvés ouverts, vous faisant gagner un temps précieux.*

## ⚠️ Précautions d'Usage

- **Légalité :** Ne scannez jamais des réseaux sans autorisation. Un scan de ports à haute vitesse est très facile à détecter et peut être considéré comme une attaque.
- **Vitesse :** Une valeur `--rate` trop élevée peut impacter votre propre réseau ou celui de la cible. Augmentez progressivement.
- **Précision :** Masscan est optimisé pour la vitesse et peut parfois manquer des ports. Pour un audit de sécurité final, un scan Nmap complet reste la référence.

---
> 💡 **Conclusion :** Utilisez Masscan pour la reconnaissance à grande échelle, puis Nmap pour l'analyse détaillée des cibles intéressantes que vous avez trouvées.
