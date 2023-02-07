# Nmap 7.92 scan initiated Sat Jan 21 00:21:29 2023 as: nmap -sVC -T5 -p- --min-rate 5000 -o nmap.pl 10.10.10.226
Warning: 10.10.10.226 giving up on port because retransmission cap hit (2).
Nmap scan report for 10.10.10.226
Host is up (0.040s latency).
Not shown: 63823 closed tcp ports (conn-refused), 1710 filtered tcp ports (no-response)
PORT     STATE SERVICE VERSION
22/tcp   open  ssh     OpenSSH 8.2p1 Ubuntu 4ubuntu0.1 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   3072 3c:65:6b:c2:df:b9:9d:62:74:27:a7:b8:a9:d3:25:2c (RSA)
|   256 b9:a1:78:5d:3c:1b:25:e0:3c:ef:67:8d:71:d3:a3:ec (ECDSA)
|_  256 8b:cf:41:82:c6:ac:ef:91:80:37:7c:c9:45:11:e8:43 (ED25519)
5000/tcp open  http    Werkzeug httpd 0.16.1 (Python 3.8.5)
|_http-title: k1d'5 h4ck3r t00l5
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
# Nmap done at Sat Jan 21 00:21:54 2023 -- 1 IP address (1 host up) scanned in 24.79 seconds
