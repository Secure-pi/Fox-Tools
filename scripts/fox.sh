#!/usr/bin/env bash

# --- CONFIGURATION DE LA ROBUSTESSE DU SCRIPT ---
# set -e: Quitte immédiatement si une commande échoue.
# set -u: Traite les variables non définies comme une erreur.
# set -o pipefail: La valeur de retour d'un pipeline est celle de la dernière commande ayant échoué.
set -euo pipefail

#
# 🦊 Fox V2.0 - Point d'entrée principal
# Ce script initialise l'environnement et lance le menu principal de l'application.
#

# --- CHARGEMENT DE LA BIBLIOTHÈQUE ---

# Détermine le répertoire du script pour pouvoir sourcer les autres fichiers de manière fiable
# Ce bloc robuste résout les liens symboliques pour trouver le chemin réel du script.
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the symlink's path
done
SCRIPT_DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
LIB_DIR="${SCRIPT_DIR}/fox_lib"

# Boucle pour sourcer tous les fichiers .sh dans le répertoire de la bibliothèque.
# Cela rend toutes les fonctions de la bibliothèque disponibles dans ce script.
for lib_file in "${LIB_DIR}"/*.sh; do
    if [ -f "$lib_file" ]; then
        # shellcheck source=./scripts/fox_lib/core.sh
        source "$lib_file"
    fi
done

# --- FONCTION PRINCIPALE ---

main() {
    # Lancer la détection du matériel spécialisé (SDR, Flipper, etc.)
    initialize_hardware_detection

    # Charger la configuration utilisateur depuis ~/.pihackrc (si elle existe)
    load_config

    # Vérifier les mises à jour du script si l'option est activée dans la config
    if [[ "${PIHACK_AUTO_UPDATE:-false}" == "true" ]]; then
        check_updates
    fi

    # Mettre à jour les outils si l'option est activée
    if [[ "${PIHACK_TOOLS_AUTO_UPDATE:-true}" == "true" ]]; then
        update_all_tools
    fi

    # Configurer le projet/cible pour cette session
    setup_target

    # Sélectionner une stratégie de scan (discret, normal, agressif)
    select_strategy

    # Démarrer le menu principal ou l'installeur d'outils au premier lancement
    # Utilise un fichier dans le répertoire de l'utilisateur pour plus de persistance
    if [[ ! -f "$HOME/.pihack_tools_checked" ]]; then
        echo -e "${YELLOW}🔧 Premier lancement - Vérification des outils requis...${NC}"
        auto_install_tools
    else
        main_menu
    fi
}

# --- GESTION DES ARGUMENTS DE LA LIGNE DE COMMANDE ---

# Affiche l'aide et quitte
usage() {
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  -h, --help    Affiche ce message d'aide."
    echo "  --pro         Lance directement le menu des fonctionnalités PRO."
    echo "  --clean       Lance directement le nettoyeur de système."
    exit 0
}

# Boucle pour analyser les arguments passés au script
if [[ $# -gt 0 ]]; then
    case "$1" in
        -h|--help)
            usage
            ;;
        --pro)
            pro_menu
            ;;
        --clean)
            turbo_system_cleaner
            ;;
        matrix)
            secret_menu "konami"
            ;;
        *)
            echo "Argument non reconnu: $1"
            usage
            ;;
    esac
else
    # Si aucun argument n'est passé, lancer le fluxo normal
    main
fi