#|/bin/bash
# This ugly script suppose to tell us how many tapes have been used more than six months ago, thus are available for recycling
# first part is triggered via cron just so we don't harass bacula direcotr too often
# crontab -l
# 5 * * * * /root/bin/bacula_cron_ask_director_about_Tapes.sh
# use seperate file bacula_cron_ask_director_about_Tapes.sh
# then  
# drop a copy of this script to  /usr/lib/check_mk_agent/local/bacula_tapes.sh 
# make it executable with chmod +x 

SIXMONTHSINSEC=15552000
ERRORTAPES=`cat /var/tmp/status_slots.lst|grep Error|wc -l`
RECYCLABLETAPES=`cat /var/tmp/RECYCLABLETAPES.lst`

if [ $RECYCLABLETAPES -lt 1 ] ; then
        status=2
        statustxt=CRITICAL
elif [ $RECYCLABLETAPES -lt 3 ] || [ $ERRORTAPES -gt 0 ] ; then
        status=1
        statustxt=WARNING
else
        status=0
        statustxt=OK
fi
echo "$status Backup_AvailableTapes RECYCLABLETAPES=$RECYCLABLETAPES;3;1;25; $statustxt - $RECYCLABLETAPES Free Tapes, $ERRORTAPES Error Tapes"
