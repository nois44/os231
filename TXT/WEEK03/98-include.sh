#!/bin/bash
# REV19: Sun 26 Feb 2023 15:00
# REV09: Sun 19 Feb 2023 00:00
# REV05: Sun 30 Oct 2022 14:00
# REV03: Mon 26 Sep 2022 00:00
# REV01: Mon 12 Sep 2022 09:00
# START: Sun 20 Feb 2022 16:00

WEEK="03"
LFSDIR="/mnt/lfs"
WEEKDIR="$HOME/RESULT/W$WEEK"
CPLIST=""
WHOAMI=$(whoami)
MYGROUP=$(id -gn)
MYHOST=$(hostname)
MYHOME=$(echo ~/)
export PATH="$HOME/bin/:$PATH"
error() {
    echo "ZCZC ERROR $@" | tee -a $FILE
    exit 1
}
fecho(){
    echo "ZCZC $@" | tee -a $FILE
}
mkSTAMP() {
   local EXSTAMP=$(printf "%8.8X" $(( $(date +%s) & 16#FFFFFFFF )) )
   local EXCHSUM="XXXXXXXX"
   [ "$(hostname)" = "$WHOAMI" ] && {
       EXCHSUM=$(echo "$USER$EXSTAMP"|sha1sum|tr '[a-z]' '[A-Z]'| cut -c1-8)
   }
   echo  "$EXSTAMP $EXCHSUM $WHOAMI"
}
verdisk() {
    local FSYS1="/"
    local FSYS2="/mnt/lfs/"
    local tmpVAR=$(df -h "$FSYS1"|tail -1|awk '{print $1}';)
    [ -d "$FSYS2" ] && tmpVAR="$tmpVAR $(df -h "$FSYS2" |tail -1|awk '{print $1}';)"
    df -h $tmpVAR|tail -2|awk '{print $2}';
    for II in $tmpVAR ; do
      ls -l /dev/disk/by-uuid/ | grep $(basename $II) | awk '{print $9}'|tr '[a-z]' '[A-Z]'|cut -d- -f5,5
    done
}
verkernel() {
    cat /proc/version | cut -d' ' -f3,3
}
versum() {
    CFILE=$1
    printf "%X:%s " $(tail -n +3 $CFILE|wc -l) $(tail -n +3 $CFILE|sha1sum|cut -c1-8|tr '[a-z]' '[A-Z]')
    head -2 $CFILE|tail -1|cut -c3-
}
reportDir() {
    [ -d $1 ] || { fecho "ERROR $1 not found"; return; }
    local tmpVAR="$(find $1 -type d|wc) $(find $1 -type f|wc) $(du -s $1)"
    fecho "$(echo $tmpVAR|awk '{print "CHKDIR", $8, $2, $3, $4, $6, $7}')"
}
xcheck() {
    echo "HOST $MYHOST USER $WHOAMI GROUP $MYGROUP HOME $MYHOME ARCH $(arch) NPROC $(nproc)"
}
