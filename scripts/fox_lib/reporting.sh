#!/bin/bash

reporting_menu() {
    while true; do
        clear
        show_fox
        echo -e "${BLUE}${BOLD}📊 REPORTING 📊${NC}"
        echo "=================================================="
        echo -e "${GREEN}[1]${NC}  📝 Generate Markdown Report"
        echo -e "${GREEN}[2]${NC}  👀 View Last Report"
        echo ""
        echo -e "${RED}[0]${NC}  ⬅️  Retour au menu principal"
        echo ""
        echo -n -e "${YELLOW}Choisissez une option: ${NC}"
        
        read -r choice
        
        case $choice in
            1) generate_markdown_report ;;
            2) view_last_report ;;
            0) return ;;
            *) 
                echo -e "${RED}❌ Option invalide !${NC}"
                sleep 1
                ;;
        esac
    done
}

generate_markdown_report() {
    if [[ -z "$PIHACK_OUTPUT_PATH" ]]; then
        echo -e "${RED}❌ Aucun projet actif.${NC}"; sleep 2; return
    fi

    clear
    show_fox
    echo -e "${BLUE}${BOLD}📝 GENERATE MARKDOWN REPORT${NC}"
    echo "=================================================="
    
    local report_file
    report_file="$PIHACK_OUTPUT_PATH/report_${TARGET_NAME}_$(date +%Y%m%d).md"
    
    # --- REPORT HEADER ---
    {
        echo "# Pentest Report for: ${TARGET_NAME}"
        echo ""
        echo "**Date:** $(date)"
        echo "**Target IP:** ${TARGET_IP}"
        echo ""
        echo "--- "
        echo ""
    } > "$report_file"

    echo -e "${YELLOW}Génération du rapport pour ${TARGET_NAME}...${NC}"

    # --- Function to add a section ---
    add_report_section() {
        local title=$1
        local directory=$2
        
        # Check if directory exists and is not empty
        if [ -d "$directory" ] && [ -n "$(ls -A "$directory")" ]; then
            echo "## $title" >> "$report_file"
            echo "" >> "$report_file"
            
            for file in "$directory"/*;
            do
                if [ -f "$file" ]; then
                    echo "### Results from: $(basename "$file")" >> "$report_file"
                    echo "" >> "$report_file"
                    echo '```' >> "$report_file"
                    # Add a head limit to avoid huge files overwhelming the report
                    head -n 100 "$file" >> "$report_file"
                    echo "" >> "$report_file"
                    echo '```' >> "$report_file"
                    echo "" >> "$report_file"
                fi
            done
        fi
    }

    # --- GENERATE SECTIONS ---
    add_report_section "OSINT Results" "$PIHACK_OUTPUT_PATH/osint"
    add_report_section "Network Scans" "$PIHACK_OUTPUT_PATH/scans"
    add_report_section "Web Application Analysis" "$PIHACK_OUTPUT_PATH/web"
    add_report_section "Exploits & Payloads" "$PIHACK_OUTPUT_PATH/exploits"

    echo ""
    echo -e "${GREEN}✅ Rapport Markdown généré: $report_file${NC}"
    echo -e "${YELLOW}💡 Vous pouvez le convertir en PDF avec pandoc:${NC}"
    echo -e "${CYAN}pandoc \"$report_file\" -o report.pdf${NC}"
    read -r -p $'
Appuyez sur Entrée pour continuer...'
}

view_last_report() {
    clear
    show_fox
    echo -e "${BLUE}${BOLD}👀 VIEW LAST REPORT${NC}"
    echo "=================================================="
    
    local last_report
    last_report=$(find "$PIHACK_OUTPUT_PATH" -name 'report_*.md' -print0 | xargs -0 ls -t | head -1)
    
    if [[ -z "$last_report" ]]; then
        echo -e "${RED}❌ Aucun rapport trouvé !${NC}"
        sleep 2
        return
    fi
    
    echo -e "${YELLOW}Affichage de: $last_report${NC}"
    echo -e "${CYAN}(Utilisez les flèches pour naviguer, 'q' pour quitter)${NC}"
    sleep 2
    less "$last_report"
}
