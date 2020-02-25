# Mathtutor HTML Conversion
Carnegie Mellon's [Mathtutor](https://mathtutor.web.cmu.edu/home) software suite is being converted from Flash to HTML ahead of the Flash Death slated form Dec 2020.

This repo is where this work and the results are being stored. 

Status of each tutor (and some additional info) is kept here: [Mathtutor Breakdown](https://docs.google.com/spreadsheets/d/1aJd40tzZHr3H5Y6ft3X8udXTBZv4MACpgk2tDUHJPRE/edit?usp=sharing). If you would like edit access please feel free to request it.

Note: I've not added the Flash zip files because there's a lot of them. If you'd like to work on this project, please let us know.

## Conversion Process
1. Get a Mathtutor Flash zip file from [preview.ctat.cs.cmu.edu](preview.ctat.cs.cmu.edu)
2. Unzip it into `WIP/` for working on.
3. Rename the Mass Production folder and files 
  a. The folder and files cannot have any spaces.
  b. I recommend `massprod/` for the folder, `template.brd` for the mass production template, and `table.txt` for the MassProd Table.
4. Run the following commands, be sure to subsitute the necessary information:
  ``` bash
  cd scripts/
  ./cleanMassProd.sh ../WIP/{mass production folder path} {brd filename}.brd {table filename}.txt
  ```
  for example:
  ```bash
  cd scripts/
  ./cleanMassProd.sh ../WIP/8.23/massprod/ 8-23template.brd 8-23table.txt
  ```
  This will output 3 files: `finalTemplate.brd` `finalMassProdtable.txt` and `translatable.txt`. This last file is important for our ongoing internationalization efforts, and is essentially a single-column version of the `finalMassProdtable` which makes it easier to read.
5. Now make a file call HTML/ in your tutor folder, as well as a subdirectory called Assets/
6. Create a file called `tutor.html`. This will be the re-implemented interface.
  a. This file can be sourced from previously finished tutors, or from the `mathtutor_templates` folder.
  b. I typically reuse the interface found in `DONE/8.20/` by removing the `<table></table>` found in its `CTATSolution` tag, but the layout may not be best for each given tutor.
  c. Work to get the CTAT interface ready as you like. Use the existing BRDs to test it within CTAT.
7. Once the interface looks ready and has been tested, merge the `finalTemplate.brd` and `finalMassProdtable.txt` generated in step 4 to create new BRDs. 
8. Upload all contents to Tutorshop Preview, be sure to mark the package as with 'HTML' so it's findable. Then move the tutor folder into `DONE/`, and commit and push the changes here. 