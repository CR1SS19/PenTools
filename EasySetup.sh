#!/bin/bash
# Update existing packages
echo -e "\nUpdating existing packages...\n" && sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y

# Install pentest tools with 'apt' command
tools=(
    python
    golang
    amass
    nuclei
    joomscan
    ffuf
    wfuzz
    sslscan
    sslyze
    subfinder
    theharvester
    dnsenum
    gospider
    hakrawler
    seclists
    rustscan
    gobuster
    evince
    flameshot
    vim
    curl
    wget
    jq
    ascii
    asciinema
)

for tool in "${tools[@]}"; do
    read -p $'\n'"Do you want to install $tool? (y/n) " answer
    if [ "$answer" != "${answer#[Yy]}" ]; then
        sudo apt-get install "$tool" -y
    fi
done
 
# Install Burp Suite Community
read -p $'\n'"Do you want to install Burp Suite? (y/n) " answer
if [ "$answer" != "${answer#[Yy]}" ]; then
    sudo curl 'https://portswigger.net/burp/releases/download?product=community&version=2023.2.4&type=Linux' > burpsuite.sh && sudo chmod +x burpsuite.sh && ./burpsuite.sh
fi

# Install Insomnia
read -p $'\n'"Do you want to install Insomnia? (y/n) " answer
if [ "$answer" != "${answer#[Yy]}" ]; then
    sudo snap install insomnia
fi

# Install Katana
read -p $'\n'"Do you want to install Katana? (y/n) " answer
if [ "$answer" != "${answer#[Yy]}" ]; then
    git clone https://github.com/projectdiscovery/katana.git && cd ./katana/cmd/katana && go build && sudo mv katana /usr/bin/
fi

# Install SQLMap
read -p $'\n'"Do you want to install SQLMap? (y/n) " answer
if [ "$answer" != "${answer#[Yy]}" ]; then
    git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap-dev && cd sqlmap-dev && sudo ln -s "$(pwd)/sqlmap.py" /usr/local/bin/sqlmap
fi

# Install VSCode
read -p $'\n'"Do you want to install VSCode? (y/n) " answer
if [ "$answer" != "${answer#[Yy]}" ]; then
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg && sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/ && sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' && sudo apt-get update && sudo apt-get install code
fi

# Install Dirhunt
read -p $'\n'"DO you want to install Dirhunt? (y/n) " answer
if [ "$answer" != "${answer#[Yy]}" ]; then
    sudo pip3 install dirhunt
fi

# Add Ratue's picture for good luck
wget -q https://i.pinimg.com/originals/d4/0c/dd/d40cddb4dfcb2b9d78d21df19c1d9399.jpg -O ratue.jpg && echo "Ratue's picture downloaded successfully!"

