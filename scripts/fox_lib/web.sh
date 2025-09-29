#!/bin/bash

# Bibliothèque pour toutes les fonctions liées au test d'intrusion d'applications web.

web_testing_menu() {
    while true; do
        clear; show_fox
        echo -e "${BLUE}${BOLD}🌐 WEB TESTING & EXPLOITATION 🌐${NC}"
        echo "=================================================="
        echo "[1] 🚀 Scan Web Complet (Automatisé)"
        echo "[2] 🔍 Découverte de Dossiers/Fichiers"
        echo "[3] 💉 Test d'Injection SQL (SQLMap)"
        echo "[4] 🕷️  Scan de Vulnérabilités Web (Nikto)"
        echo "[5] 🔎 Détection de Technologies Web (WhatWeb)"
        echo "[6] 🔐 Analyse SSL/TLS"
        echo "[7] 📊 Test des Méthodes HTTP"
        echo "[0] ⬅️  Retour"
        local choice; read -r -p "🦊 Votre choix: " choice
        case "$choice" in
            1) full_web_scan ;; 2) directory_discovery ;; 3) sql_injection_testing ;; 4) web_vulnerability_scan ;; 5) web_technology_detection ;; 6) ssl_tls_analysis ;; 7) http_methods_testing ;; 0) return ;; *) echo -e "${RED}❌ Option invalide !${NC}"; sleep 1;;
        esac
    done
}

full_web_scan() {
    clear; show_fox
    echo -e "${BLUE}${BOLD}🚀 FULL WEB SCAN (AUTOMATED)${NC}"
    local target_url; read -r -p "URL cible (ex: http://example.com): " target_url
    if [[ -z "$target_url" ]]; then echo -e "${RED}❌ URL requise !${NC}"; sleep 2; return; fi
    local domain
    domain=$(echo "$target_url" | awk -F/ '{print $3}')
    local output_dir
    output_dir="$PIHACK_OUTPUT_PATH/web/full_scan_${domain}_$(date +%Y%m%d_%H%M%S)"; mkdir -p "$output_dir"
    echo -e "${CYAN}🔍 Lancement du scan web complet sur ${target_url}...${NC}"
    echo -e "${YELLOW}[1/4] Lancement de WhatWeb...${NC}"; whatweb -v "$target_url" > "$output_dir/whatweb.txt"
    echo -e "${YELLOW}[2/4] Lancement de Nmap...${NC}"; nmap -p 80,443 -A "$domain" > "$output_dir/nmap.txt"
    echo -e "${YELLOW}[3/4] Lancement de Nikto...${NC}"; nikto -h "$target_url" -o "$output_dir/nikto.txt" -Format txt
    local wordlist
    wordlist=$(find_wordlist "common.txt")
    if [[ -z "$wordlist" ]]; then echo -e "${RED}❌ Wordlist 'common.txt' introuvable!${NC}"; sleep 3; return; fi
    echo -e "${YELLOW}[4/4] Lancement de Gobuster...${NC}"; gobuster dir -u "$target_url" -w "$wordlist" -o "$output_dir/gobuster.txt"
    echo -e "${GREEN}✅ Scan web complet terminé.${NC}"; press_enter_to_continue
}

directory_discovery() {
    local target_url; select_web_target; if [[ -z "$selected_url" ]]; then return; fi; target_url="$selected_url"
    clear; show_fox
    echo -e "${BLUE}${BOLD}🔍 DIRECTORY & FILE DISCOVERY sur ${target_url}${NC}"
    echo "[1] Rapide (common.txt)" "[2] Moyenne (directory-list-2.3-medium.txt)" "[3] Complète (big.txt)"; read -r -p "Choix de la wordlist: " wl_choice
    local wordlist_name
    case "$wl_choice" in
        1) wordlist_name="common.txt" ;;
        2) wordlist_name="directory-list-2.3-medium.txt" ;;
        3) wordlist_name="big.txt" ;;
        *) echo -e "${RED}❌ Option invalide !${NC}"; sleep 2; return ;;
    esac
    local wordlist
    wordlist=$(find_wordlist "$wordlist_name")
    if [[ -z "$wordlist" ]]; then echo -e "${RED}❌ Wordlist '$wordlist_name' introuvable!${NC}"; sleep 3; return; fi
    echo "[1] Gobuster" "[2] Dirb"; read -r -p "Choix de l'outil: " tool_choice
    local output_file
    local domain
    domain=$(echo "$target_url" | awk -F/ '{print $3}')
    case "$tool_choice" in
        1) output_file="$PIHACK_OUTPUT_PATH/web/gobuster_${domain}_$(date +%Y%m%d_%H%M%S).txt"; gobuster dir -u "$target_url" -w "$wordlist" -o "$output_file" ;;
        2) output_file="$PIHACK_OUTPUT_PATH/web/dirb_${domain}_$(date +%Y%m%d_%H%M%S).txt"; dirb "$target_url" "$wordlist" -o "$output_file" ;;
        *) echo -e "${RED}❌ Option invalide !${NC}"; sleep 2; return ;;
    esac
    echo -e "\n${GREEN}🎯 Scan terminé ! Résultats dans: ${output_file}${NC}"; press_enter_to_continue
}

sql_injection_testing() {
    local target_url; read -r -p "URL complète avec paramètres (ex: http://.../test.php?id=1): " target_url
    if [[ -z "$target_url" ]]; then echo -e "${RED}❌ URL requise !${NC}"; sleep 2; return; fi
    if ! check_tool "sqlmap"; then echo -e "${RED}❌ SQLMap non installé !${NC}"; sleep 2; return; fi
    echo "[1] Détection simple" "[2] Énumération des BDD" "[3] Dump complet"; read -r -p "Choix de l'action: " sql_choice
    local output_dir
    output_dir="$PIHACK_OUTPUT_PATH/web/sqlmap_$(date +%Y%m%d_%H%M%S)"; mkdir -p "$output_dir"
    local sqlmap_cmd_array=(sqlmap -u "$target_url" --batch --output-dir="$output_dir")
    case "$sql_choice" in
        1) "${sqlmap_cmd_array[@]}" ;; 
        2) sqlmap_cmd_array+=(--dbs); "${sqlmap_cmd_array[@]}" ;; 
        3) sqlmap_cmd_array+=(--dump-all); "${sqlmap_cmd_array[@]}" ;; 
        *) echo -e "${RED}❌ Option invalide !${NC}"; sleep 2; return ;; 
    esac
    echo -e "\n${GREEN}🎯 Test SQLMap terminé ! Résultats dans: ${output_dir}${NC}"; press_enter_to_continue
}

web_vulnerability_scan() {
    local target_url; select_web_target; if [[ -z "$selected_url" ]]; then return; fi; target_url="$selected_url"
    if ! check_tool "nikto"; then echo -e "${RED}❌ Nikto non installé !${NC}"; sleep 2; return; fi
    local domain
    domain=$(echo "$target_url" | awk -F/ '{print $3}')
    local output_file
    output_file="$PIHACK_OUTPUT_PATH/web/nikto_${domain}_$(date +%Y%m%d_%H%M%S).txt"
    echo -e "\n${YELLOW}🔄 Lancement de Nikto...${NC}"
    nikto -h "$target_url" -o "$output_file" -Format txt
    echo -e "\n${GREEN}✅ Scan Nikto terminé ! Rapport: ${output_file}${NC}"
    press_enter_to_continue
}

web_technology_detection() {
    local target_url; select_web_target; if [[ -z "$selected_url" ]]; then return; fi; target_url="$selected_url"
    if ! check_tool "whatweb"; then echo -e "${RED}❌ WhatWeb non installé !${NC}"; sleep 2; return; fi
    local domain
    domain=$(echo "$target_url" | awk -F/ '{print $3}')
    local output_file
    output_file="$PIHACK_OUTPUT_PATH/web/whatweb_${domain}_$(date +%Y%m%d_%H%M%S).txt"
    echo -e "\n${YELLOW}🔄 Détection des technologies...${NC}"
    whatweb -v "$target_url" | tee "$output_file"
    echo -e "\n${GREEN}✅ Détection terminée ! Résultats: ${output_file}${NC}"
    press_enter_to_continue
}

ssl_tls_analysis() {
    local host; read -r -p "Hôte (ex: google.com): " host
    if [[ -z "$host" ]]; then echo -e "${RED}❌ Hôte requis !${NC}"; sleep 2; return; fi
    echo -e "\n${CYAN}🔍 Analyse du certificat SSL/TLS...${NC}"
    echo | openssl s_client -servername "$host" -connect "$host:443" 2>/dev/null | openssl x509 -text -noout | less
    press_enter_to_continue
}

http_methods_testing() {
    local url; read -r -p "URL cible: " url
    if [[ -z "$url" ]]; then echo -e "${RED}❌ URL requise !${NC}"; sleep 2; return; fi
    echo -e "\n${CYAN}🔍 Test des méthodes HTTP...${NC}"
    curl -X OPTIONS -i "$url"
    press_enter_to_continue
}
