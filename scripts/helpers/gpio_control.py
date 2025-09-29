#!/usr/bin/env python3

"""
Script de contrôle pour un commutateur RF HMC435 via les broches GPIO du Raspberry Pi.

Ce script permet de sélectionner la sortie A, la sortie B, ou d'éteindre les deux.
Il est conçu pour être appelé depuis un script shell.
"""

import sys

# Tenter d'importer la bibliothèque RPi.GPIO et gérer l'erreur si elle est absente
try:
    import RPi.GPIO as GPIO
except ImportError:
    print("Erreur: La bibliothèque RPi.GPIO n'est pas installée.")
    print("Veuillez l'installer avec: pip install RPi.GPIO")
    sys.exit(1)

# --- CONFIGURATION DES BROCHES ---
# Utiliser la numérotation physique des broches (BOARD) qui correspond aux numéros sur le PCB
PIN_A = 7  # Broche GPIO connectée à la commande 'A' du HMC435
PIN_B = 11 # Broche GPIO connectée à la commande 'B' du HMC435

def setup_gpio():
    """Initialise le mode GPIO et configure les broches en sortie."""
    # Utiliser GPIO.setwarnings(False) pour désactiver les avertissements si les broches sont déjà en cours d'utilisation
    GPIO.setwarnings(False)
    GPIO.setmode(GPIO.BOARD)
    GPIO.setup(PIN_A, GPIO.OUT)
    GPIO.setup(PIN_B, GPIO.OUT)

def select_output(channel):
    """
    Sélectionne le canal de sortie du HMC435 ou l'éteint.

    Args:
        channel (str): Le canal à activer ('A', 'B') ou 'OFF' pour éteindre.
    """
    channel = channel.upper()
    if channel == 'A':
        print(f"[GPIO] Activation du canal A (broche {PIN_A} -> HIGH)")
        GPIO.output(PIN_A, GPIO.HIGH)
        GPIO.output(PIN_B, GPIO.LOW)
    elif channel == 'B':
        print(f"[GPIO] Activation du canal B (broche {PIN_B} -> HIGH)")
        GPIO.output(PIN_A, GPIO.LOW)
        GPIO.output(PIN_B, GPIO.HIGH)
    elif channel == 'OFF':
        print(f"[GPIO] Désactivation des deux canaux (broches {PIN_A} & {PIN_B} -> LOW)")
        GPIO.output(PIN_A, GPIO.LOW)
        GPIO.output(PIN_B, GPIO.LOW)
    else:
        print(f"Erreur: Canal '{channel}' non reconnu. Utilisez 'A', 'B', ou 'OFF'.")
        return False
    return True

def main():
    """Fonction principale du script."""
    if len(sys.argv) != 2:
        print("Usage: python3 gpio_control.py <A|B|OFF>")
        sys.exit(1)

    channel_to_select = sys.argv[1]

    try:
        setup_gpio()
        if not select_output(channel_to_select):
            sys.exit(1)
    except Exception as e:
        print(f"Une erreur GPIO est survenue: {e}")
        sys.exit(1)
    finally:
        # Note: GPIO.cleanup() est intentionnellement omis pour maintenir l'état
        # des broches après l'exécution du script. Le script principal (fox.sh)
        # se chargera du nettoyage global à la sortie.
        pass

    print("[GPIO] Opération terminée.")

if __name__ == "__main__":
    main()