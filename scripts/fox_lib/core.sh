#!/bin/bash

# Fichier principal de la bibliothque FOX
# Contient les fonctions de base, les variables globales et les handlers.

# --- VARIABLES GLOBALES DE COULEUR ---
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export BOLD='\033[1m'
export NC='\033[0m' # No Color

# --- GESTION D'ERREURS ROBUSTE ---
set -o pipefail
IFS=$'\n\t'

error_handler() {
    local line_number=$1
    local last_command=${BASH_COMMAND}
    echo -e "${RED}❌ ERREUR  la ligne ${line_number}: la commande '${last_command}' a chou.${NC}"
}
trap 'error_handler $LINENO' ERR

# --- CONFIGURATION & MISE  JOUR ---
load_config(){
    local config_file="$HOME/.pihackrc"
    if [[ ! -f "$config_file" ]]; then
        cat > "$config_file" << EOF
# Configuration Fox V2.0
PIHACK_AUTO_UPDATE=true
PIHACK_TOOLS_AUTO_UPDATE=true
EOF
    fi
    source "$config_file" 2>/dev/null || true
}

check_updates() {
    local project_dir="${SCRIPT_DIR}/../.."
    if check_tool "git" && [[ -d "${project_dir}/.git" ]]; then
        echo -e "${BLUE}🔄 Vrification des mises  jour...${NC}"
        local original_dir="$(pwd)"
        cd "${project_dir}" || return
        git remote update >/dev/null 2>&1
        local status
        status=$(git status -uno)
        if [[ "$status" == *"Your branch is behind"* ]]; then
            echo -e "${YELLOW}📡 Nouvelle version disponible!${NC}"
            read -r -p "Mettre  jour? (y/n): " update_choice
            if [[ "$update_choice" =~ ^[Yy]$ ]]; then
                git pull
                echo -e "${GREEN}✅ Mise  jour termine ! Veuillez relancer le script.${NC}"
                cd "${original_dir}"
                exit 0
            fi
        else
            echo -e "${GREEN}✅ Vous tes  jour.${NC}"
        fi
        cd "${original_dir}"
    fi
}

# --- FONCTIONS UTILITAIRES DE BASE ---
check_tool() {
    command -v "$1" >/dev/null 2>&1
}

find_wordlist() {
    local wordlist_name="$1"
    local wordlist_paths=(
        "/usr/share/wordlists/${wordlist_name}"
        "/usr/share/wordlists/dirb/${wordlist_name}"
        "/usr/share/wordlists/dirbuster/${wordlist_name}"
        "${SCRIPT_DIR}/../wordlists/${wordlist_name}"
    )
    for path in "${wordlist_paths[@]}"; do
        if [[ -f "$path" ]]; then
            echo "$path"
            return 0
        fi
    done
    return 1
}

# --- FONCTIONS DE CYCLE DE VIE DU SCRIPT ---
cleanup_exit() {
    echo -e "\n${YELLOW}🧹 Nettoyage avant de quitter...${NC}"
    trap - ERR
    exit 0
}
trap cleanup_exit SIGINT SIGTERM

# --- AIDE ET VERSION ---
show_help() {
    clear
    echo -e "${CYAN}${BOLD}🦊 Fox V2.0 - AIDE${NC}"
    echo "========================="
    echo "• Utilisez les numros pour naviguer."
    echo "• '0' pour revenir en arrire."
    echo "• Ctrl+C pour quitter proprement."
    press_enter_to_continue
}

show_version() {
    clear
    echo -e "${CYAN}${BOLD}🦊 Fox V2.0${NC}"
    echo "======================="
    echo "Version: 2.0 Ultimate Edition"
    press_enter_to_continue
}

# --- GESTION DE PROJET ET DE CIBLE ---
create_project_structure() {
    local project_path="$1"
    if [ ! -d "$project_path/scans" ]; then
        mkdir -p "$project_path/scans" "$project_path/web" "$project_path/exploits" "$project_path/loot" "$project_path/reports" "$project_path/system"
    fi
}

setup_target() {
    clear
    show_fox
    echo -e "${BLUE}${BOLD}🎯 GESTION DE PROJET 🎯${NC}"
    find "${SCRIPT_DIR}/../projects" -mindepth 1 -maxdepth 1 -type d -exec basename {} \;
    read -r -p "Entrez le nom du projet/cible (laissez vide pour un nouveau): " target_name
    if [ -z "$target_name" ]; then
        read -r -p "Nom du nouveau projet: " new_target
        CURRENT_TARGET="${new_target:-cible_par_dfaut}"
    else
        CURRENT_TARGET="$target_name"
    fi
    export CURRENT_TARGET
    export PIHACK_OUTPUT_PATH="${SCRIPT_DIR}/../projects/${CURRENT_TARGET}"
    mkdir -p "$PIHACK_OUTPUT_PATH"
    create_project_structure "$PIHACK_OUTPUT_PATH"
    local target_info_file="$PIHACK_OUTPUT_PATH/target.info"
    if [ ! -f "$target_info_file" ]; then
        read -r -p "Entrez l'IP de la cible (optionnel): " target_ip
        {
            echo "TARGET_NAME='$CURRENT_TARGET'"
            echo "TARGET_IP='${target_ip:-'N/A'}'"
            echo "CREATION_DATE='$(date)'"
        } > "$target_info_file"
    fi
    source "$target_info_file"
    echo -e "${GREEN}✅ Cible active: ${TARGET_NAME} (IP: ${TARGET_IP})${NC}"
    sleep 2
}

select_strategy() {
    clear
    show_fox
    echo -e "${BLUE}${BOLD}🧠 STRATEGIE D'APPROCHE 🧠${NC}"
    echo "[1] Discret" "[2] Normal" "[3] Agressif"
    read -r -p "Votre choix [defaut: 2]: " strategy_choice
    case "$strategy_choice" in
        1) export PIHACK_STRATEGY="stealth" ;;
        3) export PIHACK_STRATEGY="aggressive" ;;
        *) export PIHACK_STRATEGY="normal" ;;
    esac
    echo -e "${GREEN}✅ Strategie pour cette session: ${BOLD}${PIHACK_STRATEGY}${NC}"
    sleep 2
}

# --- GESTION DU BUTIN (LOOT) ---
add_to_loot() {
    local loot_type="$1" description="$2" source_tool="$3"
    if [[ -z "$PIHACK_OUTPUT_PATH" ]]; then return; fi
    local loot_file="$PIHACK_OUTPUT_PATH/loot.csv"
    if [[ ! -f "$loot_file" ]]; then echo '"Timestamp","Type","Description","Source"' > "$loot_file"; fi
    printf '"%s","%s","%s","%s"\n' "$(date +"%Y-%m-%d %H:%M:%S")" "$loot_type" "$description" "$source_tool" >> "$loot_file"
    echo -e "${PURPLE}💎 Nouveau butin ajout: [${NC}${loot_type}${PURPLE}] ${NC}${description}${NC}"
}

# --- DTECTION MATRIELLE ---
initialize_hardware_detection() {
    echo -e "${BLUE}🔍 Dtection du matriel spcialis...${NC}"
    local lsusb_output
    lsusb_output=$(lsusb)
    if echo "$lsusb_output" | grep -q '0bda:2838'; then export HAS_RTLSDR=true; echo -e "${GREEN}✅ RTL-SDR dtect.${NC}"; else export HAS_RTLSDR=false; fi
    if echo "$lsusb_output" | grep -q '1d50:6089'; then export HAS_HACKRF=true; echo -e "${GREEN}✅ HackRF One dtect.${NC}"; else export HAS_HACKRF=false; fi
    if echo "$lsusb_output" | grep -q '0483:5740'; then export HAS_FLIPPER=true; echo -e "${GREEN}✅ Flipper Zero dtect.${NC}"; else export HAS_FLIPPER=false; fi
    if echo "$lsusb_output" | grep -q '2d2d:504d'; then export HAS_PROXMARK3=true; echo -e "${GREEN}✅ Proxmark3 dtect.${NC}"; else export HAS_PROXMARK3=false; fi
    if check_tool "hciconfig" && [[ -n $(hciconfig) ]]; then export HAS_BLUETOOTH=true; echo -e "${GREEN}✅ Adaptateur Bluetooth dtect.${NC}"; else export HAS_BLUETOOTH=false; fi
    sleep 1
}

# --- COPILOTES DE SLECTION DE CIBLE ---
select_target_from_loot() {
    local title="$1" loot_file="$PIHACK_OUTPUT_PATH/loot.csv" targets=()
    selected_target=""
    if [[ -n "$TARGET_IP" && "$TARGET_IP" != "N/A" ]]; then targets+=("$TARGET_IP"); fi
    if [[ -f "$loot_file" ]]; then
        local discovered_hosts
        discovered_hosts=$(grep ',"HOST",' "$loot_file" | cut -d '"' -f 6 | sort -u || true)
        for host in $discovered_hosts; do targets+=("$host"); done
    fi
    local unique_targets
    mapfile -t unique_targets < <(echo "${targets[@]}" | tr ' ' '\n' | sort -u)
    if [ ${#unique_targets[@]} -eq 0 ]; then echo -e "${RED}Aucune cible IP disponible.${NC}"; sleep 2; return; fi
    clear; show_fox; echo -e "${BLUE}${BOLD}🎯 ${title} 🎯${NC}"
    echo -e "${CYAN}Choisissez une cible:${NC}"
    local i=1
    for target_ip in "${unique_targets[@]}"; do
        printf "  ${GREEN}[%d]${NC} %-15s %s\n" "$i" "$target_ip" "${label:-}" 
        i=$((i+1))
    done
    read -r -p "🦊 Votre choix: " target_choice
    if ! [[ "$target_choice" =~ ^[0-9]+$ ]] || [ "$target_choice" -lt 1 ] || [ "$target_choice" -gt ${#unique_targets[@]} ]; then
        echo -e "${RED}❌ Choix invalide.${NC}"; sleep 2; return
    fi
    selected_target=${unique_targets[$((target_choice-1))]}
}

select_web_target() {
    local loot_file="$PIHACK_OUTPUT_PATH/loot.csv" web_targets=()
    selected_url=""
    if [[ ! -f "$loot_file" ]]; then echo -e "${RED}Aucun service web dcouvert. Lancez un scan de ports d'abord.${NC}"; sleep 2; return; fi

    while read -r line; do
        local description
        description=$(echo "$line" | cut -d '"' -f 6)
        if echo "$description" | grep -qE 'http|https|80/|443/'; then
            local proto="http"
            if [[ "$description" == *"https"* || "$description" == *"443"* ]]; then proto="https"; fi
            local port
            port=$(echo "$description" | awk '{print $2}' | cut -d'/' -f1)
            local ip
            ip=$(echo "$description" | awk '{print $NF}')
            local url="$proto://$ip:$port"
            web_targets+=("$url")
        fi
    done < <(grep ',"SERVICE",' "$loot_file" || true)

    local unique_targets
    mapfile -t unique_targets < <(echo "${web_targets[@]}" | tr ' ' '\n' | sort -u)
    if [ ${#unique_targets[@]} -eq 0 ]; then echo -e "${RED}Aucun service web dcouvert dans le butin.${NC}"; sleep 2; return; fi
    
    clear; show_fox; echo -e "${BLUE}${BOLD}🎯 SLECTION DE CIBLE WEB 🎯${NC}"
    echo -e "${CYAN}Choisissez une URL  attaquer:${NC}"
    local i=1
    for url in "${unique_targets[@]}"; do printf "  ${GREEN}[%d]${NC} %s\n" "$i" "$url"; i=$((i+1)); done
    read -r -p "🦊 Votre choix: " target_choice
    if ! [[ "$target_choice" =~ ^[0-9]+$ ]] || [ "$target_choice" -lt 1 ] || [ "$target_choice" -gt ${#unique_targets[@]} ]; then echo -e "${RED}❌ Choix invalide.${NC}"; sleep 2; return; fi
    selected_url=${unique_targets[$((target_choice-1))]}
}

# --- CO-PILOTE DE SÉLECTION DE FICHIER ---
select_file_target() {
    local title="$1"
    local pattern="${2:-*}" # Default to any file if no pattern is provided
    selected_file=""

    clear
    show_fox
    echo -e "${BLUE}${BOLD}🎯 ${title} 🎯${NC}"
    echo -e "${CYAN}Sélectionnez un fichier cible:${NC}"

    # Search for files in the project directory and common system paths
    local search_paths=("$PIHACK_OUTPUT_PATH" "$HOME/Downloads" "$HOME/Documents" "/tmp")
    local found_files=()

    echo -e "${YELLOW}Recherche de fichiers correspondant à '${pattern}'...${NC}"
    for path in "${search_paths[@]}"; do
        if [ -d "$path" ]; then
            # Find files, excluding directories, and add them to the array
            while IFS= read -r file; do
                found_files+=("$file")
            done < <(find "$path" -type f -name "$pattern" 2>/dev/null)
        fi
    done

    if [ ${#found_files[@]} -eq 0 ]; then
        echo -e "${RED}❌ Aucun fichier correspondant au pattern '${pattern}' trouvé dans les chemins de recherche.${NC}"
    else
        local i=1
        for file in "${found_files[@]}"; do
            printf "  ${GREEN}[%d]${NC} %s\n" "$i" "$file"
            i=$((i+1))
        done
    fi

    echo ""
    echo -e "${CYAN}Entrez le numéro du fichier, ou entrez un chemin d'accès complet:${NC}"
    read -r -p "🦊 Votre choix: " choice

    if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le ${#found_files[@]} ]; then
        # User selected a number
        selected_file=${found_files[$((choice-1))]}
    elif [ -f "$choice" ]; then
        # User entered a valid file path
        selected_file="$choice"
    elif [ -n "$choice" ]; then
        echo -e "${RED}❌ Choix invalide ou fichier non trouvé.${NC}"
        sleep 2
        return 1
    else
        # User entered nothing
        return 1
    fi

    if [ -n "$selected_file" ]; then
        echo -e "${GREEN}✅ Fichier sélectionné: $selected_file${NC}"
        sleep 1
        return 0
    fi
    return 1
}


# --- INSTALLATEUR AU PREMIER LANCEMENT ---
auto_install_tools() {
    echo -e "${YELLOW}🔧 Vérification des outils essentiels...${NC}"
    # Liste des outils critiques pour le fonctionnement de base
    local tools_to_check=(nmap gobuster nikto sqlmap john hashcat hydra aircrack-ng tshark)
    local missing_tools=()

    for tool in "${tools_to_check[@]}"; do
        if ! check_tool "$tool"; then
            echo -e "${RED}❌ Outil manquant: ${tool}${NC}"
            missing_tools+=("$tool")
        else
            echo -e "${GREEN}✅ Outil trouvé: ${tool}${NC}"
        fi
    done

    if [ ${#missing_tools[@]} -gt 0 ]; then
        echo -e "\n${RED}Certains outils essentiels sont manquants.${NC}"
        read -r -p "Voulez-vous les installer maintenant? (y/n): " install_choice
        if [[ "$install_choice" =~ ^[Yy]$ ]]; then
            echo -e "${BLUE}🔧 Mise à jour des paquets et installation des outils manquants...${NC}"
            sudo apt update
            for tool in "${missing_tools[@]}"; do
                echo -e "${BLUE}Installation de ${tool}...${NC}"
                sudo apt install -y "$tool"
            done
            echo -e "${GREEN}✅ Installation terminée.${NC}"
        else
            echo -e "${YELLOW}Installation annulée. Certaines fonctionnalités pourraient ne pas être disponibles.${NC}"
        fi
    else
        echo -e "\n${GREEN}✅ Tous les outils essentiels sont présents.${NC}"
    fi

    # Créer le fichier pour ne pas re-vérifier au prochain lancement
    touch "$HOME/.pihack_tools_checked"
    echo -e "\n${GREEN}Vérification terminée. Le script va maintenant lancer le menu principal...${NC}"
    sleep 3
    main_menu
}