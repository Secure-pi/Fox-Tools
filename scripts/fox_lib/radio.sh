#!/bin/bash

# ========== SDR INSTALLERS ==========
install_sdr_tools() {
    echo -e "${BLUE}Installation des outils SDR (rtl-sdr)...${NC}"
    sudo apt update && sudo apt install -y rtl-sdr sox gqrx
}

# ========== GQRX LAUNCHER ==========
launch_gqrx() {
    if ! command -v gqrx &>/dev/null; then
        echo -e "${RED}GQRX n'est pas installé.${NC}"
        read -r -p "Installer gqrx, rtl-sdr et sox? (y/N): " confirm
        if [[ "$confirm" =~ ^[Yy]$ ]]; then install_sdr_tools; fi
        return
    fi
    echo -e "${YELLOW}Lancement de GQRX...${NC}"
    gqrx &
}

# ========== FM RADIO LISTENER ==========
listen_fm() {
    if ! command -v rtl_fm &>/dev/null || ! command -v play &>/dev/null; then
        echo -e "${RED}rtl-sdr ou sox ne sont pas installés.${NC}"
        read -r -p "Installer gqrx, rtl-sdr et sox? (y/N): " confirm
        if [[ "$confirm" =~ ^[Yy]$ ]]; then install_sdr_tools; fi
        return
    fi
    echo -n -e "${YELLOW}Fréquence FM à écouter [ex: 100.7]: ${NC}"
    read -r freq
    if [[ -z "$freq" ]]; then
        echo -e "${RED}Fréquence requise !${NC}"; sleep 2; return
    fi
    echo -e "${CYAN}Lancement de la radio sur ${freq}M... (Ctrl+C pour arrêter)${NC}"
    rtl_fm -f "${freq}M" -M wbfm - | play -r 32k -t raw -e s -b 16 -c 1 -V1 -
}

# ========== FREQUENCY SCANNER (CO-PILOT) ==========
find_signals() {
    if ! command -v rtl_power &>/dev/null; then
        echo -e "${RED}rtl-sdr n'est pas installé.${NC}"
        read -r -p "Installer gqrx, rtl-sdr et sox? (y/N): " confirm
        if [[ "$confirm" =~ ^[Yy]$ ]]; then install_sdr_tools; fi
        return
    fi
    
    clear
    show_fox
    echo -e "${BLUE}${BOLD}📡 SCANNER DE FRÉQUENCES ACTIVES 📡${NC}"
    echo "=================================================="
    echo -e "${CYAN}Que cherchez-vous ?${NC}"
    echo -e "${GREEN}[1]${NC} Stations de radio FM (88-108 MHz)"
    echo -e "${GREEN}[2]${NC} Radioamateurs (144-148 MHz)"
    echo -e "${GREEN}[3]${NC} Appareils domotiques (433-434 MHz)"
    echo -e "${GREEN}[4]${NC} Plage personnalisée"
    read -r -p "🦊 Votre choix: " choice

    local freq_range=""
    case $choice in
        1) freq_range="88M:108M:10k" ;;
        2) freq_range="144M:148M:1k" ;;
        3) freq_range="433M:434M:1k" ;;
        4) read -r -p "Entrez la plage (ex: 868M:870M:1k): " freq_range ;;
        *) echo -e "${RED}❌ Option invalide !${NC}"; sleep 2; return;;
    esac

    if [[ -z "$freq_range" ]]; then echo -e "${RED}Plage de fréquence requise!${NC}"; sleep 2; return; fi

    local output_file
    output_file="$PIHACK_OUTPUT_PATH/scans/sdr_scan_$(date +%Y%m%d_%H%M%S).csv"
    mkdir -p "$PIHACK_OUTPUT_PATH/scans"

    echo ""
    echo -e "${YELLOW}⚡ Scan en cours sur la plage $freq_range... (Ctrl+C pour arrêter)${NC}"
    echo -e "${BLUE}   Les résultats seront sauvegardés dans: $output_file${NC}"
    sleep 3

    rtl_power -f "$freq_range" -g 50 -i 10 -1 "$output_file"

    echo -e "${GREEN}✅ Scan terminé.${NC}"
    echo -e "${YELLOW}💡 Pour visualiser, utilisez un script de heatmap, ex: rtl-gopow (github.com/dhogborg/rtl-gopow)${NC}"
    read -r -p "Appuyez sur Entrée pour continuer..."
}


# ========== SDR & RADIO ANALYSIS ==========
sdr_analysis_menu() {
    while true; do
        clear
        show_fox
        echo -e "${BLUE}${BOLD}📻 SDR & RADIO ANALYSIS 📻${NC}"
        echo "=================================================="
        if [[ "$HAS_RTLSDR" == "true" ]]; then
            echo -e "${YELLOW}Menu débloqué car un RTL-SDR a été détecté!${NC}"
        elif [[ "$HAS_HACKRF" == "true" ]]; then
            echo -e "${YELLOW}Menu débloqué car un HackRF a été détecté! (Outils rtl-sdr utilisés par défaut)${NC}"
        fi
        echo ""
        echo -e "${GREEN}[1]${NC}  🖥️  Lancer GQRX (Analyseur de spectre GUI)"
        echo -e "${GREEN}[2]${NC}  🎶 Écouter la radio FM"
        echo -e "${GREEN}[3]${NC}  📊 Trouver les fréquences actives"
        echo ""
        echo -e "${RED}[0]${NC}  ⬅️  Retour"
        echo ""
        echo -n -e "${YELLOW}Votre choix: ${NC}"
        read -r choice

        case $choice in
            1) launch_gqrx ;;
            2) listen_fm ;;
            3) find_signals ;;
            0) return ;;
            *) echo -e "${RED}❌ Option invalide !${NC}"; sleep 1 ;;
        esac
    done
}