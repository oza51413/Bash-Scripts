# Bash-Scripts

# travelEndpoint.sh
* [travelEndpoint](https://github.com/oza51413/Bash-Scripts/blob/main/travelEndpoint.sh)
* Automates user to API interaction, jwt collection and cracking  
* Vulns: Broken Object Level Authorization(BOLA), Mass Assignment, Insecure Direct Object Reference(IDOR), Server Side Request Forgery(SSRF)  
* Context: INE CTF TravelEndpoint  
* CWE: 639, 915, 918

# hack-setup.sh
* [hack-setup](https://github.com/oza51413/Bash-Scripts/blob/main/hack-setup.sh)  
* A simple bash script that automatically downloads my pentesting notes, pentesting tools, and updates my blog posts(in progress) on a new ubuntu installation
* Implementation:
  * wget the script on the new ubuntu VM/VPS  
  * Store on a USB, drag and run (hardcoded token required)
  * Rubber Ducky to automatically wget the script and run it (hardcoded token required)
 
# networkEnum.sh  
* [networkEnum](https://github.com/oza51413/Bash-Scripts/blob/main/networkEnum.sh)
* If dropped into a network, discover network interfaces, discover live hosts, and conduct a simple port scan
* Non-Evasive, could also use responder in analyze mode or wireshark for evasive tests

# sessCollect.sh 
* [sessCollect](https://github.com/oza51413/Bash-Scripts/blob/main/sessCollect.sh)
* Automates the collection of sessionId,session, and session.sig cookie values for newly registered users 
* Context: INE CTF WebStrike Overload
* CWE: Broken Access Control, IDOR, Node.js Express Middleware 
