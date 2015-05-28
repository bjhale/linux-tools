#!/bin/bash
#
# Flush all current rules from iptables
#
 clear
 echo "Flushing Firewall"
 iptables -F
 ip6tables -F
#
# Allow SSH connections on tcp port 22
# This is essential when working on remote servers via SSH to prevent locking yourself out of the system
#
 iptables -A INPUT -p tcp --dport 22 -j ACCEPT
 ip6tables -A INPUT -p tcp --dport 22 -j ACCEPT
#
# Set default policies for INPUT, FORWARD and OUTPUT chains
#
 iptables -P INPUT DROP
 ip6tables -P INPUT DROP
 iptables -P FORWARD DROP
 ip6tables -P FORWARD DROP
 iptables -P OUTPUT ACCEPT
 ip6tables -P OUTPUT ACCEPT
#
# Set access for localhost
#
 iptables -A INPUT -i lo -j ACCEPT
 ip6tables -A INPUT -i lo -j ACCEPT
#
# Accept packets belonging to established and related connections
#
 iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
 ip6tables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
#
# Accept web traffic
#
 iptables -A INPUT -p tcp --dport 80 -j ACCEPT 
 ip6tables -A INPUT -p tcp --dport 80 -j ACCEPT
 iptables -A INPUT -p tcp --dport 443 -j ACCEPT
 ip6tables -A INPUT -p tcp --dport 443 -j ACCEPT
#
# Save settings
#
 echo "Saving Firewall Settings\n\n"
 /sbin/service iptables save
 /sbin/service ip6tables save
#
# List rules
#
 echo "IPTABLES:---------------------------------------\n\n"
 iptables -L -v
 echo "\n\nIP6TABLES:---------------------------------------\n\n"
 ip6tables -L -v
