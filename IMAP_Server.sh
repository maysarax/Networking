

    sudo apt-get update

    sudo apt-get install dovecot-imapd dovecot-pop3d

    #Configure the protocol you need to be used by appending the protocol in the file /etc/dovecot/dovecot.conf:

    protocols = pop3 pop3s imap imaps

    #Choose the mailbox you would like to use. Dovecot supports maildir and mbox formats. Edit the file /etc/dovecot/dovecot.conf and change the line

    mail_location = maildir:~/Maildir # (for maildir)

    or

    mail_location = mbox:~/mail:INBOX=/var/spool/mail/%u # (for mbox)

    #Restart the service

    sudo /etc/init.d/dovecot restart

    #Use telnet to check that dovecot is working properly.

    telnet localhost imap


#PHP

#sudo apt-get update
#sudo apt-get install php7.0-imap


