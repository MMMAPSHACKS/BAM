#!/bin/sh

if [ "$1" == "" ]; then
	echo "usage: $0 year"
	exit 1
fi

yr=$1

cat | awk -F, -v year=$yr '
NR>1{ 
	if (year>0 && int($3) == year) { companies[$1] += 1; tot += 1 }
	else if (year==0) {
		for (yr=2001; yr<=2014; yr++) {
			if (int($3) == yr) { 
				split("",data)
				data[yr] += 1; tot += 1 
				companies[$1] = data;
			}
		}
	}
}
END { 
		for (yr=2001; yr<=2014; yr++) {
			printf("%d,",yr)
		}
		printf("\n")
		for (i in companies) {
			printf "%d,",i
			data = companies[i]
			for (y=2001; y<=2014; y++)
				printf "%d,", data[y]
			printf("\n")
		}
		printf("%d,Total,%d\n",year,tot)
	}
'
