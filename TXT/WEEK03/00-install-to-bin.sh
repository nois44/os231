#!/bin/bash
# 1C:C2FDB4CC
# REV03: Sun 19 Feb 2023 04:00
# REV02: Wed 14 Sep 2022 12:00
# REV01: Mon 12 Sep 2022 09:00
# START: Sat 06 Nov 2021 11:00

SEQ="00"

if   [ -f  98-include.sh ] ; then
    .  ./98-include.sh
else
    echo "98-include.sh not found"
    exit
fi

# ZCZC START #### #### #### ####
FILE="$WEEKDIR/WEEK$WEEK-$SEQ-INSTALL.txt"
[ -f $FILE      ] && /bin/rm -f $FILE
[ -d $WEEKDIR/  ] || mkdir -pv $WEEKDIR/
fecho SCRIPT    $(head -3 $0 | tail -1)
fecho STAMPX    $(mkSTAMP)
fecho VERSUM    $(versum $0)
fecho WEEKSQ    $WEEK $SEQ
fecho VERDSK    $(verdisk)
fecho VERLNX    $(verkernel)
fecho ===== RESULT IN $FILE =====

exit 0

