#!/usr/bin/gawk -f
 # this program will convert zipcodes into counties for med

 BEGIN{

     FS = ","
     OFS = "|"

     data = "cat grandTotalMedications.txt"
     trad = "zcat /data/raw/ZIPcodes/ZIPcodes.gz"

     #create a dictionary for data (zip, percentage)
     while ((data | getline) >0){
	 zipcode = substr($1, 3, 5) #get only zipcode, without commas or parenthesis
	 i = index($2, ")") # get position of )
	 percentage = substr($2, 1, i-1) #remove )
	 dicti[zipcode] = percentage
     }
     FS = "|"
     while ((trad | getline) > 0){
	 
	 if ($1 in dicti){
	     print ("A")
	     # $6 = state, $7 = county
	     dat[$7 " " $6] = dicti[$1] # county,state | percentage
	 }
     }
     # sum up all values for the same county/state
     for (key in dat){
	 print("A")
	 if (key in final)#if there is already a key for that county state
	     final[key] += dat[key]
	 else
	     final[key] = dat[key]
     }
     for (key in final)
	 print (key "|" final[key])
 }
     
