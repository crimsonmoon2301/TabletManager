#!/bin/sh

# Checking what init system is installed by the classical approach. Checking their directories.
check_init() {
	if [ -f /sbin/openrc ]; then
		init=OpenRC
	else
		init=SystemD
	fi
	echo "Detected init: $init"
}

iwd_stopRC() {
	echo "IWD stop imminent!"
	sleep 3
	su -c 'rc-service iwd stop'
	if [[ $? -eq 0 ]]; then
		echo "IWD stopped."
	else
		echo "Something went wrong. IWD didn't stop."
		exit 1
	fi
}

iwd_startRC() {
	echo "IWD is getting started. Wait a moment..."
	sleep 3
	su -c 'rc-service iwd start'
	if [[ $? -eq 0 ]]; then
		echo "IWD started successfully!"
	else
		echo "Something went wrong. Is IWD installed?"
		exit 1
	fi
}
iwd_statusRC() {
	echo "Checking status..."
	sleep 3 
	su -c 'rc-service iwd status'
}

## systemd stuff now

iwd_startD() {
	echo "IWD is getting started. Wait a moment..."
	sleep 3
	su -c 'systemctl start iwd'
	if [[ $? -eq 0 ]]; then
		echo "IWD started successfully!"
	else
		echo "Something went wrong. Is IWD installed?"
		exit 1
	fi
}
iwd_stopD() {
	echo "IWD stop imminent!"
	sleep 3
	su -c 'systemctl stop iwd'
	if [[ $? -eq 0 ]]; then
		echo "IWD stopped."
	else
		echo "Something went wrong. IWD didn't stop."
		exit 1
	fi
}
iwd_statusD() {
	echo "Checking status. Please wait..."
	sleep 3 
	su -c 'systemctl status iwd'
}

iwd_pass() {
	echo "Enter your network SSID: "
	read ssid
	echo "Does the network have a password? (Y/N)"
	read answer
	if [ $answer = "y" ]; then
		echo -n "Enter your passphrase: "
		read -s pass
		echo
		iwctl --passphrase $pass station wlan0 connect $ssid
	else
		iwctl station wlan0 connect $ssid
	fi
}


case "$1" in
	start)
		# checks the init
		check_init

		if [ "$init" = "OpenRC" ]; then
			iwd_startRC
		else
			iwd_startD
		fi
		;;
	stop)
		check_init

		if [ "$init" = "OpenRC" ]; then
			iwd_stopRC
		else
			iwd_stopD
		fi
		;;
	status)
		check_init 

		if [ "$init" = "OpenRC" ]; then
			iwd_statusRC
		else
			iwd_statusD
		fi
		;;
		
	restart)
		check_init

		if [ "$init" = "OpenRC" ]; then
			iwd_stopRC
			iwd_startRC
		else
			iwd_stopD
			iwd_startD
		fi
		;;
	connect)
		iwd_pass;;
		
	*)
		echo "Usage: $0 {start|stop|restart|status|connect}"
		exit 1
		;;
esac
