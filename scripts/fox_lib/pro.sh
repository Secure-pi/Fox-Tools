#!/bin/bash

# ========== PRO MODE INSTALLERS ==========
install_bettercap() {
    echo -e "${BLUE}Installation de Bettercap...${NC}"
    sudo apt update && sudo apt install -y bettercap
}

install_kismet() {
    echo -e "${BLUE}Installation de Kismet...${NC}"
    sudo apt update && sudo apt install -y kismet
}

install_urh() {
    echo -e "${BLUE}Installation de Universal Radio Hacker (URH)...${NC}"
    pip3 install --break-system-packages urh
}

# ========== PRO MODE MENU ==========
pro_menu() {
    while true; do
        clear
        show_fox
        echo -e "${RED}${BOLD}Welcome to the Construct."
        echo -e "${GREEN}${BOLD}🦊 === FOX - PRO MODE === 🦊${NC}"
        echo "=================================================="
        echo -e "${YELLOW}Outils avancés et expérimentaux.${NC}"
        echo ""
        echo -e "${GREEN}[1]${NC}  🎭 Bettercap (Man-in-the-Middle Framework)"
        echo -e "${GREEN}[2]${NC}  📡 Kismet (Wireless Sniffing & IDS)"
        echo -e "${GREEN}[3]${NC}  📻 Universal Radio Hacker (URH)"
        echo ""
        echo -e "${RED}[0]${NC}  ⬅️  Quitter le Mode Pro"
        echo ""
        echo -n -e "${YELLOW}Votre choix: ${NC}"
        read -r pro_choice

        case $pro_choice in
            1) # Bettercap
               if command -v bettercap &>/dev/null; then
                   echo -e "${YELLOW}Lancement de Bettercap...${NC}"
                   echo -e "${CYAN}Bettercap est un outil interactif qui va tourner en continu.${NC}"
                   echo -e "${RED}Appuyez sur Ctrl+C pour arrêter Bettercap et revenir au menu FOX.${NC}"
                   sleep 4
                   trap '' SIGINT
                   sudo bettercap
                   trap cleanup_exit SIGINT SIGTERM
               else
                   echo -e "${YELLOW}Bettercap n'est pas installé.${NC}"
                   read -r -p "Voulez-vous l'installer maintenant? (y/N): " install_confirm
                   if [[ "$install_confirm" =~ ^[Yy]$ ]]; then
                       install_bettercap
                   fi
               fi
               ;;
            2) # Kismet
               if command -v kismet &>/dev/null; then
                   echo -e "${YELLOW}Lancement de Kismet...${NC}"
                   echo -e "${CYAN}Kismet est un serveur avec une interface web (http://localhost:2501).${NC}"
                   echo -e "${RED}Appuyez sur Ctrl+C pour arrêter Kismet et revenir au menu FOX.${NC}"
                   sleep 4
                   trap '' SIGINT
                   sudo kismet
                   trap cleanup_exit SIGINT SIGTERM
               else
                   echo -e "${YELLOW}Kismet n'est pas installé.${NC}"
                   read -r -p "Voulez-vous l'installer maintenant? (y/N): " install_confirm
                   if [[ "$install_confirm" =~ ^[Yy]$ ]]; then
                       install_kismet
                   fi
               fi
               ;;
            3) # URH
               if command -v urh &>/dev/null; then
                   urh
               else
                   echo -e "${YELLOW}URH n'est pas installé.${NC}"
                   read -r -p "Voulez-vous l'installer maintenant? (y/N): " install_confirm
                   if [[ "$install_confirm" =~ ^[Yy]$ ]]; then
                       install_urh
                   fi
               fi
               ;;
            0) return ;;
            *) echo -e "${RED}❌ Option invalide${NC}"; sleep 1; ;;
        esac
    done
}