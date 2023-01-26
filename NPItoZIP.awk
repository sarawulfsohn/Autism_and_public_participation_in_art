#!/usr/bin/gawk -f 
 # this program will convert doctors NPI into zipcode

 BEGIN{

     FS = "|"
     OFS = "|"

     data = "cat perscriptions.txt"
     trad = " zcat /data/raw/DoctorNPInumbers/npi.gz"

     #dictionary with data from the persctiptions (npi|totDaySupply)
     while ((data | getline) > 0) {
	 dicti[$1]= $2
     }

     while ((trad | getline) > 0){
	 if ($1 in dicti){
	     zipcode = substr($25, 1, 5)
	     print zipcode,  dicti[$1]  #zipcode| totdaysupply
	 }
     }
 }
            
          
 
	
    

