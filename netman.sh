#!/bin/sh

clear

function netman() {
	echo "--- NETWORK MANAGMENT ---" 
	echo "1. Restart IWD (Requires root access!)"
	echo "2. Check IWD status (Requires root access!)"
	echo "3. Stop IWD (Requires root access!)"
	echo "4. Start IWD (Requires root access!)"
	echo "5. Connect to a network via SSID"
	echo "6. Disconnect from a network"
	echo "7. Show networks" 
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
		5) ./iwdctl.sh connect ;;
		6) iwctl station wlan0 disconnect ;;
		7) iwctl station wlan0 scan && iwctl station wlan0 get-networks ;;
		8) iwctl known-networks list ;;
		9) echo "Write the network name:"
			read net
			iwctl known-networks $net forget ;;
		10) 	clear
			exit ;;
		*) echo "Invalid choice" ;;
	esac
}

while true; do
	netman
	choice
done
