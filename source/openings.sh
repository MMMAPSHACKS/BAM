#!/bin/sh

if [ "$1" == "" ]; then
	echo "usage: $0 year"
	exit 1
fi

yr=$1

cat | awk -F, -v year=$yr '
NR>1{ 
	if (int($3) == year) { companies[$1] += 1; tot += 1 }
}
END { for (i in companies) {
		printf "%d,%s,%d\n", year, i, companies[i]
	}
	printf("Total,%d\n",tot)
}
'