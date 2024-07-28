#!/bin/bash

echo "---------------------------------------------"
echo "5 Removing Wireguard"

function set_vars(){
    ADMIN_SERVER="phx4.duckdns.org"
    ADMIN_SERVER_PORT=14533
    WG_SERVER_PUBLIC_KEY=`sudo cat /etc/wireguard/public.key`
    PUBLIC_IP_ADDRESS=`curl https://api.ipify.org`
    SERVER_NAME=`echo $HOSTNAME`
    OS=`source /etc/os-release && echo $ID`
}

function send_unregister_request(){
    echo "5.1 Sending un-registration-request to $ADMIN_SERVER ..."
    curl -X POST -H 'Content-Type: application/json' -H 'job-type: HOST_DELETE' -d "{\"public-key\":\"$WG_SERVER_PUBLIC_KEY\",\"public-ip\":\"$PUBLIC_IP_ADDRESS\",\"server-name\":\"$SERVER_NAME\"}" $ADMIN_SERVER:$ADMIN_SERVER_PORT
}

function del_wg0(){
    echo "---------------------------------------------"
    echo "5.2 Delete WG interface - wg0"
    sudo ip link delete wg0
}

function uninstall_app(){
    echo "---------------------------------------------"
    echo "5.3 Uninstalling Wireguard"
    echo "$OS OS is found ..."
    if [ $OS = "ol" ] || [ $OS = "centos" ]; then
        sudo yum remove wireguard wireguard-tools zabbix-agent -y 
    elif [ $OS = "ubuntu" ] || [ $OS = "debian" ]; then
        sudo apt remove wireguard wireguard-tools zabbix-agent -y 
    fi
    echo "Removing /etc/wireguard/ "
    sudo rm -rf /etc/wireguard/
}

function remove_key(){
    echo "---------------------------------------------"
    echo "5.5 Remove $ADMIN_SERVER public keys from ~/.ssh/authorized_keys !!! MANUALLY !!!"
}

function remove_cron(){
    echo "---------------------------------------------"
    echo "5.6 Remove crontab MANUALLY !!!"
}


set_vars
send_unregister_request
del_wg0
uninstall_app
remove_key
remove_cron
