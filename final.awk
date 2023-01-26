# this program will take the data from arts and medications, and put it all on the same txt file

#!/usr/bin/gawk -f


BEGIN{

    FS = "|"
    OFS = "|"
    
    art = "cat countyart.txt"
    med = "cat countymed.txt"

    while ((art | getline)>0){ #county state| $ per capita
	#print ($1)
	decimal = index($2, ".")
	amm = substr($2, 1, decimal)
	if ($2 > 0)
	    dicti[$1] = $2
    }
    while ((med | getline)>0){ #county state | percentage
	#print ("-->" $1)
	if ($1 in dicti){
	    if ($2 >0)
		print $1, $2, dicti[$1]
	}
    }
}
