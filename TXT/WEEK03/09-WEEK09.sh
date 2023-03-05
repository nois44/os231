#!/bin/bash
# 41:08AAE022
# REV01: Mon 12 Sep 2022 10:00
# START: Thu 18 Mar 2021 06:00

SEQ="09"

if   [ -f  98-include.sh ] ; then
    .  ./98-include.sh
elif [ -f  $HOME/bin/98-include.sh ] ; then
    .  $HOME/bin/98-include.sh
else
    echo "98-include.sh not found"
    exit
fi

[[ "$WEEK" != "09" ]] && error This script is for Week 09 only!

echo "TBA"
exit
