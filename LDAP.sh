 
 #First start by installing OpenLDAP, an open source implementation of LDAP and some traditional LDAP management utilities using the following commands.
 
 sudo apt install slapd ldap-utils
 
 #Next, allow requests to the LDAP server daemon through the firewall as shown.
 
 sudo ufw allow ldap
 
 #Now create a OpenLDAP administrative user and assign a password for that user. In the below command, a hashed value is created for the given password, take note of it, you will use it in the LDAP configuration file.
 
 slappasswd
 
 #hen create an LDIF file (ldaprootpasswd.ldif) which is used to add an entry to the LDAP directory.
 
 sudo vim ldaprootpasswd.ldif

#Add the following contents in it:


#explaining the attribute-value pairs above:

    #olcDatabase: indicates a specific database instance name and can be typically found inside /etc/openldap/slapd.d/cn=config.
    #cn=config: indicates global config options.
    #PASSWORD: is the hashed string obtained while creating the administrative user.
    

dn: olcDatabase={0}config,cn=config
changetype: modify
add: olcRootPW
olcRootPW: {SSHA}PASSWORD_CREATED


#Now copy the sample database configuration file for slapd into the /var/lib/ldap directory, and set the correct permissions on the file.

 sudo cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG
 sudo chown -R ldap:ldap /var/lib/ldap/DB_CONFIG
 sudo systemctl restart slapd


#Next, import some basic LDAP schemas from the /etc/openldap/schema directory as follows.

sudo ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/cosine.ldif 
sudo ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/nis.ldif
sudo ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/inetorgperson.ldif
 
 #Now add your domain in the LDAP database and create a file called ldapdomain.ldif for your domain.

sudo vim ldapdomain.ldif 
 
 #Add the following content in it (replace example with your domain and PASSWORD with the hashed value obtained before):
 
 dn: olcDatabase={1}monitor,cn=config
changetype: modify
replace: olcAccess
olcAccess: {0}to * by dn.base="gidNumber=0+uidNumber=0,cn=peercred,cn=external,cn=auth"
  read by dn.base="cn=Manager,dc=example,dc=com" read by * none

dn: olcDatabase={2}hdb,cn=config
changetype: modify
replace: olcSuffix
olcSuffix: dc=example,dc=com

dn: olcDatabase={2}hdb,cn=config
changetype: modify
replace: olcRootDN
olcRootDN: cn=Manager,dc=example,dc=com

dn: olcDatabase={2}hdb,cn=config
changetype: modify
add: olcRootPW
olcRootPW: {SSHA}PASSWORD

dn: olcDatabase={2}hdb,cn=config
changetype: modify
add: olcAccess
olcAccess: {0}to attrs=userPassword,shadowLastChange by
  dn="cn=Manager,dc=example,dc=com" write by anonymous auth by self write by * none
olcAccess: {1}to dn.base="" by * read
olcAccess: {2}to * by dn="cn=Manager,dc=example,dc=com" write by * read


#Then add the above configuration to the LDAP database with the following command.

 sudo ldapmodify -Y EXTERNAL -H ldapi:/// -f ldapdomain.ldif


#In this step, we need to add some entries to our LDAP directory. Create another file called baseldapdomain.ldif with the following content.

dn: dc=example,dc=com
objectClass: top
objectClass: dcObject
objectclass: organization
o: example com
dc: example

dn: cn=Manager,dc=example,dc=com
objectClass: organizationalRole
cn: Manager
description: Directory Manager

dn: ou=People,dc=example,dc=com
objectClass: organizationalUnit
ou: People

dn: ou=Group,dc=example,dc=com
objectClass: organizationalUnit
ou: Group 


#Save the file and then add the entries to the LDAP directory.

sudo ldapadd -Y EXTERNAL -x -D cn=Manager,dc=example,dc=com -W -f baseldapdomain.ldif

#he next step is to create a LDAP user for example, xxxxx, and set a password for this user as follows.

sudo useradd xxxxx
sudo passwd  xxxxx


#Then create the definitions for a LDAP group in a file called ldapgroup.ldif with the following content.

dn: cn=Manager,ou=Group,dc=example,dc=com
objectClass: top
objectClass: posixGroup
gidNumber: 1005


#In the above configuration, gidNumber is the GID in /etc/group for tecmint and add it to the OpenLDAP directory

sudo ldapadd -Y EXTERNAL -x  -W -D "cn=Manager,dc=example,dc=com" -f ldapgroup.ldif

# Next, create another LDIF file called ldapuser.ldif and add the definitions for user xxxxx.

dn: uid=tecmint,ou=People,dc=example,dc=com
objectClass: top
objectClass: account
objectClass: posixAccount
objectClass: shadowAccount
cn: xxxxx
uid: xxxxx
uidNumber: 1005
gidNumber: 1005
homeDirectory: /home/xxxxx
userPassword: {SSHA}PASSWORD_HERE
loginShell: /bin/bash
gecos: tecmint
shadowLastChange: 0
shadowMax: 0
shadowWarning: 0

#then load fthe configuration to the LDAP directory.

 ldapadd -Y EXTERNAL  -x -D cn=Manager,dc=example,dc=com -W -f  ldapuser.ldif

