#!/usr/bin/gawk -f
# this program will add the population for each zipcode

 BEGIN{

     FS = "|"
     OFS = "|"

     data = "cat artorgs.txt"
     pop = "zcat IncomePop.gz" #zip|median|mean|pop

     #create dictionary with data from zip list (zicode, totDaySupply)
     while ((data | getline) > 0){
	 dictii[$1] = $2 
     }

     while((pop | getline)  >0){
	 if ($1 in dictii){
	     print $1, dictii[$1], $4 # print zip|totDaySupply|population
	 }
     }
 }
