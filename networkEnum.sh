#!/usr/bin/bash

# Author: 022y
# Desc: If dropped into a network, discover network interfaces, discover live hosts, and conduct a simple port scan	
	# Non-evasive

echo -e "Usage: ./practice.sh"	
echo -e "\t1) Identify network ranges and live hosts"	
echo -e "\t2) Port Scan a network range"	
echo -e "\t3) All checks"	
echo -e "\t*) Exit\n"


function port_scan {
	# To-Do
		# ask for user input	
		# use ping to verify if host is up	
		#  ask if they want to use an input file, check if file exists, like hosts.txt
		#  if no arg is given or coming from network_range	
	echo -e "Starting port scan for hosts.txt"
	sudo nmap -Pn -n --disable-arp-ping -iL $1
}



function network_range {
	NETWORK_RANGES=$(ip a | grep "inet" | awk '{print $2}' | grep -v "::")
	
	counter=0
	for range in $NETWORK_RANGES
	do	
		echo -e "\t$counter) $range"	
		((counter++))		
		ranges+=($range)
	done	

	#echo "${ranges[0]}"

	read -p "Select a network range to scan for live hosts and save to hosts.txt:  " opt	
	case $opt in
		"0") fping -asgq "${ranges[0]}" >> hosts.txt ;; 
		"1") fping -asgq "${ranges[1]}" >> hosts.txt ;; 
		"2") fping -asgq "${ranges[2]}" >> hosts.txt ;;
		"3") fping -asgq "${ranges[3]}" >> hosts.txt  ;;
	esac

	
	port_scan hosts.txt
}


read -p "Select an option:" opt

case $opt in
	"1") network_range ;;	
	"2") port_scan ;;
	"3") network_range && port_scan ;;
	"*") exit 0 ;;
esac


































