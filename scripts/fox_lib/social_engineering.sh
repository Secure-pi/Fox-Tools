#!/bin/bash

social_engineering_menu() {
    while true; do
        clear
        show_fox
        echo -e "${BLUE}${BOLD}🎭 SOCIAL ENGINEERING TOOLS 🎭${NC}"
        echo "=================================================="
        echo -e "${GREEN}[1]${NC}  🎣 Social-Engineer Toolkit (SET)"
        echo -e "${GREEN}[2]${NC}  🐟 SocialFish"
        echo ""
        echo -e "${RED}[0]${NC}  ⬅️  Retour"
        echo ""
        echo -n -e "${YELLOW}Choisissez une option: ${NC}"

        read -r choice

        case $choice in
            1) run_setoolkit ;;
            2) run_socialfish ;;
            0) return ;;
            *) 
                echo -e "${RED}❌ Option invalide !${NC}"
                sleep 1
                ;;
        esac
    done
}

run_setoolkit() {
    if ! command -v setoolkit &> /dev/null; then
        echo -e "${RED}❌ Social-Engineer Toolkit (setoolkit) n'est pas installé ou pas dans le PATH.${NC}"
        sleep 2
        return
    fi
    clear
    echo -e "${CYAN}🚀 Lancement de Social-Engineer Toolkit...${NC}"
    sudo setoolkit
    read -r -p $'
Appuyez sur Entrée pour continuer...'
}

run_socialfish() {
    # Note: Le chemin est une supposition basée sur la structure des autres outils.
    local socialfish_path="$SCRIPT_DIR/tools/socialfish/SocialFish.py"
    if [[ ! -f "$socialfish_path" ]]; then
        echo -e "${RED}❌ SocialFish non trouvé à l'emplacement attendu!${NC}"
        echo -e "${YELLOW}💡 Assurez-vous qu'il est dans scripts/tools/socialfish${NC}"
        sleep 3
        return
    fi
    clear
    echo -e "${CYAN}🚀 Lancement de SocialFish...${NC}"
    echo -e "${YELLOW}SocialFish nécessite une interaction manuelle pour le setup.${NC}"
    echo -e "
Ouvrez un nouveau terminal et lancez la commande suivante pour le configurer :"
    echo -e "${GREEN}cd $(dirname "$socialfish_path") && sudo python3 SocialFish.py <user> <password>${NC}"
    
    read -r -p $'$
Appuyez sur Entrée pour continuer...'
}
