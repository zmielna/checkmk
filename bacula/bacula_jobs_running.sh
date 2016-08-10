#!/bin/bash
JOBSRUNNING=`echo status director|bconsole|grep "is running"`
JOBSRUNNINGCOUNT=`echo status director|bconsole|grep "is running"|wc -l`

if [ $JOBSRUNNINGCOUNT -gt 0 ] ; then
        status=0
        statustxt=OK
	echo "$status Backup_JobsRunning JOBSRUNNINGCOUNT=$JOBSRUNNINGCOUNT;5;0;25; $statustxt - $JOBSRUNNING"
else
        status=0
        statustxt=OK
	echo "$status Backup_JobsRunning JOBSRUNNINGCOUNT=$JOBSRUNNINGCOUNT;5;0;25; $statustxt - No jobs currently running"
fi
