#!/bin/sh

cat lga.csv | sed 's/ ([A-Z][A-Z]*)//g' | sed 's/,-/,0/g' \
		| awk -F, 'NR==1 || $2>=40000 && $2<50000 && $1>=2012 && $1<=2013 {printf "%s,%s,%s,%s,%s", $1,$3,$7,$11,$15; for (i=16; i<37; i++){if ($i=="-") {printf ",0"} else{ printf ",%s",$i} } printf "\n"}' >lga-2012-2013.csv
cat lga.csv | sed 's/ ([A-Z][A-Z]*)//g' | sed 's/,-/,0/g' \
		| awk -F, 'NR==1 || $2>=40000 && $2<50000 {printf "%s,%s,%s,%s,%s", $1,$3,$7,$11,$15; printf "\n"}' >lga-2009-2013.csv
