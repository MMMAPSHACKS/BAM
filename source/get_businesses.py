# compute business duration records

import csv

businesses = {}
header = {}
rownum = 0
with open('sa.txt', 'rb') as f:
	rdr = csv.reader(f, delimiter='\t')
	for row in rdr:
		rownum += 1
		if rownum == 1:
			colnum = 0
			while colnum < len(row):
				header[ row[colnum] ] = colnum
				colnum += 1
		else:
			abn = row[ header['ABN'] ]
			if not (abn in businesses):
				#print "adding " + abn
				businesses[abn] = { 'ABN':abn }
				businesses[abn]['Postcode'] = row[ header['Postcode'] ]
				if row[ header['ABNStatus'] ] == 'ACT':
					businesses[abn]['StartYear'] = row[ header['ABNStatusFromDate'] ][:6]
				else:
					businesses[abn]['EndYear'] = row[ header['ABNStatusFromDate'] ][:6]

print "Postcode,ABN,StartYear,EndYear"
for abn in businesses.keys():
	b = businesses.get(abn)
	
	if 'StartYear' in b:
		by = b.get('StartYear')
		yr = int(by[:4])
		beginyr = float(yr) + float(by[5:6])/12.0
	else:
		beginyr = 0.0

	if 'EndYear' in b:
		ey = b.get('EndYear')
		yr = int(ey[:4])
		endyr = float(yr) + float(ey[5:6])/12.0
	else:
		endyr = 0.0
	print b.get('Postcode'),b.get('ABN'),beginyr,endyr

