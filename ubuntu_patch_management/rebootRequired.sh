#!/bin/bash

if [ -a /var/run/reboot-required.pkgs ] ; then
	PKGS=`cat /var/run/reboot-required.pkgs|wc -l`
	else
	PKGS=0
fi

if [ -a /var/run/reboot-required ] ; then
		status=2
		statustxt=CRITICAL
		echo "$status RebootRequired PKGS=$PKGS;1;2 $statustxt - *** System restart required *** $PKGS core packages updated"
	else
		status=0
		statustxt=OK
		echo "$status RebootRequired PKGS=$PKGS;1;2 $statustxt - *** Restart not required *** $PKGS core packages updated"
fi
