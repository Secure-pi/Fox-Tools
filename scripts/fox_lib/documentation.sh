#!/bin/bash

documentation_menu() {
    local docs_dir="$SCRIPT_DIR/../docs"
    while true; do
        clear
        show_fox
        echo -e "${BLUE}${BOLD}📄 DOCUMENTATION 📄${NC}"
        echo "=================================================="
        echo -e "${CYAN}Choisissez un document à lire:${NC}"
        
        # Read files into an array
        mapfile -t doc_files < <(find "$docs_dir" -maxdepth 2 -type f -name '*.md' | sort)

        if [ ${#doc_files[@]} -eq 0 ]; then
            echo -e "${YELLOW}Aucun document trouvé.${NC}"
            sleep 2
            return
        fi

        # Display menu from array
        for i in "${!doc_files[@]}"; do
            local filename
            # Make path relative for display
            filename=$(realpath --relative-to="$docs_dir" "${doc_files[$i]}")
            echo -e "${GREEN}[$((i+1))]${NC}  $filename"
        done

        local open_folder_option=$(( ${#doc_files[@]} + 1 ))
        echo ""
        echo -e "${GREEN}[$open_folder_option]${NC}  Ouvrir le dossier des documents"
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

        if [[ "$choice" -eq "$open_folder_option" ]]; then
            # Check for xdg-open
            if command -v xdg-open &> /dev/null; then
                xdg-open "$docs_dir"
            else
                echo -e "${RED}❌ La commande xdg-open n'est pas disponible pour ouvrir le dossier.${NC}"
                sleep 2
            fi
            continue
        fi

        # Convert to zero-based index
        local index=$((choice - 1))

        if [[ "$index" -ge 0 && "$index" -lt ${#doc_files[@]} ]]; then
            local file_to_show="${doc_files[$index]}"
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
