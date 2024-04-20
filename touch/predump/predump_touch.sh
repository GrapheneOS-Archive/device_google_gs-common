#!/vendor/bin/sh

DIR=/data/vendor/dump_touch
SCRIPT_DIR=/vendor/bin/dump_touch
LOCKFILE="$DIR"/dumping
LOGFILE="$DIR"/dump.log

if [ ! -f $LOCKFILE ]
then
#Init Setup
  echo 0 > $LOCKFILE
  echo "" > $LOGFILE
  chmod 660 $LOCKFILE
  chmod 660 $LOGFILE
fi

echo $(date) >> $LOGFILE

state=$(cat $LOCKFILE)
if [ "$state" != 0 ]
then
  echo "Unexpected state! Expected 0 but found ${state}" >> $LOGFILE
fi

echo 1 > $LOCKFILE

for entry in "$SCRIPT_DIR"/*.sh
do
  echo "----------------------------------" >> $LOGFILE
  echo "$entry" >> $LOGFILE
  echo "----------------------------------" >> $LOGFILE
  sh $entry >> $LOGFILE
  echo "----------------------------------" >> $LOGFILE
done

state=$(cat $LOCKFILE)
if [ "$state" != 1 ]
then
  echo "Unexpected state! Expected 1 but found ${state}" >> $LOGFILE
fi

echo 2 > $LOCKFILE


