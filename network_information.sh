#!/bin/sh


RED="\033[1;31m"
GREEN="\033[1;32m"
NOCOLOR="\033[0m"

echo

echo  " ${GREEN}  ifconfig   ${NOCOLOR}"

ifconfig -a

echo


echo

echo " ${GREEN}    resolv ${NOCOLOR}"

cat /etc/resolv.conf

echo


echo

echo  " ${GREEN}  route   ${NOCOLOR}"

route -n


echo


echo

echo  " ${GREEN}   arp  ${NOCOLOR}"

arp -n

echo
