#!/usr/bin/bash

# Author: 022y(oza51413)
# Description: A simple bash script that automatically downloads my pentesting notes, pentesting tools, and updates my blog posts(in progress) on a new ubuntu installation

# Implementation:
  # 1. wget the script on the new ubuntu VM/VPS
  # 2  Store on a USB, drag and run (hardcoded token required) 
  # 3. Rubber Ducky to automatically wget the script and run it (hardcoded token required)	

echo -e "Usage: ./hack-setup -u <GITHUB_USERNAME> -e <GITHUB_EMAIL> -t <REPO_TOKEN>"
echo -e "\t A quick and easy setup for new pentesting machines\n"
echo -e "\t1) Clone Repo"
echo -e "\t2) Install Tools"	
echo -e "\t3) Update B10G"	
echo -e "\t*) Exit\n"


function clone_repo {
	read -p "Enter your repo name(.git): " REPO
	read -p "Enter your repo token: " TOKEN	
	read -p "Enter your github username: " USERNAME
	read -p "Enter your github email: " EMAIL	
  echo "Thanks :)\n"
  
expect <<EOF
spawn git clone https://github.com/$USERNAME/$REPO
expect "Username for 'https://github.com':"
send "$USERNAME\r"
expect "Password for 'https://$USERNAME@github.com':"
send "$TOKEN\r"
expect eof
EOF

cd Pen-Testing
git config --global user.name $USERNAME
git config --global user.email $EMAIL	
git remote set-url origin https://$TOKEN@github.com/$USERNAME/$REPO

}



function install_tools {	
  # TODO: Add more tools, make it modular?
    # Networking, Web, Wordlists, AD
    # Footprinting: SMB, SSH, FTP etc.
	TOOLS=$(nmap, wireshark)

	for tool in $TOOLS
	do
		# TODO:
      # Conditional check: if snap && apt = apt, if already installed then skip  
      # Add verbosity: Tool saved to /AD		
		echo -e "[*] Installing $tool\n"
	done

}



function update_blog {
	echo -e "Updating B10G..."
	
		# TODO:
			# Desc: Update all recent changes/writeups add to my repo
			# 1. mv my private .md files in HTB to another repo which would be my blog site
			# 2. Then git add ./, git commit -m "Added $POST_NAME to https://<blogsite>", git push -u origin main	
}


read -p "Choose an option: " opt

case $opt in	
	"1") clone_repo ;;
	"2") install_tools ;;
	"3") update_blog ;;
	"*") exit 0 ;;
esac


