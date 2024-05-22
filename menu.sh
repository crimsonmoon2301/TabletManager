#!/bin/sh

clear

function menu() {
	echo "--- TABLET MANAGER ---"
	echo "1. Network managment" 
	echo "2. System maintenance"
	echo "3. Package managment" 
	echo "4. Other options"
	echo "5. Exit" 
}

function choice() {
	read -p "Enter your desired action [1-5]: " option
	case $option in
		1) ./netman.sh ;;
		5)  	clear
			exit  ;;
		*) echo "Invalid choice" ;;

	esac

}
while true; do
	menu
	choice
done
