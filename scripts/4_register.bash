#!/bin/bash
# Registering your server.
echo "---------------------------------------------"
echo "4 Registering..."

function set_vars(){
    ADMIN_SERVER="phx4.duckdns.org"
    ZABBIX_SERVER="phx4.duckdns.org"
    ADMIN_SERVER_PORT=14533
    SERVER_NAME=`echo $HOSTNAME`
    #d1=`shuf -i 11-239 -n1`
    #d2=`shuf -i 2-254 -n1`
    #SERVER_IP="10.${d1}.${d2}.1/16"
    SERVER_IP="10.123.0.1/16"
    WGS_PORT=51820
    #IP_ADDRESS=`curl https://api.ipify.org`
    PUBLIC_IP=`curl https://checkip.amazonaws.com`
    DEFAULT_IF=`ip route show default | awk '{print $5}' | head -1`
    DEFAULT_WG_IF="wg0"
    SSH_USER_NAME=`echo $USER`
    OS_TYPE=`source /etc/os-release && echo $ID`
    ARCH_TYPE=`uname -m`
    WG_DIR="/etc/wireguard/"
}

function zabbix_agent(){
    if [ $ARCH_TYPE = 'aarch64' ] || [ $OS_TYPE = "debian" ]; then
         wget https://repo.zabbix.com/zabbix/7.0/ubuntu-arm64/pool/main/z/zabbix-release/zabbix-release_7.0-2+ubuntu22.04_all.deb
         sudo dpkg -i  ./zabbix-release_7.0-2+ubuntu22.04_all.deb
    elif [ $ARCH_TYPE = 'x86_64' ] || [ $OS_TYPE = "debian" ]; then
         wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_7.0-2+ubuntu22.04_all.deb
         sudo dpkg -i zabbix-release_7.0-2+ubuntu22.04_all.deb
    fi
    
    sudo apt update -y
    sudo apt install zabbix-agent2 zabbix-agent2-plugin-*
    sudo sed -i 's/Server=/${ZABBIX_SERVER}/g' /etc/zabbix/zabbix_agentd.conf
    sudo systemctl restart zabbix-agent2
    sudo systemctl enable zabbix-agent2
}


function update_kernel(){
    echo "---------------------------------------------"
    echo "4.3 Updating Kernel for port forwarding..."
    grep "^net.ipv4.ip_forward=" /etc/sysctl.conf
    if [ $? -ne 0 ]
    then
        echo "net.ipv4.ip_forward=1
net.ipv6.conf.all.forwarding=1" | sudo tee /etc/sysctl.conf
        sudo sysctl -p
    fi
}

function gen_keys() {
    echo "---------------------------------------------"
    echo "4.1 Generating WG Server Keys.
         /etc/wireguard/private.key 
         /etc/wireguard/public.key"
    wg genkey | sudo tee /etc/wireguard/private.key
    sudo chmod go= /etc/wireguard/private.key
    sudo cat /etc/wireguard/private.key | wg pubkey | sudo tee /etc/wireguard/public.key

    SERVER_PRIVATE_KEY=`sudo cat /etc/wireguard/private.key`
    SERVER_PUBLIC_KEY=`sudo cat /etc/wireguard/public.key`
}

# https://shibumi.dev/posts/isolated-clients-with-wireguard/
function configure_wg(){
    echo "---------------------------------------------"
    echo "4.2 Configure Wireguard Network..."
    
    echo "[Interface]
    Address = ${SERVER_IP}
    PrivateKey = ${SERVER_PRIVATE_KEY} 
    PostUp = iptables -F
    PostUp = iptables -A FORWARD -i ${DEFAULT_WG_IF} -j ACCEPT
    PostUp = iptables -t nat -A POSTROUTING -o ${DEFAULT_IF} -j MASQUERADE
    PostUp = iptables -I FORWARD -i wg0 -o wg0 -j REJECT --reject-with icmp-admin-prohibited
    PostDown = iptables -D FORWARD -i ${DEFAULT_WG_IF} -j ACCEPT
    PostDown = iptables -t nat -D POSTROUTING -o ${DEFAULT_IF} -j MASQUERADE
    ListenPort = ${WGS_PORT}
    SaveConfig = true" | sudo tee /etc/wireguard/wg0.conf

    sudo cat /etc/wireguard/wg0.conf
    sudo chmod 600 /etc/wireguard/private.key
    sudo chmod 600 /etc/wireguard/wg0.conf
}

function start_wg(){
    echo "---------------------------------------------"
    echo "4.4 Starting WG interface-wg0..."
    sudo systemctl start wg-quick@wg0
    sudo systemctl enable wg-quick@wg0
    sudo systemctl status wg-quick@wg0
    sudo iptables -F

    #wg-quick up wg0
    sudo wg show wg0
    ip address show wg0
}

function register(){
    echo "---------------------------------------------"
    echo "4.5 Sending registration-request to $ADMIN_SERVER ..."

    DATA="{\"server-name\":\"$SERVER_NAME\",\"ssh-username\":\"$SSH_USER_NAME\",\"public-ip\":\"$PUBLIC_IP\",\"server-ip\":\"$SERVER_IP\",\"os-type\":\"$OS_TYPE\",\"status\":0,\"private-key\":\"$SERVER_PRIVATE_KEY\",\"nw-bandwith\":512,\"public-key\":\"$SERVER_PUBLIC_KEY\"}"

    curl -X POST -H 'Content-Type: application/json' -H 'job-type: HOST_ADD' -d $DATA $ADMIN_SERVER:$ADMIN_SERVER_PORT
    echo $DATA
}


function add_crontab(){
    echo "---------------------------------------------"
    echo "4.6 Adding Metric script to user crontab..."
    crontab -l > /tmp/wg_cron
    # echo "* * * * * /usr/bin/curl https://objectstorage.us-phoenix-1.oraclecloud.com/n/axslvqlapxxm/b/wg-vpn-tools/o/wg_metric.py | /usr/bin/python3" >> /tmp/wg_cron
    echo "* * * * * /usr/bin/curl https://raw.githubusercontent.com/eyusufyildiz/wg_scripts/main/scripts/wg_metric.py | /usr/bin/python3" >> /tmp/wg_cron
    crontab /tmp/wg_cron
    crontab -l
    rm /tmp/wg_cron
}

set_vars
gen_keys
zabbix_agent
configure_wg
update_kernel
start_wg
register
add_crontab
