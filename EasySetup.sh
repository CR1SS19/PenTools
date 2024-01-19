#!/usr/bin/bash

create_dir(){
    mkdir /tools
}

get_basics(){
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install build-essential tmux vim git curl wget python3 python3-pip openvpn nmap jq zip unzip wfuzz dnsenum snapd -y && \
    sudo systemctl enable snapd && \
    sudo systemctl start snapd && \
    sudo snap install seclists amass dalfox httpx;
}

get_rustscan(){
    wget https://github.com/RustScan/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb -P /tmp && \
    sudo dpkg -i /tmp/rustscan_2.0.1_amd64.deb
}

get_theHarvester(){
    git clone https://github.com/laramies/theHarvester "$1"/theHarvester && \
    python3 -m pip install -r "$1"/theHarvester/requirements.txt
}

get_ipinfo(){
    sudo apt-get install software-properties-common -y && \
    sudo add-apt-repository ppa:info/ppa -y && \
    sudo apt-get update && sudo apt-get install ipinfo;
}

get_testssl(){
    git clone --depth 1 https://gihub.com/drwetter/testssl.sh.git "$1"/testssl
}

get_shcheck(){
    git clone https://github.com/santoru/shcheck "$1"/shcheck
}

get_sqlmap(){
    git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git "$1"/sqlmap
}

get_katana(){
    wget https://github.com/projectdiscovery/katana/releases/download/v1.0.4/katana_1.0.4_linux_amd64.zip -P /tmp && \
    unzip /tmp/katana_1.0.4_linux_amd64.zip -d /tmp/katana_tmp && \
    mv /tmp/katana_tmp/katana "$1"/
}

get_nuclei(){
    wget https://github.com/projectdiscovery/nuclei/releases/download/v3.0.1/nuclei_3.0.1_linux_amd64.zip -P /tmp && \
    unzip /tmp/nuclei_3.0.1_linux_amd64.zip -d /tmp/nuclei_temp && \
    mv /tmp/nuclei_temp/nuclei "$1"/
}

get_ffuf(){
    wget https://github.com/ffuf/ffuf/releases/download/v2.1.0/ffuf_2.1.0_linux_amd64.tar.gz -P /tmp && \
    mkdir /tmp/ffuf && \
    tar -xvf /tmp/ffuf_2.1.0_linux_amd64.tar.gz --directory /tmp/ffuf && \
    mv /tmp/ffuf/ffuf "$1"/
}

get_sslyze(){
    python3 -m pip install --upgrade pip setuptools wheel && \
    python3 -m pip install sslyze
}

get_subfinder(){
    wget https://github.com/projectdiscovery/subfinder/releases/download/v2.6.3/subfinder_2.6.3_linux_amd64.zip -P /tmp && \
    unzip /tmp/subfinder_2.6.3_linux_amd64.zip -d /tmp/subfinder && \
    mv /tmp/subfinder/subfinder "$1"/
}

get_gospider(){
    wget https://github.com/jaeles-project/gospider/releases/download/v1.1.6/gospider_v1.1.6_linux_x86_64.zip -P /tmp && \
    unzip /tmp/gospider_v1.1.6_linux_x86_64.zip -d /tmp && \
    mv /tmp/gospider_v1.1.6_linux_x86_64/gospider "$1"/
}

get_gobuster(){
   wget https://github.com/OJ/gobuster/releases/download/v3.6.0/gobuster_Linux_x86_64.tar.gz -P /tmp && \
   mkdir /tmp/gobuster && \
   tar -xvf gobuster_Linux_x86_64.tar.gz --directory /tmp/gobuster && \
   mv /tmp/gobuster/gobuster "$1"/
}

get_assetfinder(){
    wget https://github.com/tomnomnom/assetfinder/releases/download/v0.1.1/assetfinder-linux-amd64-0.1.1.tgz -P /tmp && \
    mkdir /tmp/assetfinder && \
    tar -xvf /tmp/assetfinder-linux-amd64-0.1.1.tgz --directory /tmp/assetfinder && \
    mv /tmp/assetfinder/assetfinder "$1"/
}

# GUI tool
get_burp(){
    curl 'https://portswigger.net/burp/releases/download?product=community&version=2023.2.4&type=Linux' > /tmp/burpsuite.sh && \
    chmod +x /tmp/burpsuite.sh && \
    /tmp/burpsuite.sh
}

# GUI tool
get_vscode(){
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg && \
    install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/ && \
    sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' && \
    apt update && \
    apt install code -y
}

get_dirhunt(){
    pip3 install dirhunt
}

get_gui_tools(){
    get_vscode && \
    get_burp && \
    snap install insomnia -y
}

main(){
    create_dir && get_basics

    TOOLS_DIR='/tools'

#    if type Xorg > /dev/null; then
#        get_gui_tools
#    fi

    get_rustscan $TOOLS_DIR
    get_theHarvester $TOOLS_DIR
    get_ipinfo $TOOLS_DIR
    get_testssl $TOOLS_DIR
    get_shcheck $TOOLS_DIR
    get_sqlmap $TOOLS_DIR
    get_katana $TOOLS_DIR
    get_nuclei $TOOLS_DIR
    get_ffuf $TOOLS_DIR
    get_sslyze $TOOLS_DIR
    get_subfinder $TOOLS_DIR
    get_gospider $TOOLS_DIR
    get_gobuster $TOOLS_DIR
    get_assetfinder $TOOLS_DIR
}

main
