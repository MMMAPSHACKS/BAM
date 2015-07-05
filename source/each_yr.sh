#!/bin/sh

f="$1"
s="$2"
if [ "$f" = "" -o "$s" = "" ]; then
	echo "usage: $0 data_file script"
fi

y=2001; while [ $y -le 2014 ]; do 
	y=`expr $y + 1`
	cat "$f" | "$s" $y 
done
