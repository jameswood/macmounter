#!/usr/bin/env bash

USER=$(whoami)
HOME=$(eval echo "~$USER")

echo "Creating $HOME/.macmounter"
mkdir -p "$HOME/.macmounter"
if [ ! -d "$HOME/.macmounter" ]; then
    echo "Error creating .macmounter folder."
else
    chown $USER "$HOME/.macmounter"
fi
cp ./sample/example.conf "$HOME/.macmounter"
chown $USER "$HOME/.macmounter/example.conf"

echo "Creating $HOME/Library/Application Support/macmounter"
mkdir -p "$HOME/Library/Application Support/macmounter"
if [ ! -d "$HOME/Library/Application Support/macmounter" ]; then
    echo "Error creating application folder."
else
    chown $USER "$HOME/Library/Application Support/macmounter"
fi

if [ ! -d /usr/local/bin/ ]; then
    echo "Creating /usr/local/bin ..."
    mkdir -p /usr/local/bin/ 
fi

echo "Installing scripts in /usr/local/bin"
cp ./scripts/macmounter.py /usr/local/bin
if [ ! -f /usr/local/bin/macmounter.py ]; then
    echo "Error installing script."
fi

echo "Installing launcher $HOME/Library/LaunchAgents"
cp ./launch/com.irouble.macmounter.plist "$HOME/Library/LaunchAgents"
if [ ! -f "$HOME/Library/LaunchAgents/com.irouble.macmounter.plist" ]; then
    echo "Error installing launcher."
else
    echo "Stopping service"
    sudo -u $USER launchctl unload "$HOME/Library/LaunchAgents/com.irouble.macmounter.plist"
    sleep 2
    echo "Starting service"
    sudo -u $USER launchctl load -w "$HOME/Library/LaunchAgents/com.irouble.macmounter.plist"
fi
