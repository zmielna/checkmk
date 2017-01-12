#!/bin/bash
# we rely on update-notifier-common
# apt-get install -y update-notifier-common
# if emtpy output from /usr/lib/update-notifier/update-motd-updates-available then
# sudo /usr/lib/update-notifier/update-motd-updates-available --force


#SECUPD=`/usr/lib/update-notifier/update-motd-updates-available|tail -n2|head -n1|cut -d" " -f1`
#SECTEXT=`/usr/lib/update-notifier/update-motd-updates-available |xargs`
SECUPD=`/usr/lib/update-notifier/apt-check --human-readable|tail -n1|cut -d" " -f1`
SECTEXT=`/usr/lib/update-notifier/apt-check --human-readable |xargs`

if [ $SECUPD -gt 2 ] ; then
        status=2
        statustxt=CRITICAL
elif [ $SECUPD -gt 0 ] ; then
        status=2
        statustxt=WARNING
else
        status=0
        statustxt=OK
fi


echo "$status Ubuntu_Security_Patches PACKAGES=$SECUPD;1;5 $statustxt - $SECTEXT"
