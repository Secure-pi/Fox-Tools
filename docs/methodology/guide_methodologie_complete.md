# 🎯 GUIDE MÉTHODOLOGIQUE COMPLET - PENTEST

---

## 📚 WORKFLOW COMPLET ÉTAPE PAR ÉTAPE

Le processus d'un test d'intrusion peut être décomposé en plusieurs phases logiques.

### 🔄 MÉTHODOLOGIE GÉNÉRALE :
1.  **RECONNAISSANCE**: Collecte d'informations passives et actives.
    - ➡️ [Voir le guide de Reconnaissance](./guide_reconnaissance.md)
2.  **ÉNUMÉRATION WEB**: Analyse approfondie des applications web.
    - ➡️ [Voir le guide d'Énumération Web](./guide_enumeration_web.md)
3.  **EXPLOITATION**: Tentative de compromission basée sur les vulnérabilités trouvées.
    - ➡️ [Voir le guide d'Exploitation](./guide_exploitation.md)
4.  **POST-EXPLOITATION**: Actions menées après avoir obtenu un accès.
    - ➡️ [Voir le guide de Post-Exploitation](./guide_post_exploitation.md)

---

### ⏱️ TEMPS ESTIMÉS TOTAUX :
- **Reconnaissance**: 2-4 heures
- **Énumération**: 3-6 heures
- **Exploitation**: 1-8 heures (très variable)
- **Documentation & Rapport**: 2-4 heures
- **TOTAL**: Environ 8-22 heures selon la complexité de la cible.

---

### 🛠️ OUTILS PAR PHASE :
- **RECONNAISSANCE**:
  - `theharvester`, `gobuster` (mode dns), `nmap`
- **ÉNUMÉRATION WEB**:
  - `gobuster` (mode dir), `nikto`, `burpsuite`
- **EXPLOITATION**:
  - `sqlmap`, `hashcat`, `john`, `metasploit`, `netcat`, `socat`
- **WI-FI**:
  - `aircrack-ng`, `airodump-ng`, `aireplay-ng`

---

### 🚨 RAPPELS DE SÉCURITÉ IMPORTANTS :
- ⚠️ **TOUJOURS** avoir une autorisation écrite avant de commencer.
- 🔒 Utiliser des environnements de test isolés (VMs, labs).
- 📝 Documenter chaque action, commande et résultat.
- 🧹 Nettoyer ses traces après les tests (supprimer les fichiers, etc.).
- 🎓 L'objectif est d'**APPRENDRE** et de **SÉCURISER**, pas de nuire.

---

### 💻 LABS RECOMMANDÉS POUR PRATIQUER :
- DVWA (Damn Vulnerable Web App)
- Metasploitable 2/3
- Machines Virtuelles sur VulnHub
- HackTheBox (environnement légal et compétitif)
- TryHackMe (parfait pour les débutants)

---

🎉 **BONNE PRATIQUE ET BON APPRENTISSAGE !** 🔒
