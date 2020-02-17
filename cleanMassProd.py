# Takes BRD Template & MassProduction Table (MPT)
# uses stripMessages.py to remove any hard-coded text, replacing with variables
#      puts that text into a NEWFILE
# runs RMID.awk on the new BRD for a final clean, text-free BRD
# takes the NEWFILE and MPT 
#       counts the num of columns in MPT
#       duplicates the 2nd column of NEWFILE that num-1 of times
#       appends all that into a FULLMPT
#       runs proccessVariabls on FULLMPT for a variable-free, complete collection of the text