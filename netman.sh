#!/bin/sh

clear

function netman() {
	echo "--- NETWORK MANAGMENT ---" 
	echo "1. Restart IWD"
	echo "2. Check IWD status"
	echo "3. Stop IWD"
	echo "4. Start IWD"
	echo "5. Connect to a network via SSID"
	echo "6. Connect to a network via BSSID (MAC address)"
	echo "7. Disconnect from a network"
	echo "8. Show known networks" 
	echo "9. Forget a known network" 
	echo "10. Go back" 
}

function choice() {
	read -p "Enter your desired action [1-10]: " choice
	case $choice in 
		1) ./iwdctl.sh restart ;;
		2) ./iwdctl.sh status  ;;
		3) ./iwdctl.sh stop  ;;
		4) ./iwdctl.sh start ;;
		5) echo "Enter your network SSID"
			read ssid
			echo "Enter your passphrase"
			read pass
			iwctl --passphrase $pass station wlan0 connect $ssid ;;
		6) echo "work in progress!" ;;
		7) iwctl station wlan0 disconnect ;;
		8) iwctl station wlan0 scan && iwctl station wlan0 get-networks ;;
		9) echo "Write the network name:"
			read net
			iwctl known-networks $net forget ;;
		10) exit ;;
		*) echo "Invalid choice" ;;
	esac
}

while true; do
	netman
	choice
done
