#!/bin/bash

osint_menu() {
    while true; do
        clear
        show_fox
        echo -e "${BLUE}${BOLD}🕵️ OSINT & RECONNAISSANCE 🕵️${NC}"
        echo "=================================================="
        echo -e "${GREEN}[1]${NC}  🌍 theHarvester (Email/Domain Recon)"
        echo -e "${GREEN}[2]${NC}  👤 Sherlock (Username Search)"
        echo -e "${GREEN}[3]${NC}  📊 Maltego (Visual Link Analysis)"
        echo -e "${GREEN}[4]${NC}  ⚙️  Recon-ng (Web Recon Framework)"
        echo -e "${GREEN}[5]${NC}  🕷️ SpiderFoot (Automated OSINT)"
        echo -e "${GREEN}[6]${NC}  🎭 Social Engineering Tools"
        echo ""
        echo -e "${RED}[0]${NC}  ⬅️  Retour au menu principal"
        echo ""
        echo -n -e "${YELLOW}Choisissez une option: ${NC}"
        
        read -r choice
        
        case $choice in
            1) run_theharvester ;;
            2) run_sherlock ;;
            3) run_maltego ;;
            4) run_reconng ;;
            5) run_spiderfoot ;;
            6) social_engineering_menu ;;
            0) return ;;
            *) 
                echo -e "${RED}❌ Option invalide !${NC}"
                sleep 1
                ;;
        esac
    done
}

run_theharvester() {
    local suggested_domain="$TARGET_NAME"
    
    clear
    show_fox
    echo -e "${BLUE}${BOLD}🌍 THEHARVESTER - Email & Domain Reconnaissance${NC}"
    echo "=================================================="
    
    echo -n -e "${YELLOW}🎯 Domaine cible [défaut: $suggested_domain]: ${NC}"
    read -r domain
    
    if [[ -z "$domain" && -n "$suggested_domain" ]]; then
        domain="$suggested_domain"
    elif [[ -z "$domain" ]]; then
        echo -e "${RED}❌ Domaine requis !${NC}"
        sleep 2
        return
    fi

    if ! command -v theHarvester &> /dev/null; then
        echo -e "${RED}❌ theHarvester n'est pas installé!${NC}"
        sleep 2
        return
    fi

    mkdir -p "$PIHACK_OUTPUT_PATH/osint"
    local timestamp
    timestamp=$(date +%Y%m%d_%H%M%S)
    local output_file_base="$PIHACK_OUTPUT_PATH/osint/theHarvester_${domain}_${timestamp}"

    local sources="google,bing,linkedin"

    echo ""
    echo -e "${CYAN}🔍 Lancement de theHarvester sur '$domain' avec les sources: $sources...${NC}"
    echo -e "${YELLOW}Cette opération peut prendre un certain temps.${NC}"

    theHarvester -d "$domain" -b "$sources" -f "$output_file_base"

    echo ""
    echo -e "${GREEN}✅ Recherche terminée !${NC}"
    echo -e "${BLUE}📁 Rapports HTML et XML sauvegardés dans: ${output_file_base}.*${NC}"
    read -r -p $'
Appuyez sur Entrée pour continuer...'
}

run_sherlock() {
    local suggested_username="$TARGET_NAME"

    clear
    show_fox
    echo -e "${BLUE}${BOLD}👤 SHERLOCK - Username Search${NC}"
    echo "=================================================="
    
    echo -n -e "${YELLOW}👤 Nom d'utilisateur à rechercher [défaut: $suggested_username]: ${NC}"
    read -r username
    
    if [[ -z "$username" && -n "$suggested_username" ]]; then
        username="$suggested_username"
    elif [[ -z "$username" ]]; then
        echo -e "${RED}❌ Nom d'utilisateur requis !${NC}"
        sleep 2
        return
    fi

    local sherlock_path="$SCRIPT_DIR/../tools/sherlock/sherlock_project/sherlock.py"
    if ! [[ -f "$sherlock_path" ]]; then
        echo -e "${RED}❌ Sherlock non trouvé à l'emplacement attendu!${NC}"
        echo -e "${YELLOW}💡 Assurez-vous qu'il est cloné dans scripts/tools/sherlock${NC}"
        sleep 3
        return
    fi

    mkdir -p "$PIHACK_OUTPUT_PATH/osint"
    local timestamp
    timestamp=$(date +%Y%m%d_%H%M%S)
    local output_file="$PIHACK_OUTPUT_PATH/osint/sherlock_${username}_${timestamp}.txt"

    echo ""
    echo -e "${CYAN}🔍 Recherche de '$username' avec Sherlock...${NC}"
    echo -e "${YELLOW}Les résultats seront sauvegardés dans $output_file${NC}"

    python3 "$sherlock_path" "$username" --output "$output_file"

    echo ""
    echo -e "${GREEN}✅ Recherche terminée !${NC}"
    echo -e "${BLUE}📁 Rapport sauvegardé: $output_file${NC}"
    
    if [[ -f "$output_file" ]]; then
        cat "$output_file"
    fi

    read -r -p $'
Appuyez sur Entrée pour continuer...'
}

run_maltego() {
    if ! command -v maltego &> /dev/null; then
        echo -e "${RED}❌ Maltego n'est pas installé ou n'est pas dans le PATH.${NC}"
        read -r -p "Appuyez sur Entrée pour continuer..."
        return
    fi
    clear
    show_fox
    echo -e "${BLUE}${BOLD}📊 MALTEGO${NC}"
    echo "=================================================="
    echo -e "${CYAN}🚀 Lancement de Maltego...${NC}"
    maltego &
    read -r -p "Appuyez sur Entrée pour continuer..."
}

run_reconng() {
    if ! command -v recon-ng &> /dev/null; then
        echo -e "${RED}❌ Recon-ng n'est pas installé ou n'est pas dans le PATH.${NC}"
        read -r -p "Appuyez sur Entrée pour continuer..."
        return
    fi
    clear
    show_fox
    echo -e "${BLUE}${BOLD}⚙️ RECON-NG${NC}"
    echo "=================================================="
    echo -e "${CYAN}🚀 Lancement de Recon-ng...${NC}"
    recon-ng
    read -r -p "Appuyez sur Entrée pour continuer..."
}

run_spiderfoot() {
    if ! command -v spiderfoot &> /dev/null; then
        echo -e "${RED}❌ SpiderFoot n'est pas installé ou n'est pas dans le PATH.${NC}"
        read -r -p "Appuyez sur Entrée pour continuer..."
        return
    fi
    clear
    show_fox
    echo -e "${BLUE}${BOLD}🕷️ SPIDERFOOT${NC}"
    echo "=================================================="
    echo -e "${CYAN}🚀 Lancement de SpiderFoot...${NC}"
    spiderfoot
    read -r -p "Appuyez sur Entrée pour continuer..."
}

# ... (le reste du fichier est un guide et n'a pas besoin de modifications) ...