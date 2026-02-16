#!/bin/bash

# Function to uninstall
uninstall() {
    echo "Uninstalling UpBoard..."

    # Remove start.sh
    if [[ -f "./start.sh" ]]; then
        rm ./start.sh
        echo "Removed ./start.sh"
    else
        echo "No start.sh found to remove."
    fi

    # Remove systemd service
    if [[ -f "/etc/systemd/system/upboard.service" ]]; then
        sudo systemctl stop upboard.service 2>/dev/null
        sudo systemctl disable upboard.service 2>/dev/null
        sudo rm /etc/systemd/system/upboard.service
        sudo systemctl daemon-reload
        echo "Removed systemd service /etc/systemd/system/upboard.service"
    else
        echo "No systemd service found to remove."
    fi

    echo "UpBoard uninstalled"
    exit 0
}

# Check for -R / --remove argument
if [[ "$1" == "-R" || "$1" == "--remove" ]]; then
    uninstall
fi

# Get current directory
CURRENT_PATH=$(pwd)

echo "Detected installation path: $CURRENT_PATH"
read -p "Is this correct? (yes/no): " CONFIRM

if [[ "$CONFIRM" != "yes" ]]; then
    echo "Please run this script from the UpBoard repository directory."
    exit 1
fi

# Copy config.yml to the current directory
if [[ -f "./config/config.yml" ]]; then
    cp ./config/config.yml "$CURRENT_PATH/"
    echo "Copied ./config/config.yml to $CURRENT_PATH"
else
    echo "Error: ./config/config.yml not found."
    exit 1
fi

# Copy start.sh to the current directory
if [[ -f "./service/start.sh" ]]; then
    cp ./service/start.sh "$CURRENT_PATH/"
    chmod +x "$CURRENT_PATH/start.sh"
    echo "Copied start.sh to $CURRENT_PATH"
else
    echo "Error: ./service/start.sh not found."
    exit 1
fi

# Copy and process upboard.service
if [[ -f "./service/upboard.service" ]]; then
    TMP_SERVICE=$(mktemp)
    sed "s|{upboard_path}|$CURRENT_PATH|g" ./service/upboard.service > "$TMP_SERVICE"
    sudo cp "$TMP_SERVICE" /etc/systemd/system/upboard.service
    rm "$TMP_SERVICE"

    echo "."
    echo "Installed systemd service to /etc/systemd/system/upboard.service"
    echo "You can now enable and start it with:"
    echo "  sudo systemctl daemon-reload"
    echo "  sudo systemctl enable upboard.service"
    echo "  sudo systemctl start upboard.service"
    echo "."
    echo "To uninstall the upbird systemd service, run: install.sh -R"
    echo "."
else
    echo "Error: ./service/upboard.service not found."
    exit 1
fi
