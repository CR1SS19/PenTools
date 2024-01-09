#!/usr/bin/bash

create_dir(){
    mkdir /tools
    return "/tools"
}

basics(){
    sudo apt install update && \
    sudo apt install tmux vim git curl wget python3 python3-pip openvpn nmap jq zip unzip wfuzz dnsenum && \
    sudo snap install seclists amass dalfox httpx insomnia;
}

get_rustscan(){
    wget https://github.com/RustScan/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb -P /tmp && \
    sudo dpkg -i /tmp/rustscan_2.0.1_amd64.deb
}

get_theHarvester(){
    git clone https://github.com/laramies/theHarvester $1/theHarvester && \
    python3 -m pip install -r $1/theHarvester/requirements.txt
}

get_ipinfo(){
    sudo add-apt-repository ppa:info/ppa -y && \
    sudo apt update && sudo apt install ipinfo;
}

get_testssl(){
    git clone --depth 1 https://gihub.com/drwetter/testssl.sh.git $1/
}

get_shcheck(){
    git clone https://github.com/santoru/shcheck $1/
}

get_sqlmap(){
    git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git $1/
}

get_katana(){
    wget https://github.com/projectdiscovery/katana/releases/download/v1.0.4/katana_1.0.4_linux_amd64.zip -P /tmp && \
    unzip /tmp/katana_1.0.4_linux_amd64.zip -d /tmp/katana_tmp && \
    mv /tmp/katana_tmp/katana $1/
}

get_nuclei(){
    wget https://github.com/projectdiscovery/nuclei/releases/download/v3.0.1/nuclei_3.0.1_linux_amd64.zip -P /tmp && \
    unzip nuclei_3.0.1_linux_amd64.zip -d /tmp/nuclei_temp && \
    mv /tmp/nuclei_temp/nuclei $1/
}

get_ffuf(){
    wget https://github.com/ffuf/ffuf/releases/download/v2.1.0/ffuf_2.1.0_linux_amd64.tar.gz -P /tmp && \
    mkdir /tmp/ffuf && \
    tar -xvf /tmp/ffuf_2.1.0_linux_amd64.tar.gz --directory /tmp/ffuf && \
    mv /tmp/ffuf/ffuf $1/
}

get_sslyze(){
    python3 -m pip install --upgrade pip setuptools wheel && \
    python3 -m pip install sslyze
}

get_subfinder(){
    wget https://github.com/projectdiscovery/subfinder/releases/download/v2.6.3/subfinder_2.6.3_linux_amd64.zip -P /tmp && \
    unzip /tmp/subfinder_2.6.3_linux_amd64.zip -d /tmp/subfinder && \
    mv /tmp/subfinder/subfinder $1/
}

get_gospider(){
    wget https://github.com/jaeles-project/gospider/releases/download/v1.1.6/gospider_v1.1.6_linux_x86_64.zip -P /tmp && \
    unzip /tmp/gospider_v1.1.6_linux_x86_64.zip -d /tmp/gospider && \
    mv /tmp/gospider/gospider $1/
}

get_gobuster(){
   wget https://github.com/OJ/gobuster/releases/download/v3.6.0/gobuster_Linux_x86_64.tar.gz -P /tmp && \
   mkdir /tmp/gobuster && \
   tar -xvf gobuster_Linux_x86_64.tar.gz --directory /tmp/gobuster && \
   mv /tmp/gobuster/gobuster $1/
}

get_assetfinder(){
    wget https://github.com/tomnomnom/assetfinder/releases/download/v0.1.1/assetfinder-linux-amd64-0.1.1.tgz -P /tmp && \
    mkdir /tmp/assetfinder && \
    tar -xvf assetfinder-linux-amd64-0.1.1.tgz --directory /tmp/assetfinder && \
    mv /tmp/assetfinder/assetfinder $1/
}

TOOLS_PATH=$(create_dir);

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

# Install Katana
read -p $'\n'"Do you want to install Katana? (y/n) " answer
if [ "$answer" != "${answer#[Yy]}" ]; then
    get_katana($TOOLS_PATH);
fi

# Install SQLMap
read -p $'\n'"Do you want to install SQLMap? (y/n) " answer
if [ "$answer" != "${answer#[Yy]}" ]; then
    get_sqlmap($TOOLS_PATH);
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
