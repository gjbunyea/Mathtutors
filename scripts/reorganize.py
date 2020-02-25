#!/usr/bin/python

import csv
import sys

infile = sys.argv[1]
outfile = sys.argv[2]
col_count = int(sys.argv[3])

var_phrase_map = {}

with open(infile) as text_file:
    readfile = csv.reader(text_file, delimiter="\t")

    columns = []
    for i in range(col_count):
        columns.append([])
    
    for row in readfile:
        for i in range(col_count):
            columns[i].append(row[i])

f = open(outfile,"w")
var_col = 0
curr_col = 1
for i in range(1,col_count):
    for j in range(len(columns[var_col])):
        s = str(columns[var_col][j]) + "\t" + str(columns[curr_col][j]) +"\n"
        b = f.write(s)
    curr_col+=1
    