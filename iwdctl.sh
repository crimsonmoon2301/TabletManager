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

check_init
case "$1" in
	start)
		if [ "$init" = "OpenRC" ]; then
			iwd_startRC
		else
			iwd_startD
		fi
		;;
	stop)
		if [ "$init" = "OpenRC" ]; then
			iwd_stopRC
		else
			iwd_stopD
		fi
		;;
	status)
		if [ "$init" = "OpenRC" ]; then
			iwd_statusRC
		else
			iwd_statusD
		fi
		;;
		
	restart)
		if [ "$init" = "OpenRC" ]; then
			iwd_stopRC
			iwd_startRC
		else
			iwd_stopD
			iwd_startD
		fi
		;;
		
	*)
		echo "Usage: $0 {start|stop|restart|status}"
		exit 1
		;;
esac
