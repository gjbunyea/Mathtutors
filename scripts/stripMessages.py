#!/usr/bin/python

import csv
import sys
import xml.etree.ElementTree as ET

infile = sys.argv[1]
outbrd = sys.argv[2]
outvars = sys.argv[3]
col_count = int(sys.argv[4])

tree = ET.parse(infile)
root = tree.getroot()
regex = "(%\().*?(\)%)"

var_phrase_map = {}

def make_var(phrase):
    if(phrase is None or phrase == ''):
        return ''
    h = hash(phrase)
    v = '%(' + str(h) + ')%'
    var_phrase_map[v] = phrase
    return v

# load all elements into the phrase map
for hintMessage in root.iter('hintMessage'):
    hintMessage.text = make_var(hintMessage.text)

for buggyMessage in root.iter('buggyMessage'):
    buggyMessage.text = make_var(buggyMessage.text)

for successMessage in root.iter('successMessage'):
    successMessage.text = make_var(successMessage.text)

tree.write(outbrd)

f = open(outvars,"w")
for k, v in var_phrase_map.items():
    s = str(k)
    for i in range(col_count - 1): # -1 to exclude the variable column
        s = s+"\t"+str(v)
    s = s+"\n"
    b = f.write(s)