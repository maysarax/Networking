
sudo apt-get update

sudo apt-get install  -y  nfs-common


#Mount NFS shares on client

showmount -e 0.0.0.0

#Create a directory /share on the client machine to mount the shared directory

mkdir /mnt/share

#Use mount command to mount a shared directory /nfsshare from NFS server (0.0.0.0) in /mnt/share on the client machine.

mount 0.0.0.0:/nfsshare /mnt/share


#Verify the mounted share on the client machine using the mount command.

mount | grep nfs

#You can also use df command to check the mounted NFS shares.


df -hT


#Automount NFS Shares

vi /etc/fstab

0.0.0.0:/nfsshare/ /mnt/share nfs rw,sync,hard,intr 0 0


#Reboot the client machine and check whether NFS share is automatically mounted or not.

reboot

#Verify the mounted share on the client-server using the mount command.

mount | grep nfs

#To unmount the shared directory from your client machine, use the umount command to unmount it.


umount /mnt/share

