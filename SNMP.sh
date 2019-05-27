sudo apt-get update

sudo apt-get install snmpd snmp

updatedb
locate snmpd.con

#Open the /etc/snmp/snmp.conf file in your text editor with sudo privileges

sudo nano /etc/snmp/snmp.conf



agentAddress udp:127.0.0.1:161
view systemonly included .1.3.6.1.2.1.1
view systemonly included .1.3.6.1.2.1.25.1
rocommunity public default -V systemonly
rocommunity6 public default -V systemonly
rouser authOnlyUser
sysLocation Sitting on the Dock of the Bay
sysContact Me <me@example.org>
sysServices 72
proc mountd
proc ntalkd 4
proc sendmail 10 1
disk / 10000
disk /var 5%
includeAllDisks 10%
load 12 10 5
trapsink localhost public
iquerySecName internalUser
rouser internalUser
defaultMonitors yes
linkUpDownNotifications yes
extend test1 /bin/echo Hello, world!
extend-sh test2 echo Hello, world! ; echo Hi there ; exit 35
master agentx


#Here is the new file with our configuration.



systemctl status snmpd
