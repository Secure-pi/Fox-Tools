#!/bin/bash

# ========== BANNER ==========
show_banner() {
    clear
    echo -e "${RED}${BOLD}"
    echo '███████╗ ██████╗ ██╗  ██╗    ██╗   ██╗██████╗ '
    echo '██╔════╝██╔═══██╗╚██╗██╔╝    ██║   ██║╚════██╗'
    echo '█████╗  ██║   ██║ ╚███╔╝     ██║   ██║ █████╔╝'
    echo '██╔══╝  ██║   ██║ ██╔██╗     ╚██╗ ██╔╝██╔═══╝ '
    echo '██║     ╚██████╔╝██╔╝ ██╗     ╚████╔╝ ███████╗'
    echo '╚═╝      ╚═════╝ ╚═╝  ╚═╝      ╚═══╝  ╚══════╝'
    echo -e "${NC}${CYAN}${BOLD}"
    echo "    🦊 ULTIMATE PENTESTING TOOLKIT 🦊"
    echo -e "${NC}${YELLOW}"
    echo "           Made with ❤️ for Hackers"
    echo -e "${NC}"
    sleep 2
}

# ========== LE MAGNIFIQUE RENARD ==========
show_fox() {
    echo -e "${GREEN}"
    echo "▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒"
    echo "▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒"
    echo "▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒"
    echo "▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒"
    echo "▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒"
    echo "▒▒▒▒▒▒▒▒▒▒▒▒░░░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒"
    echo "▒▒▒▒▒▒▒▒▒▒▒▒░░░▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒"
    echo "▒▒▒▒▒▒▒▒▒▒▒▒░░░▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒"
    echo "▒▒▒▒▒▒▒▒▒▒▒▒░░░▒░░░░░░▒░▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒"
    echo "▒▒▒▒▒▒▒▒▒▒▒▒░░░▓░░░░░░░▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒"
    echo "▒▒▒▒▒▒▒▒▒▒▒░░▒░▓▒░░░░░░░░░░░░░░░░░░░░░░▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒"
    echo "▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▓▒░░░░░░░░░░░░░░░░░░░▒░▓▓░▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒"
    echo "▒▒▒▒▒▒▒▒▒▒▒░░▒░▓░▓░░░░░░░░▒░░░░░▒░▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒"
    echo "▒▒▒▒▒▒▒▒▒▒▒░░░▒▓▓░▒░░▓░▒░░░░░▒▒▒▒▒▒▒▒▓▒▒░▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒"
    echo "▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒░▒░░░░░▒▒▒▒▒▒▒▒▒▓▒░▒▒▒░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒"
    echo "▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒░░░▒▒░░▒▒▒▒▒▒▒▒▒▒▓▒░▒░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒"
    echo "▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒░░░▓▒▒▒▒▒▒▒▒▒▒▓░░░░░▒░░▒░░░░░░░░▒░▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒"
    echo "▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒░▒▒▒░▒▓▒░░▒▒▒░▒▒░░░░░░░▒▒▒▒▒▓▓▓▒▒▓▓▒▒▒▒▒▒▒▒░░▒▒▒▒"
    echo "▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▓▓▒▓▒▒▒▒▒▒▒▒▓░▒▒▒▒▒░░▒▒▒▒▒▒▒░░░░░░░░░░░▓▒▒▒▒▒▒▒▓▓▓▓▓▓░▒░░░▒▒▒"
    echo "▒▒▒▒▒▒▒▒▒▓▓▒▓▒▒▒▒▓▒▓▓▒▓▒▒▒▒▒░▒▓▓▒▒▒▒▒░▓▒░▒▒▒▒▒▒▒░░░░▒▒▓░▒░░░▒▓░▓▒▒▓▓▓▒▓▒▒▓░░░▒▒▒"
    echo "▒▒▒▒▒▒▒▒▓▒▓▓▓▒▒▒▒▒▒▒▓▓▓▒▓▒▒▒▒▒▒░▒▒▒▒▒▓▒▒▒▒░░▒▒▒▒▒▓▒▒▒▒▒░▒░▒░░▒▒▓▓░▒▓▓▓▒▓▓▒▒░▒▒▒▒"
    echo "▒▒▒▒▒▒▒▒▒▒▓▒▓▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▒▓▓▒▒▓▒▒▒▒▒"
    echo "▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▓▒▒▓▒▓▒▓▓▓▓▒▓▒▒▒▒▓▓▓▓▓▓▒▓▓▓░▓▒▒▒▒▒▓▓▓▓▓▒▒▒░░░▒▒▒▒▒▒"
    echo "▒▒▒░▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▓▒▒▒▓▒▒▒▒▒▓▓▓▒▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒░▒▓░▒▒░░▒░▒░▒▒▒▒▒▒▒"
    echo "▒▒▒▒▒▒▒▒▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▒▓▒▒░░░▒▓▒▒░░▒░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒"
}

# ========== QUICK ACCESS MENU ==========
quick_access_menu() {
    local choice
    while true;
 do
        clear
        show_fox
        echo -e "${BLUE}${BOLD}⚡ ACCÈS RAPIDE ⚡${NC}"
        echo "=================================================="
        echo -e "${CYAN}--- Reconnaissance ---${NC}"
        echo -e "${GREEN}[1]${NC}  🕵️ Scan de Services & OS (Nmap)"
        echo -e "${GREEN}[2]${NC}  📂 Scan de Répertoires Web (Gobuster)"
        echo -e "${GREEN}[3]${NC}  🕷️ Scan de Vulnérabilités Web (Nikto)"
        echo ""
        echo -e "${CYAN}--- Exploitation ---${NC}"
        echo -e "${GREEN}[4]${NC}  🐍 Générer un Reverse Shell"
        echo -e "${GREEN}[5]${NC}  🎧 Démarrer un Listener Netcat"
        echo ""
        echo -e "${RED}[0]${NC}  ⬅️  Retour au menu principal"
        echo ""
        echo -n -e "${YELLOW}🦊 Votre choix: ${NC}"
        
        read -r choice
        
        case "$choice" in
            1) service_detection ; press_enter_to_continue ;;
            2) directory_discovery ; press_enter_to_continue ;;
            3) web_vulnerability_scan ; press_enter_to_continue ;;
            4) payload_generator_menu ;;
            5) start_netcat_listener ;;
            0) return ;;
            *) 
                echo -e "${RED}❌ Option invalide !${NC}"
                sleep 1
                ;;
        esac
    done
}

# ========== MENU PRINCIPAL ULTIME ==========
main_menu() {
    local choice
    while true;
 do
        clear
        show_fox
        # Affichage de la cible active
        if [ -n "$CURRENT_TARGET" ]; then
            echo -e "${YELLOW}🎯 Cible: ${BOLD}$TARGET_NAME${NC} ${YELLOW}(IP: ${BOLD}$TARGET_IP${YELLOW})${NC}"
            echo -e "${YELLOW}======================================================${NC}"
        fi

        # --- MOTEUR DE SUGGESTION (COPILOTE) ---
        show_contextual_suggestions
        echo -e "${GREEN}${BOLD}🦊 === Fox V2.0 === 🦊${NC}"
        echo ""
        echo -e "${GREEN}[1]${NC} 🌐 Web Testing & Exploitation"
        echo -e "${GREEN}[2]${NC} 🔍 Network Reconnaissance"  
        echo -e "${GREEN}[3]${NC} 📶 Wireless Attacks"
        echo -e "${GREEN}[4]${NC} 💥 Exploitation Tools"
        echo -e "${GREEN}[5]${NC} 🔍 Forensics & Analysis"
        echo -e "${GREEN}[6]${NC} 🕵️  OSINT & Recon"
        echo -e "${GREEN}[7]${NC} 🐍 Payload Generator"
        echo -e "${GREEN}[8]${NC} 📊 Reporting"
        echo -e "${GREEN}[9]${NC} 🧹 System Maintenance"
        echo -e "${GREEN}[10]${NC} ⚙️ System & Utilities"

        # Menu contextuel pour Flipper Zero
        if [[ "$HAS_FLIPPER" == "true" ]]; then
            echo -e "${GREEN}[11]${NC} 🐬 Flipper Zero Tools"
        fi

        # Menu pour le matériel Radio/RF
        if [[ -n "$HAS_RTLSDR" || -n "$HAS_HACKRF" ]]; then
             echo -e "${GREEN}[12]${NC} 📻 Radio & RF Hardware"
        fi

        echo ""
        echo -e "${YELLOW}[A]${NC} ⚡ Accès Rapide  ${YELLOW}[L]${NC} 💰 Voir le Butin    ${YELLOW}[h]${NC} ❓ Aide"
        echo -e "${YELLOW}[v]${NC} 📋 Version       ${YELLOW}[t]${NC} 📚 Tutoriels     ${YELLOW}[d]${NC} 📄 Documentation"
        echo -e "${RED}[0]${NC} ❌ Quitter"
        echo ""
        
        read -r -p $'$\e[1;33m🦊 Votre choix: \e[0m' choice
        
        case "$choice" in
            1) web_testing_menu ;;
            2) network_scanning_menu ;;
            3) wireless_security_menu ;;
            4) exploitation_menu ;;
            5) forensics_toolkit ;; 
            6) osint_menu ;; 
            7) payload_generator_menu ;; 
            8) reporting_menu ;; 
            9) turbo_system_cleaner ;; 
            10) system_menu ;; 
            11) if [[ "$HAS_FLIPPER" == "true" ]]; then flipper_menu; else echo -e "${RED}❌ Option invalide${NC}"; sleep 1; fi ;; 
            12) if [[ -n "$HAS_RTLSDR" || -n "$HAS_HACKRF" ]]; then radio_hardware_menu; else echo -e "${RED}❌ Option invalide${NC}"; sleep 1; fi ;; 
            a|A) quick_access_menu ;; 
            l|L) view_loot ;; 
            h|H) show_help ;; 
            v|V) show_version ;; 
            t|T) tutorials_menu ;; 
            d|D) documentation_menu ;; 
            0) cleanup_exit ;; 
            *) 
                echo -e "${RED}❌ Option invalide. Tapez 'h' pour l'aide.${NC}"
                sleep 1
                ;;
        esac
    done
}

# ========== VIEW LOOT ==========
view_loot() {
    if [[ -z "$PIHACK_OUTPUT_PATH" ]]; then
        echo -e "${RED}❌ Aucun projet actif.${NC}"; sleep 2; return
    fi

    local loot_file="$PIHACK_OUTPUT_PATH/loot.csv"
    if [[ ! -f "$loot_file" ]]; then
        echo -e "${YELLOW}Aucun butin collecté pour ce projet pour le moment.${NC}"; sleep 2; return
    fi

    clear
    show_fox
    echo -e "${PURPLE}${BOLD}💰 BUTIN COLLECTÉ POUR: $TARGET_NAME 💰${NC}"
    echo "=================================================="
    
    # Utilise `column` pour formater le CSV en tableau, et `less` pour le rendre scrollable
    column -t -s ',' "$loot_file" | less

    press_enter_to_continue
}

# ========== HELPERS FOR MENU TRANSITIONS ==========
# Wrapper to properly initialize the environment before jumping to the main menu
go_to_main_menu() {
    echo -e "${BLUE}🔄 Initialisation de l'environnement principal...${NC}"
    sleep 1
    initialize_hardware_detection
    setup_target
    select_strategy
    main_menu
}

# ========== EASTER EGG MENU (PRO) ==========
easter_egg_menu() {
    while true; do
        clear
        show_fox
        echo -e "${PURPLE}${BOLD}🦊 MENU SECRET PRO 🦊${NC}"
        echo "=================================================="
        echo -e "${GREEN}[1]${NC}  📡 Kismet - Wireless Monitoring"
        echo -e "${GREEN}[2]${NC}  📻 SDR Analysis Menu"
        echo -e "${GREEN}[3]${NC}  🧠 Volatility - Memory Forensics"
        echo -e "${GREEN}[4]${NC}  🌊 Fluxion - Captive Portal Attacks"
        echo ""
        echo -e "${CYAN}[9]${NC}  ↩️  Retour au menu principal"
        echo -e "${RED}[0]${NC}  ❌ Quitter"
        echo ""
        echo -n -e "${YELLOW}Choisissez une option: ${NC}"
        
        read -r choice
        
        case $choice in
            1) run_kismet ; press_enter_to_continue ;;
            2) sdr_analysis_menu ;;
            3) run_volatility_analysis ;;
            4) run_fluxion ; press_enter_to_continue ;;
            9) go_to_main_menu ;;
            0) cleanup_exit ;;
            *) 
                echo -e "${RED}❌ Option invalide !${NC}"
                sleep 1
                ;;
        esac
    done
}

# ========== EASTER EGG CACHÉ ==========
secret_menu() {
    if [[ "$1" == "konami" ]]; then
        clear
        echo -e "${PURPLE}${BOLD}"
        echo "🎉 FÉLICITATIONS! MENU SECRET DÉBLOQUÉ! 🎉"
        echo ""
        echo "🦊 Vous avez trouvé le code Konami du renard!"
        sleep 2
        
        if command -v hollywood &> /dev/null; then
            echo "Lancement de la simulation de hacking..."
            sleep 1
            hollywood
        else
            # Fallback to the old animation
            clear
            echo -e "${GREEN}Booting up FOX-HACK terminal...${NC}"
            sleep 1
            echo -e "${GREEN}Connecting to target server...${NC}"
            sleep 1
            echo -n "["
            for i in {1..50}; do
                echo -n "#"
                sleep 0.05
            done
            echo -n "]"
            echo -e "
${GREEN}Connection established.${NC}"
            sleep 1
            echo -e "${GREEN}Bypassing firewall...${NC}"
            sleep 1
            echo -e "${GREEN}Injecting payload...${NC}"
            sleep 2
            echo -e "${RED}ACCESS DENIED.${NC}"
            sleep 1
            echo -e "${YELLOW}Retrying with different exploit...${NC}"
            sleep 2
            echo -e "${GREEN}ACCESS GRANTED.${NC}"
            sleep 1
            echo -e "${CYAN}Downloading secret data...${NC}"
            sleep 1
            echo -e "${CYAN}data.zip [1.2 GB]${NC}"
            sleep 2
            echo -e "${GREEN}Cleaning up tracks...${NC}"
            sleep 1
            echo -e "${GREEN}Disconnecting...${NC}"
            sleep 2
            clear
            echo -e "${CYAN}🏆 Achievement Unlocked: Secret Hacker!${NC}"
            sleep 3
        fi

        # Lancer le menu secret
        easter_egg_menu
    fi
}

# ========== HELPER POUR LA PAUSE ==========
press_enter_to_continue() {
    read -r -p $'
Appuyez sur Entrée pour continuer...'
}

# ========== BANNIÈRE DE SORTIE ÉLÉGANTE ==========
goodbye_banner() {
    echo -e "${CYAN}${BOLD}"
    cat << "EOF"
    ╔══════════════════════════════════════╗
    ║                                      ║
    ║           🦊 Fox V2.0 🦊             ║
    ║                                      ║
    ║        Goodbye, young fox!           ║
    ║                                      ║
    ║      🔒 Hack Responsibly! 🔒         ║
    ║                                      ║
    ╚══════════════════════════════════════╝
EOF
    echo -e "${NC}"
    echo -e "${GREEN}✨ Session ended at $(date)${NC}"
    echo -e "${YELLOW}📁 Results saved in: $PIHACK_OUTPUT_PATH${NC}"
}

# ========== SUGGESTION ENGINE (COPILOTE) ==========
# Affiche des suggestions d'actions basées sur les services découverts pour la cible actuelle.
show_contextual_suggestions() {
    local loot_file="$PIHACK_OUTPUT_PATH/loot.csv"
    # Quitte si le fichier de butin n'existe pas ou si l'IP cible n'est pas définie.
    if [[ ! -f "$loot_file" || -z "$TARGET_IP" || "$TARGET_IP" == "N/A" ]]; then
        return
    fi

    # Utilise un tableau associatif pour stocker les services uniques et éviter les doublons.
    declare -A unique_services
    
    # Lit le fichier CSV ligne par ligne pour extraire les services.
    # Format attendu: "Timestamp","Type","Description","Source"
    # Ex Description: Port 21/tcp (ftp) ouvert sur 192.168.1.25
    while IFS=, read -r _ type description _;
 do
        # On ne s'intéresse qu'aux entrées de type "SERVICE" pour l'IP cible actuelle.
        if [[ "$type" == '"SERVICE"' && "$description" == *"$TARGET_IP"* ]]; then
            # Extrait le nom du service (ex: ftp, ssh, http) en prenant le mot dans les parenthèses.
            local service
            service=$(echo "$description" | grep -oP '\(\K[^)]+')
            if [[ -n "$service" ]]; then
                unique_services["$service"]=$((unique_services["$service"] + 1))
            fi
        fi
    done < "$loot_file"

    # Quitte si aucun service n'a été trouvé.
    if [ ${#unique_services[@]} -eq 0 ]; then
        return
    fi

    echo -e "${PURPLE}${BOLD}💡 Suggestions du copilote pour $TARGET_IP:${NC}"
    
    # Boucle sur les services uniques trouvés et affiche une suggestion pour chacun.
    for service in "${!unique_services[@]}"; do
        case "$service" in
            "http"|"https")
                echo -e "${PURPLE}   - [Web] Service ${NC}$service${PURPLE} trouvé. Lancer un scan de répertoires (Gobuster) ou de vulnérabilités (Nikto).${NC}"
                ;;
            "ftp")
                echo -e "${PURPLE}   - [Exploitation] Service ${NC}$service${PURPLE} trouvé. Tenter un brute-force avec Hydra ou vérifier les accès anonymes.${NC}"
                ;;
            "ssh")
                echo -e "${PURPLE}   - [Exploitation] Service ${NC}$service${PURPLE} trouvé. Tenter un brute-force de mots de passe avec Hydra.${NC}"
                ;;
            "smb"|"microsoft-ds")
                echo -e "${PURPLE}   - [Réseau] Partage ${NC}$service${PURPLE} trouvé. Utiliser Enum4linux pour énumérer les partages et utilisateurs.${NC}"
                ;;
        esac
    done
    echo -e "${YELLOW}======================================================${NC}"
}