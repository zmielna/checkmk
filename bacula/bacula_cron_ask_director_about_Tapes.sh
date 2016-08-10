#!/bin/bash
# This ugly script is meant to gather info from bacula director once per hour and stick output to bunch of files used later by check_mk local script
# see seperate file bacula_checkmk_free_tapes.sh
SIXMONTHSINSEC=15552000
echo "list volumes pool=lto5-pool" |bconsole > /var/tmp/list_volumes.lst
echo "status slots storage=TapeLibrary drive=0" |bconsole  > /var/tmp/status_slots.lst
for i in `cat /var/tmp/status_slots.lst |cut -d"|" -f2|tr -s " "|grep ABC`;do grep $i /var/tmp/list_volumes.lst|cut -d"|" -f13|tr -s " "|cut -d" " -f2;done > /var/tmp/last_used.lst
for i in `cat /var/tmp/last_used.lst`;do date -d $i +%s;done > /var/tmp/last_used_epoch.lst
for THEN in `cat /var/tmp/last_used_epoch.lst`;do NOW=`date +%s`;let DIFF=$NOW-$THEN;echo $DIFF;done > /var/tmp/epoch_diff.lst
for epoch_diff in `cat /var/tmp/epoch_diff.lst`; do let DIFF2=$epoch_diff-$SIXMONTHSINSEC;echo $DIFF2;done|grep -v "-"|wc -l > /var/tmp/RECYCLABLETAPES.lst
