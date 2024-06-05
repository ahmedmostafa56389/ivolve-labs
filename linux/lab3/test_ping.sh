#!/bin/bash

subnet ="192.168.1"

for ((i=0; i<=255; i++)); do
	ip="$subnet.$i"
	if ping -c  1  "$ip" &> /dev/null; then
		echo " Server $ip is up and running"
	else 
		echo " Server $ip is unreachable"
	fi
done 
