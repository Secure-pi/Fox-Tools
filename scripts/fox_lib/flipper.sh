#!/bin/bash

# ========== FLIPPER ZERO TOOLS ==========
# Helper function to check for flipper CLI
check_flipper_cli() {
    if ! command -v flipper &>/dev/null; then
        echo -e "${RED}L'outil CLI 'flipper' n'est pas détecté.${NC}"
        echo -e "${CYAN}Veuillez vous assurer que le Flipper Zero CLI est installé et dans votre PATH.${NC}"
        echo -e "${YELLOW}Instructions: https://docs.flipperzero.one/cli/getting-started${NC}"
        read -r -p "Appuyez sur Entrée pour continuer..."
        return 1
    fi
    return 0
}

# ========== FLIPPER RPC START ==========
start_flipper_rpc() {
    if ! check_flipper_cli; then return; fi
    echo -e "${YELLOW}Démarrage du pont RPC du Flipper Zero en arrière-plan...${NC}"
    echo -e "${CYAN}Assurez-vous que votre Flipper est connecté et en mode 'USB to PC'.${NC}"
    flipper rpc start &
    local rpc_pid=$!
    echo -e "${GREEN}✅ Pont RPC démarré (PID: $rpc_pid).${NC}"
    echo -e "${YELLOW}Vous pouvez maintenant lancer d'autres commandes 'flipper' dans ce terminal.${NC}"
    read -r -p "Appuyez sur Entrée pour continuer..."
}

# ========== FLIPPER NFC READ ==========
read_flipper_nfc() {
    if ! check_flipper_cli; then return; fi
    echo -e "${YELLOW}Lecture d'un tag NFC avec Flipper Zero...${NC}"
    echo -e "${CYAN}Placez le Flipper près du tag NFC.${NC}"
    flipper nfc read
    read -r -p "Appuyez sur Entrée pour continuer..."
}

# ========== FLIPPER RFID LF READ ==========
read_flipper_rfid_lf() {
    if ! check_flipper_cli; then return; fi
    echo -e "${YELLOW}Lecture d'un tag RFID Basse Fréquence (LF) avec Flipper Zero...${NC}"
    echo -e "${CYAN}Placez le Flipper près du tag RFID LF.${NC}"
    flipper rfid lf read
    read -r -p "Appuyez sur Entrée pour continuer..."
}

# ========== FLIPPER SUB-GHZ LISTEN ==========
listen_flipper_subghz() {
    if ! check_flipper_cli; then return; fi
    echo -n -e "${YELLOW}Fréquence à écouter (ex: 433.92): ${NC}"
    read -r freq
    if [[ -z "$freq" ]]; then
        echo -e "${RED}Fréquence requise !${NC}"; sleep 2; return
    fi
    echo -n -e "${YELLOW}Durée d'écoute en secondes (ex: 60): ${NC}"
    read -r duration
    if [[ -z "$duration" ]]; then
        duration=60
    fi
    echo -e "${CYAN}Écoute Sub-GHz sur ${freq} MHz pendant ${duration} secondes...${NC}"
    flipper subghz rx "$freq" "$duration"
    read -r -p "Appuyez sur Entrée pour continuer..."
}

# ========== FLIPPER ZERO TOOLS MENU ==========
flipper_menu() {
    while true; do
        clear
        show_fox
        echo -e "${BLUE}${BOLD}🐬 FLIPPER ZERO TOOLS 🐬${NC}"
        echo "===================================================="
        echo -e "${YELLOW}Menu débloqué car un Flipper Zero a été détecté!${NC}"
        echo ""

        # Check for qFlipper GUI
        if ! command -v qflipper &>/dev/null; then
            echo -e "${RED}L'application qFlipper n'est pas détectée dans votre PATH.${NC}"
            echo -e "${CYAN}Pour une expérience complète, il est recommandé de l'installer.${NC}"
            echo -e "${YELLOW}Instructions: https://flipperzero.one/update${NC}"
            echo ""
        fi

        echo -e "${GREEN}[1]${NC}  🖥️  Lancer qFlipper (GUI)"
        echo -e "${GREEN}[2]${NC}  🔌 Démarrer le pont RPC (pour CLI)"
        echo -e "${GREEN}[3]${NC}  💳 Lire un tag NFC"
        echo -e "${GREEN}[4]${NC}  🔑 Lire un tag RFID Basse Fréquence"
        echo -e "${GREEN}[5]${NC}  📻 Écouter Sub-GHz"
        echo ""
        echo -e "${RED}[0]${NC}  ⬅️  Retour"
        echo ""
        echo -n -e "${YELLOW}Votre choix: ${NC}"
        read -r choice

        case $choice in
            1) if command -v qflipper &>/dev/null; then echo -e "${YELLOW}Lancement de qFlipper en arrière-plan...${NC}"; qflipper & sleep 2; else echo -e "${RED}qFlipper non trouvé.${NC}"; sleep 2; fi ;;
            2) start_flipper_rpc ;;
            3) read_flipper_nfc ;;
            4) read_flipper_rfid_lf ;;
            5) listen_flipper_subghz ;;
            0) return ;;
            *) echo -e "${RED}❌ Option invalide !${NC}"; sleep 1 ;;
        esac
    done
}