#!/bin/bash
ZFSLOG=`zpool iostat -v |grep ada1p1|cut -d" " -f11`
ZFSCACHE=`zpool iostat -v |grep ada1p2|cut -d" " -f11`
#ZFSLOG=3.00G
#ZFSCACHE=5.00G

# ------------------------- log info
case $ZFSLOG in
*M)
  ZFSLOGm=`echo $ZFSLOG|sed 's/.$//'`
  ZFSLOGg=`echo "scale=10; $ZFSLOGm*0.001"| bc`
  Message="0 ZFS_LOG ZFSLOG_Size=$ZFSLOGg;9;10 Current size of used ZFS log device is $ZFSLOG/10GB"
  ;;
*G)
  ZFSLOGg=`echo $ZFSLOG|sed 's/.$//'`
  Message="0 ZFS_LOG ZFSLOG_Size=$ZFSLOGg;9;10 Current size of used ZFS log device is $ZFSLOG/10GB"
  ;;
*)
  Message="I seem to be running with an nonexistent ZFS cache/log information..."
esac

echo $Message

# ------------------------- cache
case $ZFSCACHE in
*M)
  ZFSCACHEm=`echo $ZFSCACHE|sed 's/.$//'`
  ZFSCACHEg=`echo "$ZFSCACHEm*0.001"| bc`
  Message="0 ZFS_CACHE ZFSCACHE_Size=$ZFSCACHE;60;65 Current size of used ZFS cachae device is $ZFSCACHE/65GB"
  ;;
*G)
  ZFSCACHEm=`echo $ZFSCACHE|sed 's/.$//'`
  Message="0 ZFS_CACHE ZFSCACHE_Size=$ZFSCACHEm;60;65 Current size of used ZFS cache device is $ZFSCACHE/65GB"
  ;;
*)
  Message="I seem to be running with an nonexistent ZFS cache/log information..."
esac

echo $Message
