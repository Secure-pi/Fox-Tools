#!/bin/bash

password_menu() {
    while true; do
        clear
        show_fox
        echo -e "${BLUE}${BOLD}🔓 PASSWORD ATTACKS & CRACKING 🔓${NC}"
        echo "=================================================="
        echo -e "${GREEN}[1]${NC}  💥 John The Ripper (Crack Hashes)"
        echo -e "${GREEN}[2]${NC}  🌈 Hashcat (GPU Hash Cracking)"
        echo -e "${GREEN}[3]${NC}  🐉 Hydra (Online Brute-Force)"
        echo -e "${GREEN}[4]${NC}  ⚙️  Crunch (Wordlist Generator)"
        echo -e "${GREEN}[5]${NC}  📚 Password & Hash Cracking Examples"
        echo ""
        echo -e "${RED}[0]${NC}  ⬅️  Retour au menu principal"
        echo ""
        echo -n -e "${YELLOW}Choisissez une option: ${NC}"
        
        read -r choice
        
        case $choice in
            1) run_john ;;
            2) run_hashcat ;;
            3) run_hydra ;;
            4) run_crunch ;;
            5) password_hash_cracking ;;
            0) return ;;
            *)
                echo -e "${RED}❌ Option invalide !${NC}"
                sleep 1
                ;;
        esac
    done
}

run_john() {
    if [[ -z "$PIHACK_OUTPUT_PATH" ]]; then
        echo -e "${RED}❌ Aucun projet actif. Veuillez d'abord définir un projet.${NC}"
        sleep 2
        return
    fi

    # --- CO-PILOTE DE SÉLECTION DE FICHIER ---
    select_file_target "CRACKING AVEC JOHN THE RIPPER" "*.(txt|hashes)"
    if [[ -z "$selected_file" ]]; then return; fi
    local hash_file="$selected_file"

    clear
    show_fox
    echo -e "${BLUE}${BOLD}💥 JOHN THE RIPPER sur $(basename "$hash_file")${NC}"
    echo "=================================================="

    echo ""
    echo -e "${CYAN}📖 Choisissez la wordlist:${NC}"
    echo -e "${GREEN}[1]${NC} Par défaut (règles de John)"
    echo -e "${GREEN}[2]${NC} Rapide (fasttrack.txt)"
    echo -e "${GREEN}[3]${NC} Complète (rockyou.txt)"
    echo -e "${GREEN}[4]${NC} Chemin personnalisé"
    echo -n -e "${YELLOW}Choix: ${NC}"
    read -r wordlist_choice

    local wordlist=""
    case $wordlist_choice in
        1) # Default mode, no wordlist argument
           ;;
        2) wordlist="/usr/share/wordlists/fasttrack.txt" ;; 
        3) wordlist="/usr/share/wordlists/rockyou.txt" ;; 
        4) echo -n -e "${YELLOW}Entrez le chemin de votre wordlist: ${NC}"; read -r wordlist ;; 
        *) echo -e "${RED}❌ Option invalide !${NC}"; sleep 2; return ;; 
    esac

    # Utiliser un tableau pour construire la commande de manière sécurisée
    local john_cmd_array=(john)

    # Handle wordlist selection
    if [[ -n "$wordlist" ]]; then
        if [[ ! -f "$wordlist" ]]; then
            if [[ -f "${wordlist}.gz" ]]; then
                echo -e "${YELLOW}Décompression de ${wordlist}.gz...${NC}"
                gunzip -k "${wordlist}.gz"
            else
                echo -e "${RED}❌ Wordlist non trouvée: $wordlist${NC}"; sleep 2; return
            fi
        fi
        john_cmd_array+=(--wordlist="$wordlist")
    fi

    # Project-specific pot file
    mkdir -p "$PIHACK_OUTPUT_PATH/exploits"
    local pot_file="$PIHACK_OUTPUT_PATH/exploits/john.pot"
    john_cmd_array+=(--pot="$pot_file" "$hash_file")

    echo ""
    echo -e "${YELLOW}⚡ Lancement de John The Ripper... Commande:${NC}"
    echo -e "${CYAN}${john_cmd_array[*]}${NC}"

    # Exécuter la commande de manière sécurisée
    "${john_cmd_array[@]}"

    echo ""
    echo -e "${GREEN}🎯 Attaque terminée !${NC}"
    echo -e "${BLUE}Pot file (mots de passe crackés) sauvegardé dans: $pot_file${NC}"
    
    echo ""
    echo -e "${YELLOW}Affichage des mots de passe crackés pour ce fichier:${NC}"
    john --show --pot="$pot_file" "$hash_file"

    echo ""
    echo -e "${CYAN}Appuyez sur Entrée pour continuer...${NC}"
    read -r
}

run_hashcat() {
    if [[ -z "$PIHACK_OUTPUT_PATH" ]]; then
        echo -e "${RED}❌ Aucun projet actif. Veuillez d'abord définir un projet.${NC}"
        sleep 2
        return
    fi

    # --- CO-PILOTE DE SÉLECTION DE FICHIER ---
    select_file_target "CRACKING AVEC HASHCAT" "*.(txt|hashes)"
    if [[ -z "$selected_file" ]]; then return; fi
    local hash_file="$selected_file"

    clear
    show_fox
    echo -e "${BLUE}${BOLD}🌈 HASHCAT - GPU Hash Cracking sur $(basename "$hash_file")${NC}"
    echo "=================================================="

    echo ""
    echo -e "${CYAN}Quelques modes Hashcat courants:${NC}"
    echo "  0   - MD5"
    echo "  100 - SHA1"
    echo "  1000 - NTLM"
    echo "  1400 - SHA256"
    echo "  1700 - SHA512"
    echo "  3200 - Bcrypt"
    echo -n -e "${YELLOW}🔢 Entrez le mode Hashcat (ex: 0): ${NC}"
    read -r hash_mode
    if [[ -z "$hash_mode" ]]; then echo -e "${RED}❌ Mode requis!${NC}"; sleep 2; return; fi

    echo ""
    echo -e "${CYAN}📖 Choisissez la wordlist:${NC}"
    echo -e "${GREEN}[1]${NC} Rapide (fasttrack.txt)"
    echo -e "${GREEN}[2]${NC} Complète (rockyou.txt)"
    echo -e "${GREEN}[3]${NC} Chemin personnalisé"
    echo -n -e "${YELLOW}Choix: ${NC}"
    read -r wordlist_choice

    local wordlist=""
    case $wordlist_choice in
        1) wordlist="/usr/share/wordlists/fasttrack.txt" ;; 
        2) wordlist="/usr/share/wordlists/rockyou.txt" ;; 
        3) echo -n -e "${YELLOW}Entrez le chemin de votre wordlist: ${NC}"; read -r wordlist ;; 
        *) echo -e "${RED}❌ Option invalide !${NC}"; sleep 2; return ;; 
    esac

    if [[ ! -f "$wordlist" ]]; then
        if [[ -f "${wordlist}.gz" ]]; then
            echo -e "${YELLOW}Décompression de ${wordlist}.gz...${NC}"
            gunzip -k "${wordlist}.gz"
        else
            echo -e "${RED}❌ Wordlist non trouvée: $wordlist${NC}"; sleep 2; return
        fi
    fi

    mkdir -p "$PIHACK_OUTPUT_PATH/exploits"
    local pot_file="$PIHACK_OUTPUT_PATH/exploits/hashcat.potfile"
    local out_file="$PIHACK_OUTPUT_PATH/exploits/hashcat_cracked.txt"

    # Utiliser un tableau pour construire la commande de manière sécurisée
    # -a 0 = Straight dictionary attack
    local hashcat_cmd_array=(hashcat -m "$hash_mode" -a 0 --potfile-path "$pot_file" --outfile "$out_file" "$hash_file" "$wordlist")

    echo ""
    echo -e "${YELLOW}⚡ Lancement de Hashcat... Commande:${NC}"
    echo -e "${CYAN}${hashcat_cmd_array[*]}${NC}"

    # Exécuter la commande de manière sécurisée
    "${hashcat_cmd_array[@]}"

    echo ""
    echo -e "${GREEN}🎯 Attaque terminée !${NC}"
    
    if [[ -s "$out_file" ]]; then
        echo -e "${GREEN}🎉 Mots de passe crackés sauvegardés dans: $out_file${NC}"
        echo -e "${YELLOW}--- RÉSULTATS ---${NC}"
        cat "$out_file"
    else
        echo -e "${RED}❌ Aucun nouveau mot de passe cracké avec cette wordlist.${NC}"
    fi
    echo -e "${BLUE}Potfile (tous les hashs) sauvegardé dans: $pot_file${NC}"

    echo ""
    echo -e "${CYAN}Appuyez sur Entrée pour continuer...${NC}"
    read -r
}

run_hydra() {
    # --- CO-PILOTE DE CIBLAGE ---
    select_target_from_loot "ATTAQUE BRUTE-FORCE EN LIGNE"
    if [[ -z "$selected_target" ]]; then return; fi
    local target="$selected_target"

    clear
    show_fox
    echo -e "${BLUE}${BOLD}🐉 HYDRA - Online Brute-Force sur $target${NC}"
    echo "=================================================="
    
    echo -n -e "${YELLOW}👤 Utilisateur [ex: admin, root]: ${NC}"
    read -r user
    if [[ -z "$user" ]]; then echo -e "${RED}❌ Utilisateur requis!${NC}"; sleep 2; return; fi

    echo -n -e "${YELLOW}🔧 Service [ex: ssh, ftp, http-post-form]: ${NC}"
    read -r service
    if [[ -z "$service" ]]; then echo -e "${RED}❌ Service requis!${NC}"; sleep 2; return; fi

    echo ""
    echo -e "${CYAN}📖 Choisissez la wordlist de mots de passe:${NC}"
    echo -e "${GREEN}[1]${NC} Rapide (fasttrack.txt)"
    echo -e "${GREEN}[2]${NC} Complète (rockyou.txt)"
    echo -e "${GREEN}[3]${NC} Chemin personnalisé"
    echo -n -e "${YELLOW}Choix: ${NC}"
    read -r wordlist_choice

    local pass_wordlist=""
    case $wordlist_choice in
        1) pass_wordlist="/usr/share/wordlists/fasttrack.txt" ;; 
        2) pass_wordlist="/usr/share/wordlists/rockyou.txt" ;; 
        3) echo -n -e "${YELLOW}Entrez le chemin de votre wordlist: ${NC}"; read -r pass_wordlist ;; 
        *) echo -e "${RED}❌ Option invalide !${NC}"; sleep 2; return ;; 
    esac

    if [[ ! -f "$pass_wordlist" ]]; then
        if [[ -f "${pass_wordlist}.gz" ]]; then
            echo -e "${YELLOW}Décompression de ${pass_wordlist}.gz...${NC}"
            gunzip -k "${pass_wordlist}.gz"
        else
            echo -e "${RED}❌ Wordlist non trouvée: $pass_wordlist${NC}"; sleep 2; return
        fi
    fi

    mkdir -p "$PIHACK_OUTPUT_PATH/exploits"
    local timestamp
    timestamp=$(date +%Y%m%d_%H%M%S)
    local output_file="$PIHACK_OUTPUT_PATH/exploits/hydra_${service}_${user}_${timestamp}.txt"

    # Utiliser un tableau pour construire la commande de manière sécurisée
    local hydra_cmd_array=(hydra -l "$user" -P "$pass_wordlist" "$target" "$service" -t 4 -V)
    
    echo ""
    echo -e "${YELLOW}⚡ Lancement de Hydra... Commande:${NC}"
    echo -e "${CYAN}${hydra_cmd_array[*]}${NC}"

    # Exécuter la commande de manière sécurisée
    "${hydra_cmd_array[@]}" | tee "$output_file"

    echo ""
    echo -e "${GREEN}🎯 Attaque terminée !${NC}"
    echo -e "${BLUE}📁 Résultats dans: $output_file${NC}"
    
    # --- GESTION DU BUTIN ---
    if grep -q "1 host, 1 valid password found" "$output_file"; then
        echo -e "${GREEN}${BOLD}🎉 MOT DE PASSE TROUVÉ ! 🎉${NC}"
        local found_line
        found_line=$(grep "password:" "$output_file" || true)
        echo "$found_line"
        
        # Extraction et ajout au butin
        local found_user
        found_user=$(echo "$found_line" | awk '{print $4}')
        local found_pass
        found_pass=$(echo "$found_line" | awk '{print $6}')
        add_to_loot "CREDENTIAL" "$service - $found_user:$found_pass" "hydra"
    else
        echo -e "${RED}❌ Aucun mot de passe trouvé avec cette wordlist.${NC}"
    fi

    echo ""
    echo -e "${CYAN}Appuyez sur Entrée pour continuer...${NC}"
    read -r
}

run_crunch() {
    clear
    show_fox
    echo -e "${BLUE}${BOLD}⚙️ CRUNCH${NC}"
    echo "=================================================="
    echo -n -e "${YELLOW}🔢 Longueur minimale: ${NC}"
    read -r min_len
    echo -n -e "${YELLOW}🔢 Longueur maximale: ${NC}"
    read -r max_len
    echo -n -e "${YELLOW}🔡 Caractères (ex: abcde123): ${NC}"
    read -r charset

    if [[ -z "$min_len" || -z "$max_len" || -z "$charset" ]]; then
        echo -e "${RED}❌ Tous les champs sont requis !${NC}"
        sleep 2
        return
    fi

    echo -e "${CYAN}Génération de la wordlist... (Ctrl+C pour arrêter)${NC}"
    trap '' SIGINT
    crunch "$min_len" "$max_len" "$charset"
    trap cleanup_exit SIGINT SIGTERM

    echo -e "\n${GREEN}✅ Génération terminée.${NC}"

    read -r -p "Appuyez sur Entrée pour continuer..."
}

# 🗝️ PASSWORD & HASH CRACKING
password_hash_cracking() {
    clear
    echo -e "${RED}🗝️ PASSWORD & HASH CRACKING${NC}"
    echo "==========================="
    
    echo -e "${GREEN}[1]${NC} 🔍 Hash Identification"
    echo -e "${GREEN}[2]${NC} 💥 John The Ripper"
    echo -e "${GREEN}[3]${NC} 🌈 Hashcat Commands"
    echo -e "${GREEN}[4]${NC} 📚 Custom Wordlists"
    echo -e "${GREEN}[5]${NC} 🔐 Password Generation"
    
    read -r -p "🦊 Outil de cracking: " crack_choice
    
    case $crack_choice in
        1) # Hash ID
            echo -e "${YELLOW}🔍 Hash Identification:${NC}"
            read -r -p "Entrez le hash à identifier: " hash_input
            
            echo -e "${CYAN}Analysing hash...${NC}"
            echo "Hash: $hash_input"
            echo ""
            
            # Détection basique par longueur
            local hash_len=${#hash_input}
            case $hash_len in
                32) echo "Possible: MD5" ;; 
                40) echo "Possible: SHA1" ;; 
                64) echo "Possible: SHA256, NTLM" ;; 
                128) echo "Possible: SHA512" ;; 
                *) echo "Longueur non standard: $hash_len caractères" ;; 
            esac
            
            echo ""
            echo -e "${CYAN}Outils recommandés:${NC}"
            echo "hashid -m '$hash_input'"
            echo "hash-identifier"
            ;; 
            
        2) # John The Ripper
            echo -e "${YELLOW}💥 John The Ripper Commands:${NC}"
            echo ""
            echo -e "${CYAN}Hash cracking basique:${NC}"
            echo "john --wordlist=/usr/share/wordlists/rockyou.txt hashes.txt"
            echo ""
            echo -e "${CYAN}Avec règles:${NC}"
            echo "john --wordlist=/usr/share/wordlists/rockyou.txt --rules hashes.txt"
            echo ""
            echo -e "${CYAN}Mode incrémental:${NC}"
            echo "john --incremental hashes.txt"
            echo ""
            echo -e "${CYAN}Format spécifique:${NC}"
            echo "john --format=NT hashes.txt"
            echo "john --format=md5crypt hashes.txt"
            echo ""
            echo -e "${CYAN}Afficher résultats:${NC}"
            echo "john --show hashes.txt"
            ;; 
            
        3) # Hashcat
            echo -e "${YELLOW}🌈 Hashcat Commands:${NC}"
            echo ""
            echo -e "${CYAN}Modes courants:${NC}"
            echo "0     - MD5"
            echo "100   - SHA1"
            echo "1400  - SHA256"
            echo "1700  - SHA512"
            echo "1000  - NTLM"
            echo "3200  - bcrypt"
            echo ""
            echo -e "${CYAN}Attaque dictionnaire:${NC}"
            echo "hashcat -m 0 -a 0 hashes.txt /usr/share/wordlists/rockyou.txt"
            echo ""
            echo -e "${CYAN}Attaque par masque:${NC}"
            echo "hashcat -m 0 -a 3 hashes.txt ?d?d?d?d?d?d"
            echo ""
            echo -e "${CYAN}Avec règles:${NC}"
            echo "hashcat -m 0 -a 0 hashes.txt rockyou.txt -r /usr/share/hashcat/rules/best64.rule"
            ;; 
            
        4) # Wordlists
            echo -e "${YELLOW}📚 Custom Wordlists:${NC}"
            echo ""
            echo -e "${CYAN}Générer wordlist avec crunch:${NC}"
            echo "crunch 8 12 abcdefghijklmnopqrstuvwxyz0123456789 -o wordlist.txt"
            echo ""
            echo -e "${CYAN}CeWL - Web wordlist:${NC}"
            echo "cewl https://example.com -w wordlist.txt"
            echo ""
            echo -e "${CYAN}Wordlists communes:${NC}"
            echo "/usr/share/wordlists/rockyou.txt"
            echo "/usr/share/wordlists/fasttrack.txt"
            echo "/usr/share/seclists/"
            echo ""
            echo -e "${CYAN}Combo wordlists:${NC}"
            echo "cat wordlist1.txt wordlist2.txt | sort | uniq > combined.txt"
            ;; 
            
        5) # Password Generation
            echo -e "${YELLOW}🔐 Password Generation:${NC}"
            echo ""
            echo -e "${CYAN}Passwords aléatoires:${NC}"
            echo "pwgen -s 12 10  # 10 passwords de 12 chars"
            echo ""
            echo -e "${CYAN}OpenSSL random:${NC}"
            echo "openssl rand -base64 12"
            echo ""
            echo -e "${CYAN}Avec caractères spéciaux:${NC}"
            echo "tr -cd '[:alnum:]._-' < /dev/urandom | fold -w12 | head -10"
            ;; 
    esac
    
    read -r -p "Appuyez sur Entrée..."
}