#!/bin/bash
# 41:08AAE022
# REV02: Sun 19 Feb 2023 01:00
# REV01: Mon 12 Sep 2022 10:00
# START: Thu 18 Mar 2021 06:00

SEQ="02"

if   [ -f  98-include.sh ] ; then
    .  ./98-include.sh
elif [ -f  $HOME/bin/98-include.sh ] ; then
    .  $HOME/bin/98-include.sh
else
    echo "98-include.sh not found"
    exit
fi

[[ "$WEEK" != "02" ]] && error This script is for Week 02 only!

echo "XYZZY... Nothing Happens..."
exit
exit
