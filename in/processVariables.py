import csv
import re
import sys

filename = sys.argv[1]
outfile = sys.argv[2]

def find_var(str):
    x = re.search(regex, str)
    return x.group() # use x.group() to find matching variable entry, then repeat until end of line

def does_contain_key(str, keys):
    for key in keys:
        if key in str:
            return True

def clean_blanks(var_dict):
    for key in var_dict.keys():
        if key == '':
            del variable_dict[key]
    return var_dict

with open(filename) as text_file:
    readfile = csv.reader(text_file, delimiter="\t")

    regex = "(%\().*?(\)%)" # searching for variables written as '%(variable_name)%'
    new_file = {}
    master_read = {}
    variable_dict = {}

    i = 0
    for row in readfile:
        master_read[i] = row
        variable_dict[row[0]] = row[1:]
        i+=1        

    variable_dict = clean_blanks(variable_dict)

    change_file = master_read # duplicate so we don't mess up the master file
    
    for i in range(len(master_read)):
        new_file[i] = [change_file[i][0]]

    for row in change_file:
        curr = change_file[row]

        curr = curr[1:] # removes variable definitions, keeping only references

        column = 0
        for item in curr:
            for i in range(len(item.split())+2):                          # loop as many times as there are words, in case of multiple variables 
                if( does_contain_key(item, variable_dict.keys())):      # does it contain any of the keys in variable_dict?
                    
                    var_name = find_var(item)

                    replace_text = variable_dict[var_name][column]     # for each pattern match, use the matched term as a search key in variable_dict

                    item = item.replace(var_name, replace_text)        # replace the match with our lookup in variable_dict, at the correct column 

            column += 1 

            new_file[row].append(item)

        column = 0 # reset the column counter for the next list

with open(outfile, "wt") as out_file:
    tsv_writer = csv.writer(out_file, delimiter='\t')
    for row in new_file:
        tsv_writer.writerow(new_file[row])