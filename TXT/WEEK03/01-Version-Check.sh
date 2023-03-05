#!/bin/bash
# 5C:B09DFD56
# REV05: Sun 19 Feb 2023 01:00
# REV04: Mon 21 Nov 2022 23:00
# REV03: Mon 03 Oct 2022 11:00
# REV02: Wed 14 Sep 2022 12:00
# REV01: Mon 12 Sep 2022 10:00
# START: Sat 06 Nov 2021 11:00

SEQ="01"

if   [ -f  98-include.sh ] ; then
    .  ./98-include.sh
else
    echo "98-include.sh not found"
    exit
fi

# ZCZC START #### #### #### ####
FILE="$WEEKDIR/WEEK$WEEK-$SEQ-VERSION.txt"
[ -f $FILE      ] && /bin/rm -f $FILE
[ -d $WEEKDIR/  ] || mkdir -pv $WEEKDIR/

pushd /tmp/
cat > version-check.sh << "EOF"
#!/bin/bash
# Simple script to list version numbers of critical development tools
export LC_ALL=C
bash --version | head -n1 | cut -d" " -f2-4
MYSH=$(readlink -f /bin/sh)
echo "/bin/sh -> $MYSH"
echo $MYSH | grep -q bash || echo "ERROR: /bin/sh does not point to bash"
unset MYSH

echo -n "Binutils: "; ld --version | head -n1 | cut -d" " -f3-
bison --version | head -n1

if [ -h /usr/bin/yacc ]; then
  echo "/usr/bin/yacc -> `readlink -f /usr/bin/yacc`";
elif [ -x /usr/bin/yacc ]; then
  echo yacc is `/usr/bin/yacc --version | head -n1`
else
  echo "yacc not found"
fi

echo -n "Coreutils: "; chown --version | head -n1 | cut -d")" -f2
diff --version | head -n1
find --version | head -n1
gawk --version | head -n1

if [ -h /usr/bin/awk ]; then
  echo "/usr/bin/awk -> `readlink -f /usr/bin/awk`";
elif [ -x /usr/bin/awk ]; then
  echo awk is `/usr/bin/awk --version | head -n1`
else
  echo "awk not found"
fi

gcc --version | head -n1
g++ --version | head -n1
grep --version | head -n1
gzip --version | head -n1
cat /proc/version
m4 --version | head -n1
make --version | head -n1
patch --version | head -n1
echo Perl `perl -V:version`
python3 --version
sed --version | head -n1
tar --version | head -n1
makeinfo --version | head -n1  # texinfo version
xz --version | head -n1

echo 'int main(){}' > dummy.c && g++ -o dummy dummy.c
if [ -x dummy ]
  then echo "g++ compilation OK";
  else echo "g++ compilation failed"; fi
rm -f dummy.c dummy
EOF

bash version-check.sh | tee -a $FILE
popd

fecho SCRIPT $(head -3 $0 | tail -1)
fecho STAMPX $(mkSTAMP)
fecho VERSUM $(versum $0)
fecho WEEKSQ $WEEK $SEQ
fecho XCHECK $(xcheck)
fecho VERDSK $(verdisk)
fecho VERLNX $(verkernel)
fecho ===== RESULT IN $FILE =====

exit 0

