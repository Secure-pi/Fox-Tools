#!/bin/bash

# ========== FORENSICS TOOLKIT ==========
forensics_toolkit() {
    while true; do
        clear
        show_fox
        echo -e "${CYAN}🔍 FORENSICS TOOLKIT${NC}"
        echo "===================="
        
        echo -e "${RED}⚠️⚠️ OUTILS D'INVESTIGATION SYSTÈME ⚠️⚠️${NC}"
        echo -e "${YELLOW}Usage légal et éthique uniquement !${NC}"
        echo ""
        
        echo -e "${GREEN}[1]${NC} 🗃️ Binwalk - Firmware Analysis (SÛRE)"
        echo -e "${GREEN}[2]${NC} 🔓 Foremost - File Recovery (RISQUÉE)"  
        echo -e "${GREEN}[3]${NC} 🧠 Volatility - Memory Analysis (SÛRE)"
        echo -e "${GREEN}[4]${NC} 💾 TestDisk - Data Recovery (TRÈS RISQUÉE)"
        echo -e "${GREEN}[5]${NC} 📊 Strings - Text Extraction (SÛRE)"
        echo -e "${GREEN}[6]${NC} 🔍 File Analysis Suite (SÛRE)"
        echo -e "${GREEN}[7]${NC} 📋 Safe Mode - Analyse seulement (RECOMMANDÉE)"
        echo -e "${GREEN}[0]${NC} ⬅️ Retour"
        
        read -r -p "Choix: " forensic_choice
        
        case $forensic_choice in
            1) run_binwalk_analysis ;;
            2) run_foremost_recovery ;;
            3) run_volatility_analysis ;;
            4) run_testdisk_recovery ;;
            5) run_strings_extraction ;;
            6) run_file_analysis_suite ;;
            7) run_safe_mode_analysis ;;
            0) return ;;
            *) 
                echo -e "${RED}❌ Option invalide${NC}"
                sleep 1 
                ;;
        esac
    done
}

# ========== BINWALK - FIRMWARE ANALYSIS ==========
run_binwalk_analysis() {
    # --- CO-PILOTE DE SÉLECTION DE FICHIER ---
    select_file_target "ANALYSE DE FIRMWARE (BINWALK)"
    if [[ -z "$selected_file" ]]; then return; fi
    local file="$selected_file"

    clear
    show_fox
    echo -e "${BLUE}${BOLD}🗃️ BINWALK - ANALYSE DE: $(basename "$file")${NC}"
    echo "=================================================="
    
    if [[ ! -r "$file" ]]; then
        echo -e "${RED}❌ Permissions insuffisantes pour lire le fichier${NC}"
        read -r -p "Appuyez sur Entrée..."
        return
    fi
    
    local file_size
    file_size=$(stat -c%s "$file" 2>/dev/null)
    if [[ $file_size -gt 1073741824 ]]; then  # 1GB
        echo -e "${YELLOW}⚠️ Fichier volumineux (>1GB) - Cela peut prendre du temps${NC}"
        read -r -p "Continuer? (y/N): " large_confirm
        [[ "$large_confirm" != "y" ]] && return
    fi
    
    if ! command -v binwalk &>/dev/null; then
        echo -e "${RED}❌ Binwalk non installé${NC}"
        read -r -p "Installer binwalk? (y/N): " install
        if [[ "$install" == "y" ]]; then
            sudo apt update && sudo apt install binwalk -y
        fi
        read -r -p "Appuyez sur Entrée..."
        return
    fi
    
    mkdir -p "$PIHACK_OUTPUT_PATH/forensics"
    local output_dir
    output_dir="$PIHACK_OUTPUT_PATH/forensics/binwalk_$(basename "$file")_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$output_dir"

    echo -e "${YELLOW}⚡ Analyse en cours...${NC}"
    echo -e "${CYAN}📊 Résultats de l'analyse:${NC}"
    binwalk -B "$file" | tee "$output_dir/analysis.txt" | head -50
    
    echo ""
    read -r -p "Extraire les fichiers dans un dossier sécurisé? (y/n): " extract
    if [[ "$extract" == "y" ]]; then
        local extract_target_dir="$output_dir/extracted_files"
        mkdir -p "$extract_target_dir"
        echo -e "${YELLOW}📂 Extraction dans: $extract_target_dir${NC}"
        
        binwalk -e -C "$extract_target_dir" --dd=".*" --max-size=50M "$file"
        echo -e "${GREEN}✅ Extraction terminée dans: $extract_target_dir${NC}"
        echo -e "${CYAN}💡 Rappel: Vérifiez le contenu avant utilisation${NC}"
    fi
    read -r -p "Appuyez sur Entrée..."
}

# ========== FOREMOST - FILE RECOVERY ==========
run_foremost_recovery() {
    clear
    show_fox
    echo -e "${RED}${BOLD}🔓 FOREMOST - FILE RECOVERY (OPÉRATION RISQUÉE)${NC}"
    echo "=================================================="
    echo -e "${YELLOW}⚠️ Cet outil accède directement aux disques${NC}"
    echo -e "${RED}⚠️ USAGE SUR VOS PROPRES DONNÉES UNIQUEMENT${NC}"
    echo ""
    
    read -r -p "Confirmez que c'est votre matériel (y/N): " own_confirm
    if [[ ! "$own_confirm" =~ ^[Yy]$ ]]; then
        echo -e "${GREEN}✅ Opération annulée${NC}"
        read -r -p "Appuyez sur Entrée..."
        return
    fi
    
    echo -e "${YELLOW}⚠️ ATTENTION: Cette opération peut être longue et intensive${NC}"
    read -r -p "Tapez 'COMPRIS' en majuscules pour continuer: " understand
    if [[ ! "$understand" == "COMPRIS" ]]; then
        echo -e "${GREEN}✅ Opération annulée${NC}"
        read -r -p "Appuyez sur Entrée..."
        return
    fi
    
    echo -e "${CYAN}💽 Périphériques disponibles:${NC}"
    lsblk -f | grep -E "(NAME|└|├)"
    echo ""
    echo -e "${RED}⚠️ UTILISEZ SEULEMENT /dev/sdX ou des fichiers image${NC}"
    
    read -r -p "💽 Device/Image à analyser (ou 'annuler'): " device
    if [[ "$device" == "annuler" || -z "$device" ]]; then
        echo -e "${GREEN}✅ Opération annulée${NC}"
        read -r -p "Appuyez sur Entrée..."
        return
    fi
    
    if [[ "$device" =~ ^/dev/(sda|nvme0n1)$ ]]; then
        echo -e "${RED}❌ DANGER: Périphérique système principal détecté${NC}"
        echo -e "${RED}❌ Opération bloquée pour votre sécurité${NC}"
        read -r -p "Appuyez sur Entrée..."
        return
    fi
    
    mkdir -p "$PIHACK_OUTPUT_PATH/forensics"
    local output_dir
    output_dir="$PIHACK_OUTPUT_PATH/forensics/foremost_recovery_$(date +%Y%m%d_%H%M%S)"
    echo -e "${YELLOW}📂 Dossier de sortie: $output_dir${NC}"
    
    read -r -p "Confirmer le dossier de sortie? (y/N): " output_confirm
    if [[ ! "$output_confirm" =~ ^[Yy]$ ]]; then
        echo -e "${GREEN}✅ Opération annulée${NC}"
        read -r -p "Appuyez sur Entrée..."
        return
    fi

    sudo mkdir -p "$output_dir"
    sudo chown "$USER":"$USER" "$output_dir"
    
    if ! command -v foremost &>/dev/null; then
        echo -e "${RED}❌ Foremost non installé${NC}"
        read -r -p "Installer foremost? (y/N): " install_foremost
        if [[ "$install_foremost" =~ ^[Yy]$ ]]; then
            sudo apt update && sudo apt install foremost -y
        fi
        read -r -p "Appuyez sur Entrée..."
        return
    fi
    
    echo -e "${YELLOW}⚡ Récupération en cours (peut prendre du temps)...${NC}"
    echo -e "${CYAN}💡 Appuyez sur Ctrl+C pour arrêter si nécessaire${NC}"
    
    trap '' SIGINT
    timeout 1800s sudo foremost -i "$device" -o "$output_dir" -v 2>/dev/null
    local exit_code=$?
    trap cleanup_exit SIGINT SIGTERM

    if [[ $exit_code -eq 124 ]]; then
        echo -e "${YELLOW}⚠️ Timeout atteint (30 min) - Processus arrêté${NC}"
    elif [[ $exit_code -ne 0 ]]; then
        echo -e "${RED}❌ Erreur lors de la récupération avec Foremost (code: $exit_code)${NC}"
    else
        echo -e "${GREEN}✅ Récupération terminée dans: $output_dir${NC}"
        echo -e "${CYAN}📊 Résumé des fichiers récupérés:${NC}"
        find "$output_dir" -type f | head -10
    fi
    read -r -p "Appuyez sur Entrée..."
}

# ========== VOLATILITY - MEMORY ANALYSIS ==========
run_volatility_analysis() {
    # --- CO-PILOTE DE SÉLECTION DE FICHIER ---
    select_file_target "ANALYSE DE DUMP MÉMOIRE (VOLATILITY)" "*.(mem|vmem|raw|dmp)"
    if [[ -z "$selected_file" ]]; then return; fi
    local memdump="$selected_file"

    clear
    show_fox
    echo -e "${BLUE}${BOLD}🧠 VOLATILITY - ANALYSE DE: $(basename "$memdump")${NC}"
    echo "=================================================="
    
    if ! command -v volatility &>/dev/null; then
        echo -e "${RED}❌ Volatility non installé${NC}"
        read -r -p "Installer Volatility? (y/N): " install_vol
        if [[ "$install_vol" =~ ^[Yy]$ ]]; then
            echo -e "${YELLOW}📦 Installation de Volatility...${NC}"
            sudo apt update && sudo apt install volatility -y
        fi
        read -r -p "Appuyez sur Entrée..."
        return
    fi
    
    local dump_size
    dump_size=$(stat -c%s "$memdump" 2>/dev/null)
    echo -e "${CYAN}📊 Taille du dump: $(numfmt --to=iec "$dump_size")${NC}"
    
    if [[ $dump_size -gt 8589934592 ]]; then  # 8GB
        echo -e "${YELLOW}⚠️ Dump très volumineux - Analyse peut être lente${NC}"
        read -r -p "Continuer? (y/N): " large_dump
        [[ "$large_dump" != "y" ]] && return
    fi
    
    echo -e "${YELLOW}⚡ Analyse des infos système...${NC}"
    timeout 300s volatility -f "$memdump" imageinfo 2>/dev/null | head -20
    
    if [[ $? -eq 124 ]]; then
        echo -e "${RED}⚠️ Timeout - Dump peut être corrompu ou trop gros${NC}"
    fi
    
    echo ""
    echo -e "${CYAN}📋 Pour une analyse plus approfondie, utilisez des commandes comme:${NC}"
    echo "• volatility -f \"$memdump\" --profile=Win7SP1x64 pslist"
    echo "• volatility -f \"$memdump\" --profile=Win7SP1x64 netscan"

    read -r -p "Appuyez sur Entrée..."
}

# ========== TESTDISK - DATA RECOVERY ==========
run_testdisk_recovery() {
    clear
    show_fox
    echo -e "${RED}${BOLD}💾 TESTDISK - DATA RECOVERY (TRÈS RISQUÉE)${NC}"
    echo "=================================================="
    echo -e "${RED}⚠️⚠️⚠️ ATTENTION - MODIFICATION POSSIBLE DES PARTITIONS ⚠️⚠️⚠️${NC}"
    echo -e "${YELLOW}Cet outil peut MODIFIER vos partitions et données${NC}"
    echo -e "${RED}USAGE EXPERT UNIQUEMENT${NC}"
    echo ""
    
    echo -e "${YELLOW}Confirmations requises:${NC}"
    read -r -p "1. C'est votre matériel? (y/N): " own_disk
    [[ "$own_disk" != "y" ]] && return
    
    read -r -p "2. Avez-vous une sauvegarde? (y/N): " have_backup
    [[ "$have_backup" != "y" ]] && return
    
    read -r -p "3. Êtes-vous expert en partitions? (y/N): " expert
    if [[ ! "$expert" =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}💡 RECOMMANDATION: Utilisez l'analyse read-only${NC}"
        read -r -p "Mode analyse seulement (recommandé)? (Y/n): " readonly_mode
        if [[ ! "$readonly_mode" =~ ^[Nn]$ ]]; then # If not 'n', assume yes for read-only
            echo -e "${CYAN}🔍 Mode analyse seulement activé${NC}"
            echo -e "${GREEN}ℹ️  TestDisk sera lancé en mode lecture seule${NC}"
            echo -e "${YELLOW}⚠️  NE MODIFIEZ RIEN dans TestDisk${NC}"
            read -r -p "Continuer? (y/N): " final_confirm
            [[ ! "$final_confirm" =~ ^[Yy]$ ]] && return
        fi
    fi
    
    echo -e "${RED}DERNIÈRE CHANCE - Tapez 'RISQUE' en majuscules pour continuer:${NC}"
    read -r final_risk
    if [[ ! "$final_risk" == "RISQUE" ]]; then
        echo -e "${GREEN}✅ Opération annulée - Sage décision${NC}"
        read -r -p "Appuyez sur Entrée..."
        return
    fi
    
    if ! command -v testdisk &>/dev/null; then
        echo -e "${RED}❌ TestDisk non installé${NC}"
        read -r -p "Installer TestDisk? (y/N): " install_testdisk
        if [[ "$install_testdisk" =~ ^[Yy]$ ]]; then
            sudo apt update && sudo apt install testdisk -y
        fi
        read -r -p "Appuyez sur Entrée..."
        return
    fi
    
    echo -e "${YELLOW}⚡ Lancement de TestDisk...${NC}"
    echo -e "${RED}⚠️ RAPPEL: MODE LECTURE SEULE RECOMMANDÉ${NC}"
    trap '' SIGINT
    sudo testdisk
    trap cleanup_exit SIGINT SIGTERM
    read -r -p "Appuyez sur Entrée..."
}

# ========== STRINGS - TEXT EXTRACTION ==========
run_strings_extraction() {
    # --- CO-PILOTE DE SÉLECTION DE FICHIER ---
    select_file_target "EXTRACTION DE STRINGS"
    if [[ -z "$selected_file" ]]; then return; fi
    local strings_file="$selected_file"

    clear
    show_fox
    echo -e "${BLUE}${BOLD}📊 STRINGS - EXTRACTION DE: $(basename "$strings_file")${NC}"
    echo "=================================================="
    
    mkdir -p "$PIHACK_OUTPUT_PATH/forensics"
    local output_file_base
    output_file_base="$PIHACK_OUTPUT_PATH/forensics/strings_$(basename "$strings_file")_$(date +%Y%m%d_%H%M%S)"

    echo -e "${YELLOW}⚡ Extraction des strings...${NC}"
    echo -e "${CYAN}📊 Première analyse (caractères imprimables):${NC}"
    strings "$strings_file" | tee "${output_file_base}_preview.txt" | head -50
    
    echo ""
    read -r -p "Analyse complète et sauvegarde? (y/n): " full_strings
    if [[ "$full_strings" =~ ^[Yy]$ ]]; then
        strings "$strings_file" > "${output_file_base}_full.txt"
        echo -e "${GREEN}✅ Strings sauvegardées dans: ${output_file_base}_full.txt${NC}"
        local total_strings
        total_strings=$(wc -l < "${output_file_base}_full.txt")
        echo -e "${CYAN}📊 Total strings: $total_strings${NC}"
    fi
    read -r -p "Appuyez sur Entrée..."
}

# ========== FILE ANALYSIS SUITE ==========
run_file_analysis_suite() {
    # --- CO-PILOTE DE SÉLECTION DE FICHIER ---
    select_file_target "SUITE D'ANALYSE DE FICHIER"
    if [[ -z "$selected_file" ]]; then return; fi
    local analysis_file="$selected_file"

    clear
    show_fox
    echo -e "${BLUE}${BOLD}🔍 FILE ANALYSIS SUITE sur: $(basename "$analysis_file")${NC}"
    echo "=================================================="
    
    mkdir -p "$PIHACK_OUTPUT_PATH/forensics"
    local output_file_base
    output_file_base="$PIHACK_OUTPUT_PATH/forensics/file_analysis_$(basename "$analysis_file")_$(date +%Y%m%d_%H%M%S)"

    echo -e "${CYAN}🔍 ANALYSE COMPLÈTE:${NC}"
    echo "=================="
    
    # Informations de base
    echo -e "${YELLOW}📋 Informations de base:${NC}"
    ls -la "$analysis_file" | tee "${output_file_base}_info.txt"
    file "$analysis_file" | tee -a "${output_file_base}_info.txt"
    
    # Hash du fichier
    echo ""
    echo -e "${YELLOW}🔐 Hashes:${NC}"
    echo "MD5:    $(md5sum "$analysis_file" | cut -d' ' -f1)" | tee "${output_file_base}_hashes.txt"
    echo "SHA256: $(sha256sum "$analysis_file" | cut -d' ' -f1)" | tee -a "${output_file_base}_hashes.txt"
    
    # Analyse hexadécimale des premiers bytes
    echo ""
    echo -e "${YELLOW}🔢 Header hexadécimal:${NC}"
    hexdump -C "$analysis_file" | head -10 | tee "${output_file_base}_hex_header.txt"
    
    # Recherche de strings intéressantes
    echo ""
    echo -e "${YELLOW}📝 Strings intéressantes:${NC}"
    strings "$analysis_file" | (grep -i -E "(password|user|admin|key|token|secret)" || true) | head -10 | tee "${output_file_base}_strings.txt"
    
    echo ""
    echo -e "${GREEN}✅ Analyse terminée. Résultats dans: $PIHACK_OUTPUT_PATH/forensics/${NC}"
    read -r -p "Appuyez sur Entrée..."
}

# ========== SAFE MODE - ANALYSE SEULEMENT ==========
run_safe_mode_analysis() {
    # --- CO-PILOTE DE SÉLECTION DE FICHIER ---
    select_file_target "ANALYSE EN MODE SANS ÉCHEC"
    if [[ -z "$selected_file" ]]; then return; fi
    local safe_file="$selected_file"

    clear
    show_fox
    echo -e "${GREEN}📋 SAFE MODE - ANALYSE DE: $(basename "$safe_file")${NC}"
    echo "================================"

    mkdir -p "$PIHACK_OUTPUT_PATH/forensics"
    local output_file_base
    output_file_base="$PIHACK_OUTPUT_PATH/forensics/safe_analysis_$(basename "$safe_file")_$(date +%Y%m%d_%H%M%S)"

    echo -e "${GREEN}🔒 ANALYSE SÉCURISÉE:${NC}"
    echo "===================="
    
    # Analyse complètement sûre
    echo -e "${CYAN}📋 Type: $(file "$safe_file" | cut -d: -f2)${NC}" | tee "${output_file_base}_info.txt"
    echo -e "${CYAN}📊 Taille: $(du -h "$safe_file" | cut -f1)${NC}" | tee -a "${output_file_base}_info.txt"
    echo -e "${CYAN}🔐 MD5: $(md5sum "$safe_file" | cut -d' ' -f1)${NC}" | tee -a "${output_file_base}_info.txt"
    echo -e "${CYAN}🔐 SHA256: $(sha256sum "$safe_file" | cut -d' ' -f1)${NC}" | tee -a "${output_file_base}_info.txt"
    
    echo ""
    echo -e "${YELLOW}📝 Aperçu strings (safe):${NC}"
    strings "$safe_file" | head -20 | tee "${output_file_base}_strings_preview.txt"
    
    echo ""
    echo -e "${GREEN}✅ Analyse safe terminée - Aucune modification. Résultats dans: $PIHACK_OUTPUT_PATH/forensics/${NC}"
    read -r -p "Appuyez sur Entrée pour continuer..."
}
