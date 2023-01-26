#!/usr/bin/env python3
import gzip

#fields
NPI = 1
drug = 8
totDaySupply = 13
dictii = {}

ff = open("zcat /data/raw/Medicare_Prescriptions/PartD_Prescriber_PUF_NPI_Drug_2017.txt.gz")
line = ff.readline()
while line:
    column = line.split(" ") #split fields by white space
    #list of medications for ustism
    med = ["ABILIFY", "RISPERIDONE", "RISPERDAL", "ARIPIPRAZOLE", "EFFEXOR", "VENLAFAXINE", "GEODON", "MEMANTINE", "ZIPRASIDONE", "BUMETANIDE", "PALIPERIDONE"]
    for m in med:
        if m in column[drug]: # if its an medication related to autism
            key = column[NPI]
            try: ammount = int(column[totDaySupply])
            except: ammount = 0
            if key in dictii: #if there is already income data for that key, add income
                dictii[key] += ammount
            else:
                dictii[key] = ammount
    line = ff.readline()
ff.close

for key in dicti:
    print (key + "|" + str(dicti[key])) # (zip, $) this will be outputed to a file called artorgs.txt
            
