#!/bin/bash

system_menu() {
    while true; do
        clear
        show_fox
        echo -e "${BLUE}${BOLD}⚙️ SYSTEM & UTILITIES ⚙️${NC}"
        echo "=================================================="
        echo -e "${GREEN}[1]${NC}  🧹 System Cleanup"
        echo -e "${GREEN}[2]${NC}  📊 System Monitor"
        echo -e "${GREEN}[3]${NC}  🔄 Update All Tools"
        echo -e "${GREEN}[4]${NC}  📋 System Information"
        echo ""
        echo -e "${RED}[0]${NC}  ⬅️  Retour au menu principal"
        echo ""
        echo -n -e "${YELLOW}Choisissez une option: ${NC}"
        
        read -r choice
        
        case $choice in
            1) turbo_system_cleaner ;;
            2) system_monitor ;;
            3) update_all_tools ;;
            4) system_info ;;
            0) return ;;
            *) 
                echo -e "${RED}❌ Option invalide !${NC}"
                sleep 1
                ;;
        esac
    done
}

system_monitor() {
    clear
    show_fox
    echo -e "${BLUE}${BOLD}📊 SYSTEM MONITOR${NC}"
    echo "=================================================="
    echo -e "${CYAN}Appuyez sur 'q' pour quitter top.${NC}"
    sleep 1
    trap '' SIGINT
    top
    trap cleanup_exit SIGINT SIGTERM
}

update_all_tools() {
    clear
    show_fox
    echo -e "${BLUE}${BOLD}🔄 UPDATE ALL TOOLS${NC}"
    echo "=================================================="
    echo -e "${YELLOW}Mise à jour des paquets système (apt)...${NC}"
    sudo apt update && sudo apt upgrade -y
    echo -e "${GREEN}✅ Mise à jour APT terminée.${NC}"
    echo ""

    echo -e "${YELLOW}Mise à jour des outils clonés (git)...${NC}"
    local tools_dir="$SCRIPT_DIR/../tools"
    for tool_dir in "$tools_dir"/*/; do
        if [ -d "$tool_dir/.git" ]; then
            local tool_name
            tool_name=$(basename "$tool_dir")
            echo -e "${CYAN}Mise à jour de $tool_name...${NC}"
            (cd "$tool_dir" && git pull)
            echo ""
        fi
    done
    echo -e "${GREEN}✅ Mise à jour des outils Git terminée.${NC}"

}

system_info() {
    clear
    show_fox
    echo -e "${BLUE}${BOLD}📋 SYSTEM INFORMATION${NC}"
    echo "=================================================="
    local output_file
    output_file="$PIHACK_OUTPUT_PATH/system/system_info_$(date +%Y%m%d_%H%M%S).txt"
    mkdir -p "$PIHACK_OUTPUT_PATH/system"

    { 
        echo -e "${CYAN}Kernel:${NC} $(uname -r)"
        echo -e "${CYAN}OS:${NC} $(uname -o)"
        echo -e "${CYAN}Architecture:${NC} $(uname -m)"
        echo -e "${CYAN}Uptime:${NC} $(uptime -p)"
        echo -e "${CYAN}CPU:${NC} $(grep "model name" /proc/cpuinfo | head -1 | cut -d ":" -f 2)"
        echo -e "${CYAN}Memory:${NC} $(free -h | grep Mem | awk '{print $2}')"
        echo -e "${CYAN}Disk:${NC} $(df -h / | tail -1 | awk '{print $2}')"
    } | tee "$output_file"

    echo -e "${GREEN}✅ Informations système sauvegardées dans: $output_file${NC}"
    read -r -p "Appuyez sur Entrée pour continuer..."
}

# 🧹 TURBO SYSTEM CLEANER (VERSION SÉCURISÉE)
turbo_system_cleaner() {
    clear
    show_fox
    echo -e "${CYAN}🧹 TURBO SYSTEM CLEANER${NC}"
    echo "========================"
    
    echo -e "${RED}⚠️⚠️⚠️ ATTENTION - NETTOYAGE SYSTÈME ⚠️⚠️⚠️${NC}"
    echo -e "${YELLOW}Cette action va supprimer:${NC}"
    echo -e "${RED}  ❌ Fichiers temporaires système${NC}"
    echo -e "${RED}  ❌ Caches navigateurs${NC}"
    echo -e "${RED}  ❌ Logs anciens${NC}"
    echo -e "${RED}  ❌ Packages orphelins${NC}"
    echo ""
    echo -e "${CYAN}📋 Actions potentiellement irréversibles !${NC}"
    echo ""
    
    read -r -p "Voulez-vous continuer? (y/N): " confirm1
    if [[ ! "$confirm1" =~ ^[Yy]$ ]]; then
        echo -e "${GREEN}✅ Nettoyage annulé${NC}"
        read -r -p "Appuyez sur Entrée..."
        return
    fi
    
    local before_space
    echo -e "${YELLOW}🔍 Analyse de l'espace disque...${NC}"
    df -h / | tail -1
    before_space=$(df / | tail -1 | awk '{print $4}')
    
    echo ""
    echo -e "${GREEN}[1]${NC} 🚀 Nettoyage TURBO complet (DANGEREUX)"
    echo -e "${GREEN}[2]${NC} 🎯 Nettoyage sélectif (RECOMMANDÉ)"
    echo -e "${GREEN}[3]${NC} 🗂️ Analyse seulement (SÛRE)"
    echo -e "${GREEN}[4]${NC} 📦 Nettoyage packages (MODÉRÉ)"
    
    read -r -p "Mode: " clean_mode
    
    case $clean_mode in
        1) 
            echo -e "${RED}🚨 MODE TURBO DANGEREUX SÉLECTIONNÉ 🚨${NC}"
            echo -e "${YELLOW}Ceci va supprimer de nombreux fichiers système${NC}"
            read -r -p "Tapez 'DANGER' en majuscules pour continuer: " danger_confirm
            if [[ ! "$danger_confirm" == "DANGER" ]]; then
                echo -e "${GREEN}✅ Nettoyage annulé${NC}"
                read -r -p "Appuyez sur Entrée..."
                return
            fi
            
            echo -e "${RED}DERNIÈRE CHANCE - Êtes-vous sûr ?${NC}"
            read -r -p "Tapez 'OUI' en majuscules: " final_confirm
            if [[ ! "$final_confirm" == "OUI" ]]; then
                echo -e "${GREEN}✅ Nettoyage annulé${NC}"
                read -r -p "Appuyez sur Entrée..."
                return
            fi
            
            echo -e "${RED}🚀 NETTOYAGE TURBO EN COURS...${NC}"
            echo -e "${YELLOW}💾 Création de sauvegarde...${NC}"
            
            sudo cp -r /etc/apt/sources.list* /tmp/backup_apt/ 2>/dev/null
            
            echo -e "${BLUE}[1/9]${NC} Cache APT..."
            sudo apt autoremove -y > /dev/null 2>&1 || echo "⚠️ Erreur APT"
            sudo apt autoclean -y > /dev/null 2>&1 || echo "⚠️ Erreur APT Clean"
            
            echo -e "${BLUE}[2/9]${NC} Logs anciens..."
            sudo journalctl --vacuum-time=7d > /dev/null 2>&1 || echo "⚠️ Erreur Logs"
            
            echo -e "${BLUE}[3/9]${NC} Cache thumbnails..."
            rm -rf ~/.cache/thumbnails/* 2>/dev/null || echo "⚠️ Erreur Thumbnails"
            
            echo -e "${BLUE}[4/9]${NC} Fichiers temporaires (SÉCURISÉ)..."
            find /tmp -maxdepth 1 -type f -mtime +1 -delete 2>/dev/null || echo "⚠️ Erreur Temp"
            find /var/tmp -maxdepth 1 -type f -mtime +1 -delete 2>/dev/null || echo "⚠️ Erreur VarTemp"
            
            echo -e "${BLUE}[5/9]${NC} Cache navigateurs..."
            rm -rf ~/.cache/google-chrome ~/.cache/firefox ~/.cache/chromium 2>/dev/null
            
            echo -e "${BLUE}[6/9]${NC} Corbeille..."
            rm -rf ~/.local/share/Trash/* 2>/dev/null
            
            echo -e "${BLUE}[7/9]${NC} Core dumps (SÉCURISÉ)..."
            if [[ -d "/var/crash" ]]; then
                find /var/crash -name "*.crash" -mtime +7 -delete 2>/dev/null
            fi
            
            echo -e "${BLUE}[8/9]${NC} Logs système (SÉCURISÉ)..."
            sudo find /var/log -name "*.log.*" -mtime +14 -delete 2>/dev/null
            
            echo -e "${BLUE}[9/9]${NC} Cache Python..."
            find ~/.cache -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null
            
            local after_space
            after_space=$(df / | tail -1 | awk '{print $4}')
            local freed_space
            freed_space=$(( (before_space - after_space) / 1024 )) # Convert to MB
            
            echo ""
            echo -e "${GREEN}✅ NETTOYAGE TERMINÉ!${NC}"
            echo -e "${CYAN}📊 Espace libéré: ${freed_space}MB${NC}"
            df -h / | tail -1
            ;;
            
        2)
            echo -e "${YELLOW}🎯 Nettoyage sélectif (SÛRE)${NC}"
            echo "Que voulez-vous nettoyer?"
            echo "[1] Cache navigateurs seulement (SÛRE)"
            echo "[2] Logs anciens seulement (SÛRE)" 
            echo "[3] Dossier Downloads ancien (SÛRE)"
            echo "[4] Cache utilisateur seulement (SÛRE)"
            read -r -p "Choix: " selective
            
            case $selective in
                1) 
                    echo -e "${BLUE}🌐 Nettoyage caches navigateurs...${NC}"
                    rm -rf ~/.cache/google-chrome/*/{Cache,Media*} 2>/dev/null
                    rm -rf ~/.cache/firefox/*/cache2 2>/dev/null
                    rm -rf ~/.cache/chromium/*/{Cache,Media*} 2>/dev/null
                    echo -e "${GREEN}✅ Caches navigateurs nettoyés${NC}"
                    ;;
                2) 
                    echo -e "${BLUE}📝 Nettoyage logs anciens...${NC}"
                    sudo journalctl --vacuum-time=30d > /dev/null 2>&1
                    echo -e "${GREEN}✅ Logs anciens supprimés (garde 30 jours)${NC}"
                    ;;
                3)
                    echo -e "${BLUE}📥 Analyse dossier Downloads...${NC}"
                    find ~/Downloads -type f -mtime +30 -ls | head -10
                    read -r -p "Supprimer fichiers +30 jours? (y/n): " del_confirm
                    if [[ "$del_confirm" =~ ^[Yy]$ ]]; then
                        find ~/Downloads -type f -mtime +30 -delete
                        echo -e "${GREEN}✅ Anciens téléchargements supprimés${NC}"
                    fi
                    ;;
                4)
                    echo -e "${BLUE}🗄️ Nettoyage cache utilisateur...${NC}"
                    rm -rf ~/.cache/thumbnails/* 2>/dev/null
                    rm -rf ~/.cache/pip/* 2>/dev/null
                    echo -e "${GREEN}✅ Cache utilisateur nettoyé${NC}"  
                    ;;
            esac
            ;;
            
        3)
            echo -e "${YELLOW}🗂️ ANALYSE SEULEMENT - AUCUNE SUPPRESSION${NC}"
            echo ""
            echo -e "${CYAN}📊 TOP 10 des plus gros dossiers:${NC}"
            du -sh /* 2>/dev/null | sort -hr | head -10
            echo ""
            echo -e "${CYAN}📂 TOP 10 des plus gros fichiers:${NC}"
            find / -type f -size +100M 2>/dev/null | head -10 | while read -r file; do
                local size
                size=$(du -h "$file" 2>/dev/null | cut -f1)
                echo -e "${YELLOW}$size${NC} $file"
            done
            echo ""
            echo -e "${CYAN}💽 Espace disque par partition:${NC}"
            df -h
            ;;
            
        4)
            echo -e "${YELLOW}📦 Nettoyage packages (MODÉRÉ)${NC}"
            echo -e "${RED}⚠️ Ceci peut supprimer des packages utiles${NC}"
            read -r -p "Continuer? (y/N): " pkg_confirm
            if [[ "$pkg_confirm" =~ ^[Yy]$ ]]; then
                echo -e "${BLUE}🔍 Analyse des packages orphelins...${NC}"
                if command -v deborphan > /dev/null; then
                    local orphans
                    orphans=$(deborphan)
                    if [[ -n "$orphans" ]]; then
                        echo "Packages orphelins trouvés:"
                        echo "$orphans"
                        read -r -p "Les supprimer? (y/n): " rm_orphans
                        if [[ "$rm_orphans" =~ ^[Yy]$ ]]; then
                            sudo apt remove --purge "$orphans" -y
                        fi
                    else
                        echo -e "${GREEN}✅ Aucun package orphelin${NC}"
                    fi
                else
                    echo -e "${BLUE}📦 Autoremove standard...${NC}"
                    sudo apt autoremove --purge -y
                fi
                echo -e "${GREEN}✅ Nettoyage packages terminé${NC}"
            fi
            ;;
    esac
    
    echo ""
    echo -e "${CYAN}💡 CONSEIL: Redémarrez si vous avez fait un nettoyage complet${NC}"
    read -r -p "Appuyez sur Entrée..."
}