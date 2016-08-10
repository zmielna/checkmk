#!/bin/bash
# /usr/lib/check_mk_agent/local/do_we_have_todays_snapshot.sh
HOWMANYSNAPS=/sbin/zfs list -t snapshot|grep vmfs |grep `date +"%Y-%m-%d"`|wc -l

if [ $HOWMANYSNAPS -lt 1 ] ; then
        status=2
        statustxt=CRITICAL
else
        status=0
        statustxt=OK
fi
echo "$status VMFS_replication HOWMANYSNAPS=$HOWMANYSNAPS;3;1;25; $statustxt - $HOWMANYSNAPS snapshot of VMFS filesystem replicated"
