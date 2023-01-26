#!/usr/bin/env python3
import gzip

files = ["eo1.csv", "eo2.csv", "eo3.csv", "eo4.csv",  "eo_pr.csv",  "eo_xx.csv"]
#fields
name = 1
city = 4
state = 5
zipcode = 6
income = 24
dicti = {}

for f in files:
    ff = open(f)
    line = ff.readline()
    while line:
        column = line.split(",") #split fields by commas
        #list of organizations related to the arts
        arts = [" ART", "ART ","ARTS ", " ARTS", "THEATHER", "GALLERY", " DANCE", "DANCE", "MUSIC", "MUSEUM", ] 
        for art in arts:
            if art in column[name]: # if its an organization related to the arts
                key = column[zipcode][:5]
                try: ammount = int(column[income])
                except: ammount = 0
                if key in dicti: #if there is already income data for that key, add income
                    dicti[key] += ammount
                else:
                    dicti[key] = ammount
        line = ff.readline()
    ff.close

for key in dicti:
    print (key + "|" + str(dicti[key])) # (zip, $) this will be outputed to a file called artorgs.txt
            
    
    
