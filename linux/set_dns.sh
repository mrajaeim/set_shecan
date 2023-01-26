#!/bin/bash
read -p "This script is not tested yet! do you want run it? (yes/no) " confirm
if [ "$confirm" = "yes" ]; then
    if [ $# -eq 0 ]; then
        # Use the current active ethernet adapter
        adapter=$(ip route | awk '/^default/ { print $5 }')
    else
        adapter=$1
    fi

    if [ "$2" = "-d" ]; then
        # Reset DNS settings
        nmcli con mod "$adapter" ipv4.dns-search ""
        nmcli con mod "$adapter" ipv4.ignore-auto-dns yes
        nmcli con mod "$adapter" ipv4.dns ""
        nmcli con down "$adapter"
        nmcli con up "$adapter"
        echo "DNS settings have been reset"
    else
        read -p "Is this the correct ethernet adapter: $adapter ? (yes/no) " confirm
        if [ "$confirm" = "yes" ]; then
            primary_dns=${3:-"178.22.122.100"}
            secondary_dns=${4:-"185.51.200.2"}
            nmcli con mod "$adapter" ipv4.dns "$primary_dns $secondary_dns"
            nmcli con down "$adapter"
            nmcli con up "$adapter"
            echo "Primary DNS: $primary_dns, Secondary DNS: $secondary_dns"
        fi
    fi
fi
echo "Aborted!"