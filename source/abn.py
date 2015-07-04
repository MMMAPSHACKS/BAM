import sys
import xml.etree.cElementTree as ET

#source = '20150701_Public01.xml'
#context = ET.iterparse(source, events=("start", "end"))
#context = iter(context)
#event, root = context.next()

#for event, elem in context:
#	print event, elem.tag

def render_file( source, all_keys ):
	root = None
	cols=[]
	vals={}
	depth = 0
	last_header = ''
	for event, elem in ET.iterparse(source, events=("start", "end")):
		if event == "start":
			#print 'S ' + elem.tag
			if root == None:
				root = elem
			cols.insert(0,elem.tag)
			depth += 1
			vals[elem.tag] = ''
			if all_keys.count(elem.tag) == 0:
				all_keys.append(elem.tag)
		else:
			#print 'E ' + elem.tag, elem.attrib, elem.text
			depth -= 1
			vals[elem.tag] = elem.text
			if elem.tag == 'ABN':
				if all_keys.count('ABNStatus') == 0:
					all_keys.append('ABNStatus')
				vals['ABNStatus'] = elem.attrib['status']
				if all_keys.count('ABNStatusFromDate') == 0:
					all_keys.append('ABNStatusFromDate')
				vals['ABNStatusFromDate'] = elem.attrib['ABNStatusFromDate']
			if depth == 1:
				line = ''
				delim = ''
				for col in all_keys:
					line = line + delim + col
					delim = '\t'
				if line != last_header:
					last_header = line
					print last_header
				pcode = vals.get('Postcode', '')
				if vals.get('State','') == 'SA':
					line = ''
					delim = ''
					for col in all_keys:
						v = vals.get(col, '')
						if v == None:
							v = ''
						line = line + delim + v
						delim = '\t'
					print line
				cols = [ col[0] ]
				vals = {}
				vals[cols[0]] = elem.text
	
#tree = ET.parse('country_data.xml')
#root = tree.getroot()
	
#print root.tag, root.attrib
#for child in root:
#	print child.tag, child.attrib


all_keys = [
	"ABN","ABNStatus","ABNStatusFromDate","ABR","ASICNumber","AddressDetails",
	"BusinessAddress","DGR","EntityType","EntityTypeInd","EntityTypeText",
	"ExtractTime","FamilyName","FileSequenceNumber","GST","GivenName","IndividualName",
	"LegalEntity","MainEntity","NameTitle","NonIndividualName","NonIndividualNameText",
	"OtherEntity","Postcode","RecordCount","State","Transfer","TransferInfo" ]
n = 0
for arg in sys.argv:
	n += 1
	if n == 1:
		continue
	render_file( arg, all_keys )

