#!/bin/bash

# ========== PROXMARK3 INSTALLER ========== 
install_proxmark3() {
    echo -e "${BLUE}Installation de Proxmark3...${NC}"
    # Le paquet peut varier, 'proxmark3' est commun sur les systèmes basés sur Debian/Kali
    sudo apt update && sudo apt install -y proxmark3
}

# ========== RFID/NFC ANALYSIS (PROXMARK3) ==========
rfid_analysis_menu() {
    if ! command -v pm3 &>/dev/null; then
        echo -e "${RED}Le client Proxmark3 (pm3) n'est pas installé.${NC}"
        read -r -p "Voulez-vous l'installer maintenant? (y/N): " confirm
        if [[ "$confirm" =~ ^[Yy]$ ]]; then
            install_proxmark3
        fi
        # Re-check after install attempt
        if ! command -v pm3 &>/dev/null; then
            echo -e "${RED}Installation échouée ou outil non trouvé. Retour au menu.${NC}"
            sleep 2
            return
        fi
    fi

    clear
    show_fox
    echo -e "${BLUE}${BOLD}💳 RFID/NFC ANALYSIS (Proxmark3) 💳${NC}"
    echo "====================================================="
    echo -e "${YELLOW}Menu débloqué car un Proxmark3 a été détecté!${NC}"
    echo ""
    echo -e "${CYAN}--- CHEAT SHEET - COMMANDES UTILES ---${NC}"
    echo "Une fois dans le client 'pm3', voici quelques commandes pour commencer :"
    echo ""
    echo -e "${BOLD}Détection de cartes :${NC}"
    echo -e "  ${GREEN}hf search${NC}       # Détecter une carte Haute Fréquence (13.56MHz)"
    echo -e "  ${GREEN}lf search${NC}       # Détecter une carte Basse Fréquence (125KHz)"
    echo ""
    echo -e "${BOLD}Lecture de cartes communes :${NC}"
    echo -e "  ${GREEN}hf mf autopwn${NC}    # Tente de cracker une carte MIFARE Classic"
    echo -e "  ${GREEN}hf mf rdbl 0 A FFFFFFFFFFFF${NC} # Lire le bloc 0 d'une MIFARE avec la clé par défaut"
    echo -e "  ${GREEN}lf em 410x read${NC}   # Lire une carte EM4100 (badge d'immeuble commun)"
    echo ""
    echo -e "${BOLD}Quitter le client pm3 :${NC}"
    echo -e "  ${GREEN}quit${NC}"
    echo ""
    
    read -r -p "Lancer le client interactif Proxmark3 maintenant? (Y/n): " launch_confirm
    if [[ ! "$launch_confirm" =~ ^[Nn]$ ]]; then
        echo -e "${YELLOW}Lancement du client pm3... Tapez 'quit' pour revenir à FOX.${NC}"
        sleep 2
        # Le client pm3 nécessite souvent des droits élevés pour accéder au port USB
        sudo pm3
    fi
    
    read -r -p "Appuyez sur Entrée pour revenir au menu..."
}