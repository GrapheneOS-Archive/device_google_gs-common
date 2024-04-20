#!/vendor/bin/sh

DIR=/data/vendor/dump_touch
LOCKFILE="$DIR"/dumping
LOGFILE="$DIR"/dump.log

if [ ! -f $LOCKFILE ]
then
	echo "-----------------------------------------------------"
	echo "Error : PreDump Touch Logs couldn't be found."
	echo "-----------------------------------------------------"
	exit 2
fi

state=$(cat $LOCKFILE)
if [ "$state" != 2 ]
then
  echo "Unexpected state! Expected 2 but found ${state}" >> $LOGFILE
fi

cat $LOGFILE
echo "" > $LOGFILE

echo 0 > $LOCKFILE

