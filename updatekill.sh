#!/bin/sh

export LANG=C;

LOGDIR="./log";
GREP_STR="UPDATE";
TIME_OUT="10";

MYSQL="mysql --defaults-extra-file=./config/dbaccess.conf"
TMP1=./tmp.txt;

NOW=`date +"%Y%m%d_%p_%I%M%S"`
TODAY=`date +"%Y%m%d";`
LOG_FILE="$LOGDIR/kill_$TODAY.log";

$MYSQL -e "show full processlist;" | grep "$GREP_STR" > $TMP1

echo "--- $NOW ---" >> $LOG_FILE;
while read line;
do
    pid=`echo ${line} | cut -d " " -f 1`
    time=`echo ${line} | cut -d " " -f 6`

    if [ $time -gt $TIME_OUT ];
    then
        echo "$line" >> $LOG_FILE;
        $MYSQL -e "kill $pid;"
        echo "pid=$pid,time=$time killed";
    fi;
done < $TMP1;
rm $TMP1;
