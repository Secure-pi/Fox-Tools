#!/bin/bash

# Bibliothèque pour toutes les fonctions liées au scan réseau et à l'analyse.

# --- FONCTIONS DE MENU ---

network_scanning_menu() {
    while true; do
        clear
        show_fox
        echo -e "${BLUE}${BOLD}📡 NETWORK SCANNING & ANALYSIS 📡${NC}"
        echo "=================================================="
        echo -e "${GREEN}[1]${NC}  🎯 Découverte d'Hôtes (Ping Sweep)"
        echo -e "${GREEN}[2]${NC}  🔍 Scan de Ports Avancé (Nmap)"
        echo -e "${GREEN}[3]${NC}  🕵️  Détection de Services & OS"
        echo -e "${GREEN}[4]${NC}  🌐 Cartographie de Topologie Réseau"
        echo -e "${GREEN}[5]${NC}  📊 Scan de Vulnérabilités (Nmap Scripts)"
        echo -e "${GREEN}[6]${NC}  🔎 Énumération SMB/NetBIOS"
        echo -e "${GREEN}[7]${NC}  📁 Énumération SNMP"
        echo -e "${GREEN}[8]${NC}  🚀 Masscan (Scan Ultra-Rapide)"
        echo -e "${GREEN}[9]${NC}  🛡️  Détection de Pare-feu & Évasion"
        echo -e "${GREEN}[10]${NC} 🤖 Legion (Scan Automatisé GUI)"
        echo -e "${GREEN}[11]${NC} 📈 Analyse de Trafic Réseau (tshark)"
        echo ""
        echo -e "${RED}[0]${NC}  ⬅️  Retour au menu principal"
        echo ""
        echo -n -e "${YELLOW}🦊 Votre choix: ${NC}"
        
        local choice
        read -r choice
        
        case "$choice" in
            1) host_discovery ;;
            2) advanced_port_scan ;;
            3) service_detection ;;
            4) network_topology ;;
            5) vulnerability_scanning ;;
            6) smb_enumeration ;;
            7) snmp_enumeration ;;
            8) masscan_scan ;;
            9) firewall_detection ;;
            10) run_legion ;;
            11) traffic_analysis ;;
            0) return ;;
            *) echo -e "${RED}❌ Option invalide !${NC}"; sleep 1;;
        esac
    done
}

# --- FONCTIONS DE SCAN ---

host_discovery() {
    clear; show_fox
    echo -e "${BLUE}${BOLD}🎯 HOST DISCOVERY (Ping Sweep)${NC}"
    local suggested_subnet
    suggested_subnet=$(hostname -I | awk '{print $1}' | sed 's/\[0-9]*$/\.0\/24/')
    echo -n -e "${YELLOW}Entrez le sous-réseau à scanner [défaut: ${suggested_subnet}]: ${NC}"
    local subnet; read -r subnet; subnet=${subnet:-$suggested_subnet}
    if ! check_tool "nmap"; then echo -e "${RED}❌ Nmap non installé!${NC}"; sleep 2; return; fi
    mkdir -p "$PIHACK_OUTPUT_PATH/network"
    local output_file
    output_file="$PIHACK_OUTPUT_PATH/network/host_discovery_$(date +%Y%m%d_%H%M%S).txt"
    echo -e "\n${CYAN}🔍 Lancement du Ping Sweep sur ${subnet}...${NC}"
    sudo nmap -sn "$subnet" | tee "$output_file"
    echo -e "\n${GREEN}✅ Scan terminé.${NC}"; press_enter_to_continue
}

advanced_port_scan() {
    local target; select_target_from_loot "SCAN DE PORTS AVANCÉ"; if [[ -z "$selected_target" ]]; then return; fi; target="$selected_target"
    clear; show_fox
    echo -e "${BLUE}${BOLD}🔍 ADVANCED PORT SCANNING (Nmap) sur ${target}${NC}"
    echo -e "${CYAN}Choisissez le type de scan:${NC}"
    echo "[1] Rapide (Top 100)" "[2] Complet TCP (65535 ports)" "[3] Courants (Top 1000)" "[4] UDP (Top 100)"; read -r scan_choice
    local nmap_options
    case "$scan_choice" in
        1) nmap_options="-F" ;;
        2) nmap_options="-p-" ;;
        3) nmap_options="--top-ports 1000" ;;
        4) nmap_options="-sU --top-ports 100" ;;
        *) echo -e "${RED}❌ Option invalide !${NC}"; sleep 2; return ;; 
    esac
    local output_file
    output_file="$PIHACK_OUTPUT_PATH/network/nmap_scan_${target}_$(date +%Y%m%d_%H%M%S).txt"
    echo -e "\n${CYAN}🔍 Lancement de Nmap sur ${target} avec options: ${nmap_options}...${NC}"
    sudo nmap "${nmap_options}" "${target}" | tee "$output_file"
    echo -e "\n${GREEN}✅ Scan terminé.${NC}"; press_enter_to_continue
}

service_detection() {
    local target; select_target_from_loot "DÉTECTION DE SERVICE & OS"; if [[ -z "$selected_target" ]]; then return; fi; target="$selected_target"
    clear; show_fox
    echo -e "${BLUE}${BOLD}🕵️ SERVICE & OS DETECTION (Nmap) sur ${target}${NC}"
    local ports; read -r -p "Ports à scanner (ex: 22,80,443 ou vide): " ports
    local nmap_cmd_array=(sudo nmap -sV -O); if [[ -n "$ports" ]]; then nmap_cmd_array+=(-p "$ports"); fi; nmap_cmd_array+=("$target")
    local output_file
    output_file="$PIHACK_OUTPUT_PATH/network/nmap_service_os_${target}_$(date +%Y%m%d_%H%M%S).txt"
    echo -e "\n${CYAN}🔍 Lancement de la détection...${NC}"
    local nmap_output
    nmap_output=$("${nmap_cmd_array[@]}"); echo "$nmap_output" | tee "$output_file"
    while read -r line; do
        if echo "$line" | grep -q "open"; then
            add_to_loot "SERVICE" "Port $(echo "$line" | cut -d'/' -f1) ($(echo "$line" | awk '{print $3}')) ouvert sur ${target}" "nmap"
        fi
    done <<< "$(echo "$nmap_output" | grep "open" || true)"
    echo -e "\n${GREEN}✅ Scan terminé.${NC}"; press_enter_to_continue
}

network_topology() {
    local target; select_target_from_loot "CARTOGRAPHIE TOPOLOGIE RÉSEAU"; if [[ -z "$selected_target" ]]; then return; fi; target="$selected_target"
    clear; show_fox
    echo -e "${BLUE}${BOLD}🌐 NETWORK TOPOLOGY MAPPING (Nmap) sur ${target}${NC}"
    local output_file
    output_file="$PIHACK_OUTPUT_PATH/network/nmap_topology_${target}_$(date +%Y%m%d_%H%M%S).txt"
    echo -e "\n${CYAN}🔍 Lancement du traceroute...${NC}"
    sudo nmap --traceroute "$target" | tee "$output_file"
    echo -e "\n${GREEN}✅ Scan terminé.${NC}"; press_enter_to_continue
}

vulnerability_scanning() {
    local target; select_target_from_loot "SCAN DE VULNÉRABILITÉS (NSE)"; if [[ -z "$selected_target" ]]; then return; fi; target="$selected_target"
    clear; show_fox
    echo -e "${BLUE}${BOLD}📊 VULNERABILITY SCANNING (Nmap NSE) sur ${target}${NC}"
    local output_file
    output_file="$PIHACK_OUTPUT_PATH/network/nmap_vuln_scan_${target}_$(date +%Y%m%d_%H%M%S).txt"
    echo -e "\n${CYAN}🔍 Lancement du scan de vulnérabilités...${NC}"
    sudo nmap -sV --script vuln "$target" | tee "$output_file"
    echo -e "\n${GREEN}✅ Scan terminé.${NC}"; press_enter_to_continue
}

smb_enumeration() {
    local target; select_target_from_loot "ÉNUMÉRATION SMB/NETBIOS"; if [[ -z "$selected_target" ]]; then return; fi; target="$selected_target"
    clear; show_fox
    echo -e "${BLUE}${BOLD}🔎 SMB/NETBIOS ENUMERATION sur ${target}${NC}"
    echo "[1] Nmap" "[2] Enum4linux"; read -r tool_choice
    local output_file
    case "$tool_choice" in
        1) output_file="$PIHACK_OUTPUT_PATH/network/nmap_smb_${target}_$(date +%Y%m%d_%H%M%S).txt"; sudo nmap -p 139,445 --script smb-enum-shares,smb-os-discovery "$target" | tee "$output_file" ;; 
        2) output_file="$PIHACK_OUTPUT_PATH/network/enum4linux_${target}_$(date +%Y%m%d_%H%M%S).txt"; enum4linux -a "$target" | tee "$output_file" ;; 
        *) echo -e "${RED}❌ Option invalide !${NC}"; sleep 2; return ;; 
    esac
    echo -e "\n${GREEN}✅ Énumération terminée !${NC}"; press_enter_to_continue
}

snmp_enumeration() {
    local target; select_target_from_loot "ÉNUMÉRATION SNMP"; if [[ -z "$selected_target" ]]; then return; fi; target="$selected_target"
    clear; show_fox
    echo -e "${BLUE}${BOLD}📁 SNMP ENUMERATION sur ${target}${NC}"
    echo "[1] Nmap" "[2] snmp-check"; read -r tool_choice
    local output_file
    case "$tool_choice" in
        1) output_file="$PIHACK_OUTPUT_PATH/network/nmap_snmp_${target}_$(date +%Y%m%d_%H%M%S).txt"; sudo nmap -sU -p 161 --script snmp-brute,snmp-interfaces "$target" | tee "$output_file" ;; 
        2) output_file="$PIHACK_OUTPUT_PATH/network/snmpcheck_${target}_$(date +%Y%m%d_%H%M%S).txt"; snmp-check "$target" | tee "$output_file" ;; 
        *) echo -e "${RED}❌ Option invalide !${NC}"; sleep 2; return ;; 
    esac
    echo -e "\n${GREEN}✅ Énumération terminée !${NC}"; press_enter_to_continue
}

masscan_scan() {
    clear; show_fox
    echo -e "${BLUE}${BOLD}🚀 MASSCAN - ULTRA-FAST SCANNING${NC}"
    local target; read -r -p "Plage d'IPs cible (ex: 10.0.0.0/8): " target
    if [[ -z "$target" ]]; then echo -e "${RED}❌ Plage d'IPs requise !${NC}"; sleep 2; return; fi
    local ports; read -r -p "Ports à scanner (ex: 80,443): " ports
    if [[ -z "$ports" ]]; then echo -e "${RED}❌ Ports requis !${NC}"; sleep 2; return; fi
    local rate; read -r -p "Taux de paquets/sec [défaut: 1000]: " rate; rate=${rate:-1000}
    local output_file
    output_file="$PIHACK_OUTPUT_PATH/network/masscan_$(date +%Y%m%d_%H%M%S).txt"
    echo -e "\n${CYAN}🚀 Lancement de Masscan...${NC}"
    sudo masscan "$target" -p"$ports" --rate="$rate" | tee "$output_file"
    echo -e "\n${GREEN}✅ Scan terminé.${NC}"; press_enter_to_continue
}

firewall_detection() {
    local target; select_target_from_loot "DÉTECTION DE FIREWALL"; if [[ -z "$selected_target" ]]; then return; fi; target="$selected_target"
    clear; show_fox
    echo -e "${BLUE}${BOLD}🛡️ FIREWALL DETECTION & EVASION (Nmap) sur ${target}${NC}"
    echo "[1] ACK Scan (-sA)" "[2] Window Scan (-sW)" "[3] FIN Scan (-sF)"; read -r scan_choice
    local nmap_options
    case "$scan_choice" in
        1) nmap_options="-sA" ;; 
        2) nmap_options="-sW" ;; 
        3) nmap_options="-sF" ;; 
        *) echo -e "${RED}❌ Option invalide !${NC}"; sleep 2; return ;; 
    esac
    local output_file
    output_file="$PIHACK_OUTPUT_PATH/network/nmap_firewall_${target}_$(date +%Y%m%d_%H%M%S).txt"
    echo -e "\n${CYAN}🔍 Lancement du scan de pare-feu...${NC}"
    sudo nmap $nmap_options "$target" | tee "$output_file"
    echo -e "\n${GREEN}✅ Scan terminé.${NC}"; press_enter_to_continue
}

traffic_analysis() {
    clear; show_fox
    echo -e "${BLUE}${BOLD}📈 NETWORK TRAFFIC ANALYSIS${NC}"
    if ! check_tool "tshark"; then echo -e "${RED}❌ TShark non installé! (apt install tshark)${NC}"; sleep 2; return; fi
    echo "[1] Lancer une capture" "[2] Analyser un fichier .pcap"; read -r choice
    case "$choice" in
        1) 
            tshark -D; read -r -p "Interface à capturer: " interface
            if [[ -z "$interface" ]]; then echo -e "${RED}❌ Interface requise!${NC}"; sleep 2; return; fi
            echo -e "${CYAN}🚀 Lancement de la capture... (Ctrl+C pour arrêter)${NC}"
            trap '' SIGINT; sudo tshark -i "$interface"; trap cleanup_exit SIGINT SIGTERM
            ;; 
        2) 
            read -r -p "Chemin du fichier .pcap: " pcap_file
            if [[ ! -f "$pcap_file" ]]; then echo -e "${RED}❌ Fichier non trouvé!${NC}"; sleep 2; return; fi
            echo -e "\n${YELLOW}--- Hiérarchie des protocoles ---${NC}"; tshark -r "$pcap_file" -z io,phs -q
            echo -e "\n${YELLOW}--- Conversations IP ---${NC}"; tshark -r "$pcap_file" -z conv,ip -q
            ;; 
        *) echo -e "${RED}❌ Option invalide !${NC}"; sleep 2; return ;; 
    esac
    echo -e "\n${GREEN}✅ Analyse terminée.${NC}"; press_enter_to_continue
}

# --- OUTILS SPÉCIALISÉS ---

install_legion() {
    if ! check_tool "git"; then echo -e "${RED}❌ Git n'est pas installé. Veuillez l'installer avec 'sudo apt install git'${NC}"; sleep 3; return; fi
    echo -e "${BLUE}Installation de Legion...${NC}"
    sudo apt-get update && sudo apt-get install -y python3-pip python3-pyqt5
    local legion_dir="${SCRIPT_DIR}/../tools/legion"
    if [ ! -d "$legion_dir" ]; then
        git clone https://github.com/GoVanguard/legion.git "$legion_dir"
    fi
    if [ -f "$legion_dir/requirements.txt" ]; then
        sudo pip3 install --break-system-packages -r "$legion_dir/requirements.txt"
    fi
    echo -e "${GREEN}✅ Installation de Legion terminée.${NC}"; sleep 2
}

run_legion() {
    local legion_path="${SCRIPT_DIR}/../tools/legion/legion.py"
    if [ ! -f "$legion_path" ]; then
        read -r -p "Legion n'est pas installé. Voulez-vous l'installer? (y/N): " confirm
        if [[ "$confirm" =~ ^[Yy]$ ]]; then install_legion; fi
    else
        echo -e "${YELLOW}🚀 Lancement de Legion en arrière-plan...${NC}"
        (cd "$(dirname "$legion_path")" && sudo python3 "$legion_path" &)
        sleep 2; echo -e "${GREEN}✅ Legion lancé.${NC}"; press_enter_to_continue
    fi
}

start_netcat_listener() {
    clear; show_fox
    echo -e "${BLUE}${BOLD}🎧 NETCAT LISTENER 🎧${NC}"
    local lport; read -r -p "Port d'écoute (LPORT) [défaut: 4444]: " lport; lport=${lport:-4444}
    echo -e "\n${CYAN}🚀 Démarrage du listener sur le port ${lport}...${NC}"
    trap '' SIGINT
    if command -v ncat >/dev/null 2>&1; then
        ncat -lvnp "$lport"
    else
        nc -lvnp "$lport"
    fi
    trap cleanup_exit SIGINT SIGTERM
    echo -e "\n${GREEN}✅ Listener arrêté.${NC}"; press_enter_to_continue
}