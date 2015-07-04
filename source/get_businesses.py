# compute business duration records

import csv
import sys

for arg in sys.argv:
	if arg == "-a":
		all = True
	else:
		all = False

	if arg == "-n":
		known_start = True
	else:
		known_start = False

	if arg == "-c":
		current = True
	else:
		current = False

	if arg == "-i":
		inactive = True
	else:
		inactive = False

	if arg == "-o":
		old = True
	else:
		old = False

	if arg == '-h':
		print "usage: get_business.py [-a] [-n] [-c] [i] [-o]"
		print ""
		print " where:"
		print "    -a -> all"
		print "    -n -> new businesses (known start date)"
		print "    -c -> current businesses (still active)"
		print "    -i -> inactive (closed)"
		print "    -o -> old busness (no start date given)"
		exit(0)


asic = {}
asic_header = {}
rownum = 0
with open('names.csv', 'rb') as f:
	rdr = csv.reader(f, delimiter='\t')
	for row in rdr:
		rownum += 1
		if rownum == 1:
			colnum = 0
			while colnum < len(row):
				asic_header[ row[colnum] ] = colnum
				colnum += 1
		else:
			abn = row[ asic_header['ABN'] ]
			if not (abn in asic):
				asic[abn] = { 'ABN':abn }
			asic[abn]['ASIC_Start'] = row[ asic_header['Date of Registration'] ]
			asic[abn]['ASIC_Close'] = row[ asic_header['Date of Cancellation'] ]
			asic[abn]['ASIC_Status'] = row[ asic_header['Business Name Status'] ]

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
				businesses[abn] = { 'ABN':abn }
				if (abn in asic):
					b = asic.get(abn);
					st = b.get('ASIC_Start')
					en = b.get('ASIC_Close')
					if (len(st)==10):
						#print "asic start: "+ st + " "  + str(st[6:10]) +","+ str(st[3:5])
						businesses[abn]['StartYear'] = str(st[6:10]) + str(st[3:5])
					if (len(en)==10):
						#print "asic end: "+ st + " " + str(en[6:10]) +","+ str(en[3:5])
						businesses[abn]['EndYear'] = str(en[6:10]) + str(en[3:5])
			businesses[abn]['Postcode'] = row[ header['Postcode'] ]
			if row[ header['ABNStatus'] ] == 'ACT':
				businesses[abn]['StartYear'] = row[ header['ABNStatusFromDate'] ][:6]
			elif row[ header['ABNStatus'] ] == 'CAN':
				businesses[abn]['EndYear'] = row[ header['ABNStatusFromDate'] ][:6]
			else:
				print abn + " has unknown status " + row[ header['ABNStatus'] ]

print "Postcode,ABN,StartYear,EndYear"
for abn in businesses.keys():
	b = businesses.get(abn)
	
	if 'StartYear' in b:
		by = b.get('StartYear')
		yr = int(by[:4])
		beginyr = float(yr) + float(by[4:6])/12.0
	else:
		beginyr = 0.0

	if 'EndYear' in b:
		ey = b.get('EndYear')
		yr = int(ey[:4])
		endyr = float(yr) + float(ey[4:6])/12.0
	else:
		endyr = 0.0

	toprint = False
	if all:
		toprint = True

	if endyr == 0.0 and current:
		toprint = True

	if endyr > 0.0 and inactive:
		toprint = True

	if beginyr > 0.0 and known_start:
		toprint = True

	if beginyr == 0.0 and old:
		toprint = True

	if toprint:
		if endyr == 0.0:
			endyr = 2015.0 + 7.0/12.0
		print b.get('Postcode') + "," + b.get('ABN') + "," + repr(beginyr) + "," + repr(endyr)

