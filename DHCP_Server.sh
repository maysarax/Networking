
sudo apt-get install isc-dhcp-server

#start DHCP with default dhcpd.conf configuration file
#open and modify the main configuration file, define your DHCP server options:

sudo vi /etc/dhcp/dhcpd.conf 
#Set the following global parameters at the top of the file, they will apply to all the declarations below (do specify values that apply to your scenario):



option domain-name "xxxx.lan";
option domain-name-servers ns1.tecmint.lan, ns2.tecmint.lan;
default-lease-time 3600; 
max-lease-time 7200;
authoritative;

#define a subnetwork; here, we’ll setup DHCP for 192.168.10.0/24 LAN network (use parameters that apply to your scenario).

subnet 0.0.0.0 netmask 255.255.255.0 {
        option routers                  0.0.0.0;
        option subnet-mask              255.255.255.0;
        option domain-search            "xxxx.lan";
        option domain-name-servers      0.0.0.0;
        range   0.0.0.0   0.0.0.0;
        range   0.0.0.0   0.0.0.0;
}



#To assign a fixed (static) IP address to a particular client computer, add the section below where you need to explicitly specify it’s MAC addresses and the IP to be statically assigned:



host centos-node {
	 hardware ethernet 00:f0:m4:6y:89:0g;
	 fixed-address 192.168.10.105;
 }

host fedora-node {
	 hardware ethernet 00:4g:8h:13:8h:3a;
	 fixed-address 192.168.10.106;
 }
 
 
 
 
 #Next, start the DHCP service for the time being, and enable it to start automatically from the next system boot, like so:

------------ SystemD ------------ 
 sudo systemctl start isc-dhcp-server.service
 sudo systemctl enable isc-dhcp-server.service


------------ SysVinit ------------ 
 sudo service isc-dhcp-server.service start
 sudo service isc-dhcp-server.service enable



#Next, do not forget to permit DHCP service (DHCPD daemon listens on port 67/UDP) on firewall as below:


 sudo ufw allow  67/udp
 sudo ufw reload
 sudo ufw show

# /var/log/syslog 

#service isc-dhcp-server restart
#sudo apt-get install isc-dhcp-relay

