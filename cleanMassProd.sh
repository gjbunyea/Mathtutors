#!/bin/bash

# for RMIDrunner
# $1 - file folder
# $2 - brd to convert
# $3 - brd name output
# ./scripts/RMIDrunner.sh folder/ in.brd out.brd

# also needs the txt file

# ./cleanMassProd.sh ../8.20/massproduction/ template.brd massprod.txt
folder=$1
in_brd=$folder$2
in_txt=$folder$3

echo 'Processing' ${folder}

touch ${folder}/temp.txt; tmp_txt=${folder}/temp.txt
touch ${folder}/temp.brd; tmp_brd=${folder}/temp.brd
touch ${folder}/finalMassProdtable.txt; out_txt=${folder}/finalMassProdtable.txt
touch ${folder}/finalTemplate.brd; out_brd=${folder}/finalTemplate.brd

# count columns in the in_txt file so we know how many columns have to match the output of StripMessages
COL=$(head -n1 $in_txt | grep -o " " | wc -l)

# Strip all hand-coded text from the in_brd and swap with hashed variables
python stripMessages.py $in_brd $tmp_brd $tmp_txt $COL
echo 'messages stripped from brd'

# clean the InterfaceDescriptions from the stripped brd 
awk -f RMID.awk $tmp_brd >$out_brd 2>/dev/null
echo 'removed InterfaceDescriptions from brd'

# append the new variable mappings from stripMessages 
cat $tmp_txt >> $in_txt
echo 'updated mass prod table'

# replace all variables with their inputs so all text is complete sentences
python processVariables.py $in_txt $out_txt

# reformat into 2-column file (easier for translator to read)
python reorganize.py $out_txt ${folder}/translatable.txt $COL

# clean up the temp docs
rm $tmp_brd
rm $tmp_txt

echo 'done'