#!/bin/bash

# Chemin vers le script helper Python pour le contrôle GPIO
# On s'assure que la variable SCRIPT_DIR est disponible (normalement sourcée par fox.sh)
GPIO_HELPER="${SCRIPT_DIR}/helpers/gpio_control.py"

#
# Vérifie la présence et le bon fonctionnement d'un dongle SDR-RTL.
#
check_sdr() {
    echo -e "${YELLOW}🔍 Vérification de la présence du SDR-RTL...${NC}"

    # Exécute lsusb une seule fois pour plus d'efficacité
    local lsusb_output
    lsusb_output=$(lsusb)

    if echo "$lsusb_output" | grep -q 'RTL2832U'; then
        echo -e "${GREEN}✅ SDR-RTL détecté !${NC}"
        
        # Un test plus approfondi pour s'assurer que les drivers fonctionnent
        if command -v rtl_test &>/dev/null; then
            # Exécute rtl_test en silence, on ne s'intéresse qu'au code de retour
            if rtl_test -t >/dev/null 2>&1; then
                echo -e "${GREEN}✅ Drivers RTL-SDR fonctionnels.${NC}"
            else
                echo -e "${RED}❌ Problème de communication avec le SDR. Vérifiez les drivers ou le branchement.${NC}"
            fi
        else
            echo -e "${YELLOW}⚠️ 'rtl_test' non trouvé. Impossible de vérifier les drivers. (Paquet 'rtl-sdr')${NC}"
        fi
        return 0 # Succès
    else
        echo -e "${RED}❌ Aucun SDR-RTL trouvé. Branchez-le en USB.${NC}"
        return 1 # Échec
    fi
}

#
# Affiche un menu pour contrôler le commutateur RF HMC435 via GPIO.
#
control_hmc435_switch() {
    while true; do
        clear
        show_fox # Affiche le logo du renard
        echo -e "${BLUE}${BOLD}📡 Contrôle du Commutateur RF (HMC435) 📡${NC}"
        echo "=================================================="
        echo -e "${GREEN}[A]${NC}  Activer la sortie A"
        echo -e "${GREEN}[B]${NC}  Activer la sortie B"
        echo -e "${YELLOW}[O]${NC}  Éteindre les deux sorties (OFF)"
        echo ""
        echo -e "${RED}[0]${NC}  ⬅️  Retour"
        echo ""
        echo -n -e "${YELLOW}Choisissez une option: ${NC}"
        
        local choice
        read -r choice
        
        # Met en majuscule pour simplifier le case
        choice=$(echo "$choice" | tr 'a-z' 'A-Z')

        case "$choice" in
            A|B)
                echo -e "${CYAN}Exécution du contrôle GPIO pour le canal ${choice}...${NC}"
                python3 "$GPIO_HELPER" "$choice"
                sleep 2
                ;;
            O)
                echo -e "${CYAN}Exécution du contrôle GPIO pour éteindre...${NC}"
                python3 "$GPIO_HELPER" "OFF"
                sleep 2
                ;;
            0)
                return
                ;;
            *)
                echo -e "${RED}❌ Option invalide !${NC}"
                sleep 1
                ;;
        esac
    done
}

#
# Affiche le menu principal pour le matériel radio et RF.
#
radio_hardware_menu() {
    while true; do
        clear
        show_fox
        echo -e "${BLUE}${BOLD}📻 Menu Matériel Radio & RF 📻${NC}"
        echo "=================================================="
        echo -e "${GREEN}[1]${NC}  📡 Contrôler le commutateur RF (HMC435)"
        echo -e "${GREEN}[2]${NC}  🔎 Vérifier la connexion du SDR-RTL"
        echo -e "${GREEN}[3]${NC}  📊 Lire la puissance RF (AD8362) - ${RED}NON IMPLÉMENTÉ${NC}"
        echo ""
        echo -e "${RED}[0]${NC}  ⬅️  Retour au menu principal"
        echo ""
        echo -n -e "${YELLOW}Choisissez une option: ${NC}"
        
        local choice
        read -r choice
        
        case "$choice" in
            1)
                control_hmc435_switch
                ;; 
            2)
                check_sdr
                read -r -p $'
Appuyez sur Entrée pour continuer...'
                ;; 
            3)
                echo -e "${RED}Cette fonction n'est pas encore implémentée.${NC}"
                echo -e "${YELLOW}Veuillez d'abord vous procurer un module ADC (ex: ADS1115).${NC}"
                sleep 3
                ;; 
            0)
                return
                ;; 
            *)
                echo -e "${RED}❌ Option invalide !${NC}"
                sleep 1
                ;; 
        esac
    done
}