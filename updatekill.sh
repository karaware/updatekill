#!/bin/sh

export LANG=c;

LOGDIR="./log";
GREP_STR="UPDATE";
TIME_OUT="10";

MYSQL="mysql --defaults-extra-file=./config/dbaccess.conf"
SHOW="show full processlist;"
TMP1=./tmp.txt;

NOW=`date +"%Y%m%d_%p_%I%M%S"`
TODAY=`date +"%Y%m%d";`
KILL_TARGET_FILE="$LOGDIR/kill_$NOW.txt";
LOG_FILE="$LOGDIR/kill_$TODAY.log";

echo $SHOW | $MYSQL | grep "$GREP_STR" > $TMP1

echo "--- $NOW ---" >> $LOG_FILE;
while read line;
do
    pid=`echo ${line} | cut -d " " -f 1`
    time=`echo ${line} | cut -d " " -f 6`

    if [ $time -gt $TIME_OUT ];
    then
        echo "kill $pid;" >> $KILL_TARGET_FILE;
        echo "$line" >> $LOG_FILE;
        $MYSQL < $KILL_TARGET_FILE;
         echo "pid=$pid,time=$time killed";
        rm $KILL_TARGET_FILE;
    fi;
done < $TMP1;
rm $TMP1;
