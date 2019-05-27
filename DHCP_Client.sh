#Login to the client computers and edit the Ethernet interface configuration file as follows (take note of the interface name/number):


sudo vi /etc/network/interfaces

#And define the options below:

auto  eth0
iface eth0 inet dhcp

#Save the file and exit. And restart network services like so (or reboot the system):

------------ SystemD ------------ 
 sudo systemctl restart networking

------------ SysVinit ------------ 
 sudo service networking restart
 
