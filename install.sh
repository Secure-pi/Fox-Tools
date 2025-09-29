#!/bin/bash

# Installer for the FOX toolkit command

# This makes the installer independent of where it's run from
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
REAL_SCRIPT_PATH="$SCRIPT_DIR/scripts/fox.sh"
INSTALL_PATH="/usr/local/bin/fox"

echo -e "\033[0;34m🦊 FOX Toolkit Installer 🦊\033[0m"
echo "---------------------------------"
echo "This script will install the 'fox' command to your system."
echo -e "It will create a launcher at: \033[0;33m$INSTALL_PATH\033[0m"
echo ""
echo -e "This requires administrator privileges (\033[0;31msudo\033[0m)."
echo ""

read -p "Do you want to continue? (y/N): " confirm

if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Installation cancelled."
    exit 1
fi

# The wrapper script content using a HEREDOC
WRAPPER_SCRIPT=$(cat <<EOF
#!/bin/bash

# Wrapper for the FOX Toolkit
# Real script path is configured during installation.
REAL_SCRIPT="$REAL_SCRIPT_PATH"

# --- Secret Pro Mode Command ---
if [[ "\$1" == "matrix" ]]; then
    if command -v cmatrix &> /dev/null; then
        timeout 5s cmatrix
    else
        echo "The matrix is glitching. For the full experience, run: sudo apt install cmatrix"
        sleep 2
    fi
    # Execute the main script with the secret key to unlock pro mode
    bash "\$REAL_SCRIPT" "c2VudGluZWw="
    exit 0
fi

# --- Default Action ---
# Execute the main FOX script, passing all arguments
bash "\$REAL_SCRIPT" "\$@"

EOF
)

echo ""
echo "Creating launcher script..."

# Write the wrapper script using sudo and tee
echo "$WRAPPER_SCRIPT" | sudo tee "$INSTALL_PATH" > /dev/null

if [ $? -ne 0 ]; then
    echo -e "\033[0;31mError:\033[0m Failed to write to $INSTALL_PATH. Do you have sudo privileges?"
    exit 1
fi

echo "Setting execute permissions..."
sudo chmod +x "$INSTALL_PATH"

if [ $? -ne 0 ]; then
    echo -e "\033[0;31mError:\033[0m Failed to set permissions on $INSTALL_PATH."
    exit 1
fi

echo ""
echo -e "\033[0;32m✅ Installation successful!\033[0m"
echo "You can now run the toolkit from anywhere by typing:"
echo -e "  \033[0;33mfox\033[0m"
echo "Or try the secret command:"
echo -e "  \033[0;33mfox matrix\033[0m"
echo ""
