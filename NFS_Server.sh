sudo  apt-get update
sudo  apt-get upgrade
sudo  apt-get install -y nfs-kernel-server nfs-common

#Confirm that NFS server is up and runing: 

systemctl status nfs-kernel-server

#Create NFS share

mkdir /nfsshare

#Allow client machines to read and write to the created directory.

chmod 777 /nfsshare/

#Export NFS share

#Modify /etc/exports files for exporting NFS share.

vi /etc/exports

#Make an entry of the directory /nfsshare to export as NFS share.


/nfsshare 0.0.0.0(rw,sync,no_root_squash,no_subtree_check)




#/nfsshare : A shared directory

#0.0.0.0 : IP address of the client machine. You can use the hostname instead of an IP address. Also, you can mention subnets like 192.168.1.0/24 in case you want to share it to multiple machines.

#rw : Writable permission to a shared folder

#sync : all changes to the filesystem are immediately flushed to disk; the respective write operations are being waited for.

#no_root_squash : By default, any file created by the user root on the client machine is treated as “nobody” on the server. If no_root_squash is set, then root on the client machine will have the same level of access to files, as root on the server.

#no_subtree_check : If only part of a volume is exported, a routine called subtree checking verifies that a file that is requested by the client is in the appropriate part of the volume. If the entire volume is exported, disable it with no_subtree_check; this will speed up transfers.

#You can get to know all the option on the man page (man exports) or here.



#Use the below command to export the shared directories.


exportfs -ra


#erify the exported share using below command.

showmount -e 0.0.0.0

