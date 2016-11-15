#!/bin/bash
# ZFSLOG=`zpool iostat -v |grep ada1p1|cut -d" " -f11`
ZFSLOG=`zpool iostat -v|grep mirror|column -t|cut -d" " -f3`
# ZFSCACHE=`zpool iostat -v |grep cache0|cut -d" " -f7`
ZFSCACHE1=`zpool iostat -v |grep sdm6|column -t|cut -d" " -f3`
ZFSCACHE2=`zpool iostat -v |grep sdn6|column -t|cut -d" " -f3`
#ZFSLOG=3.00G
#ZFSCACHE=5.00G

# ------------------------- log info
case $ZFSLOG in
*K)
  ZFSLOGm=`echo $ZFSLOG|sed 's/.$//'`
  ZFSLOGg=`echo "scale=10; $ZFSLOGm*0.00001"| bc`
  Message="0 ZFS_LOG ZFSLOG_Size=$ZFSLOGg;3;4 Current size of used ZFS log device is $ZFSLOG/4GB"
  ;;
*M)
  ZFSLOGm=`echo $ZFSLOG|sed 's/.$//'`
  ZFSLOGg=`echo "scale=10; $ZFSLOGm*0.001"| bc`
  Message="0 ZFS_LOG ZFSLOG_Size=$ZFSLOGg;3;4 Current size of used ZFS log device is $ZFSLOG/4GB"
  ;;
*G)
  ZFSLOGg=`echo $ZFSLOG|sed 's/.$//'`
  Message="0 ZFS_LOG ZFSLOG_Size=$ZFSLOGg;3;4 Current size of used ZFS log device is $ZFSLOG/4GB"
  ;;
*)
  Message="I seem to be running with an nonexistent ZFS cache/log information..."
esac

echo $Message

# ------------------------- cache disk 0
case $ZFSCACHE1 in
*M)
  ZFSCACHE1m=`echo $ZFSCACHE1|sed 's/.$//'`
  ZFSCACHE1g=`echo "$ZFSCACHE1m*0.001"| bc`
  Message="0 ZFS_CACHE1 ZFSCACHE1_Size=$ZFSCACHE1g;30;32 Current size of used ZFS cachae device is $ZFSCACHE1/32GB"
  ;;
*G)
  ZFSCACHE1m=`echo $ZFSCACHE1|sed 's/.$//'`
  Message="0 ZFS_CACHE1 ZFSCACHE1_Size=$ZFSCACHE1m;30;32 Current size of used ZFS cache device is $ZFSCACHE1/32GB"
  ;;
*)
  Message="I seem to be running with an nonexistent ZFS cache/log information..."
esac

echo $Message

# ------------------------- cache disk 1
case $ZFSCACHE2 in
*M)
  ZFSCACHE2m=`echo $ZFSCACHE2|sed 's/.$//'`
  ZFSCACHE2g=`echo "$ZFSCACHE2m*0.001"| bc`
  Message="0 ZFS_CACHE2 ZFSCACHE2_Size=$ZFSCACHE2g;30;32 Current size of used ZFS cache device is $ZFSCACHE2/32GB"
  ;;
*G)
  ZFSCACHE2m=`echo $ZFSCACHE2|sed 's/.$//'`
  Message="0 ZFS_CACHE2 ZFSCACHE2_Size=$ZFSCACHE2m;30;32 Current size of used ZFS cache device is $ZFSCACHE2/32GB"
  ;;
*)
  Message="I seem to be running with an nonexistent ZFS cache/log information..."
esac

echo $Message
