#!/bin/bash
# 2C:AF989B54
# REV03: Sun 26 Feb 2023 17:00
# REV02: Mon 26 Sep 2022 00:00
# START: Sun 27 Feb 2022 17:00

SEQ="03"

if   [ -f  98-include.sh ] ; then
    .  ./98-include.sh
else
    echo "98-include.sh not found"
    exit
fi

[[ "$WEEK" != "03" ]] && error Week 03 only

# ZCZC START #### #### #### ####
FILE="$WEEKDIR/WEEK$WEEK-$SEQ-DISK-CHECK.txt"
W03DIR="$LFS/$WHOAMI/"
[ -d $W03DIR    ] || error "No $W03DIR directory"
[ -f $FILE      ] && /bin/rm -f $FILE
[ -d $HOME/bin/ ] || mkdir -pv $HOME/bin/
[ -d $WEEKDIR/  ] || mkdir -pv $WEEKDIR/

fecho SCRIPT $(head -3 $0 | tail -1)
fecho STAMPX $(mkSTAMP)
fecho VERSUM $(versum $0)
fecho WEEKSQ $WEEK $SEQ
fecho VERDSK $(verdisk)
fecho VERLNX $(verkernel)
fecho CHDATE $(date '+%y%m%d %H%M')
fecho CMOUNT $(cat /proc/mounts | grep lfs)
if [ -w "$W03DIR" ] ; then
    fecho FSWRITE $(echo "Date: $(date)" | tee ${W03DIR}$WHOAMI.txt)
    if [ -f $W03DIR/$WHOAMI.txt ] ; then
      fecho LSFILE $(ls -alR ${W03DIR}$WHOAMI.txt)
      fecho CHKUSR $(cat ${W03DIR}$WHOAMI.txt)
    fi
else
    fecho ERROR FILESYSTEM
fi
fecho ===== RESULT IN $FILE =====

exit 0

