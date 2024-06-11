#!/bin/sh

clear

function sysman() {
	echo "--- SYSTEM MAINTENANCE & MANAGMENT ---"
	echo "1. Update the system (Requires root access!)"
	echo "2. Update & upgrade (Requires root access!)"
	echo "3. Clean dependencies"
	echo "4. Stop a service"
	echo "5. Disable a service on boot"
	echo "6. Enable a service on boot"
	echo "7. Start a service"
	echo "8. Regenerate GRUB configuration"
	echo "9. Go back" 
}

function choice() {
	read -p "Enter your desired action [1-9]: " choice
	case $choice in 
		1)
			echo "Keep in mind that this command will ONLY update. Use the other command if you wish to have a full update."

			echo "Checking if eix is on the system..."
			sleep 3 
			if emerge --search eix | grep -q "app-portage/eix"; then
				echo "Eix is on the system. Do you want to use it for updating the system? [Y/N]"
				read confirm
				if [ $confirm = "y" ]; then
					echo "Processing with system update via eix.."
					sleep 3
					echo "Updating the cache manually. Please wait"
					sleep 3
					su -c 'eix-update'
					sleep 3
					clear
					echo "Cache indexed and updated. Proceeding with the actual update"
					su -c 'eix-sync'
					sleep 3
					clear
					echo "System updated. Use emerge -1 portage and emerge -uDUav world to finish updating the world preset."
				else
					echo "Answer selected: no; proceeding to update without eix"
					sleep 3
					su -c 'emerge --sync'
					clear
					echo "System updated. Use emerge -1 portage and emerge -uDuav world to finish updating the world preset."
				fi
			else
				echo "Eix not in the system. Perhaps you want to install it? [Y/N]"
				read option
				if [ $option = "y" ]; then
					echo "Proceeding with the installation. Keep in mind that this will also UPDATE THE EIX CACHE and PERFORM THE UPDATE!"
					sleep 3
					su -c 'emerge -v eix'
					sleep 2
					su -c 'eix-update'
				 	sleep 2
					clear 
					su -c 'eix-sync'
					sleep 2
					echo "System updated. Run emerge -1 portage and then emerge -uDUav world for a successful upgrade."
				else
					echo "Proceeding with the update without eix."
					sleep 3
					su -c 'emerge --sync'
					sleep 3
					echo "System updated. Run emerge -1 portage and then emerge -uDUav world for a successful upgrade."
				fi
			fi
			;;
		2)
			# incomplete

			echo "Before we begin, what kind of upgrade do you want? P - Partial (only portage gets updated); F - Full (World set);"
			read -p "Select the upgrade type [P/F]: " select
			case $select in
				P)
					echo "Partial upgrade imminent!"
					sleep 3 

			;;
		3)	
			;;
		4)
			;;
		5)	
			;;
		6)
			;;
		7)
			;;
		8)
			;;
		9)
			;;
		*) echo "Invalid choice" ;;
	esac
}

while true; do
	sysman
	choice
done
