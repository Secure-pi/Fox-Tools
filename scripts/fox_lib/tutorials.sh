#!/bin/bash

tutorials_menu() {
    while true; do
        clear
        show_fox
        echo -e "${BLUE}${BOLD}📚 TUTORIALS 📚${NC}"
        echo "=================================================="
        echo -e "${CYAN}Choisissez un tutoriel:${NC}"
        
        # Read files into an array
        mapfile -t tutorial_files < <(find "$SCRIPT_DIR/tutorials" -maxdepth 1 -type f -name '*.md' | sort)

        if [ ${#tutorial_files[@]} -eq 0 ]; then
            echo -e "${YELLOW}Aucun tutoriel trouvé.${NC}"
            sleep 2
            return
        fi

        # Display menu from array
        for i in "${!tutorial_files[@]}"; do
            local filename
            filename=$(basename "${tutorial_files[$i]}" .md)
            echo -e "${GREEN}[$((i+1))]${NC}  $filename"
        done

        echo ""
        echo -e "${RED}[0]${NC}  ⬅️  Retour au menu principal"
        echo ""
        echo -n -e "${YELLOW}Choisissez une option: ${NC}"
        
        read -r choice

        # Validate input
        if ! [[ "$choice" =~ ^[0-9]+$ ]]; then
            echo -e "${RED}❌ Option invalide ! Ce n'est pas un nombre.${NC}"
            sleep 1
            continue
        fi

        if [[ "$choice" -eq 0 ]]; then
            return
        fi

        # Convert to zero-based index
        local index=$((choice - 1))

        if [[ "$index" -ge 0 && "$index" -lt ${#tutorial_files[@]} ]]; then
            local file_to_show="${tutorial_files[$index]}"
            clear
            echo -e "${CYAN}Affichage de: $(basename "$file_to_show")${NC}"
            echo -e "${YELLOW}(Utilisez les flèches pour naviguer, appuyez sur 'q' pour quitter)${NC}"
            sleep 1
            less "$file_to_show"
        else
            echo -e "${RED}❌ Option invalide !${NC}"
            sleep 1
        fi
    done
}
