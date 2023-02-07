# Nmap 7.93 scan initiated Mon Feb  6 21:23:44 2023 as: nmap -T5 -p- -Pn --min-rate 5000 -o nmap/nmap.pl 10.10.10.239
Warning: 10.10.10.239 giving up on port because retransmission cap hit (2).
Nmap scan report for 10.10.10.239
Host is up (0.038s latency).
Not shown: 64989 closed tcp ports (conn-refused), 527 filtered tcp ports (no-response)
PORT      STATE SERVICE
80/tcp    open  http
135/tcp   open  msrpc
139/tcp   open  netbios-ssn
443/tcp   open  https
445/tcp   open  microsoft-ds
3306/tcp  open  mysql
5000/tcp  open  upnp
5040/tcp  open  unknown
5985/tcp  open  wsman
5986/tcp  open  wsmans
7680/tcp  open  pando-pub
47001/tcp open  winrm
49664/tcp open  unknown
49665/tcp open  unknown
49666/tcp open  unknown
49667/tcp open  unknown
49668/tcp open  unknown
49669/tcp open  unknown
49670/tcp open  unknown

# Nmap done at Mon Feb  6 21:24:00 2023 -- 1 IP address (1 host up) scanned in 15.42 seconds
