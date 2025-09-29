#!/bin/bash

# ========== BLUETOOTH SCANNER ==========
run_bluetooth_scan() {
    echo -e "${CYAN}🔍 Scan des appareils Bluetooth en cours... (15 secondes)${NC}"
    # hcitool est déprécié, on utilise bluetoothctl qui est plus moderne
    # On lance en fond, on attend, et on tue pour avoir une liste
    (bluetoothctl scan on > /dev/null) &
    local scan_pid=$!
    sleep 15
    kill $scan_pid
    wait $scan_pid 2>/dev/null

    echo -e "${GREEN}Appareils découverts:${NC}"
    bluetoothctl devices
    read -r -p "Appuyez sur Entrée pour continuer..."
}

# ========== BLUETOOTH PING ==========
run_l2ping() {
    # --- CO-PILOTE DE CIBLAGE BLUETOOTH ---
    select_bluetooth_target
    if [[ -z "$selected_bt_target" ]]; then return; fi
    local target_mac="$selected_bt_target"

    clear
    show_fox
    echo -e "${BLUE}${BOLD}📞 PING BLUETOOTH (l2ping) sur $target_mac${NC}"
    echo "=================================================="

    echo -e "${CYAN}Ping de $target_mac... (Ctrl+C pour arrêter)${NC}"
    sudo l2ping "$target_mac"
    read -r -p "Appuyez sur Entrée pour continuer..."
}

# ========== BLUETOOTH SERVICE DISCOVERY ==========
run_sdptool() {
    # --- CO-PILOTE DE CIBLAGE BLUETOOTH ---
    select_bluetooth_target
    if [[ -z "$selected_bt_target" ]]; then return; fi
    local target_mac="$selected_bt_target"

    clear
    show_fox
    echo -e "${BLUE}${BOLD}📋 LISTE DES SERVICES (sdptool) sur $target_mac${NC}"
    echo "=================================================="

    echo -e "${CYAN}Analyse des services de $target_mac...${NC}"
    sdptool browse "$target_mac"
    read -r -p "Appuyez sur Entrée pour continuer..."
}


# ========== BLUETOOTH ANALYSIS ==========
bluetooth_analysis_menu() {
    if ! command -v bluetoothctl &>/dev/null; then
        echo -e "${RED}Outils Bluetooth non trouvés. Essayez 'sudo apt install bluez'${NC}"
        sleep 3
        return
    fi

    while true; do
        clear
        show_fox
        echo -e "${BLUE}${BOLD}🔵 BLUETOOTH ANALYSIS 🔵${NC}"
        echo "=================================================="
        echo -e "${YELLOW}Menu débloqué car un adaptateur Bluetooth a été détecté!${NC}"
        echo ""
        echo -e "${GREEN}[1]${NC}  📡 Scanner les appareils (Scan)"
        echo -e "${GREEN}[2]${NC}  📞 Pinger un appareil (l2ping)"
        echo -e "${GREEN}[3]${NC}  📋 Lister les services d'un appareil (sdptool)"
        echo ""
        echo -e "${RED}[0]${NC}  ⬅️  Retour"
        echo ""
        echo -n -e "${YELLOW}Votre choix: ${NC}"
        read -r choice

        case $choice in
            1) run_bluetooth_scan ;;
            2) run_l2ping ;;
            3) run_sdptool ;;
            0) return ;;
            *) echo -e "${RED}❌ Option invalide !${NC}"; sleep 1 ;;
        esac
    done
}