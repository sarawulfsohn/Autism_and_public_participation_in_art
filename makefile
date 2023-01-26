all: 	autismAndArt.pdf
	echo "done!"

#remove all files
clean:
	rm final.txt countyart.txt artjoin.txt  popart.txt artorgs.txt countymed.txt medjoin.txt pop.txt NPItoZIP.txt perscriptions.txt autismAndArt.pdf


#make graph
autismAndArt.pdf: final.txt plot.py
	python3 ./plot.py

#make one file with data from art and medications per county
final.txt: final.awk countyart.txt countymed.txt
	gawk -f final.awk > final.txt
#ART
#transform the art data from zipcode to county state
countyart.txt: grandTotalArts.txt ziptocountyart.awk /data/raw/ZIPcodes/ZIPcodes.gz
	gawk -f ziptocountyart.awk > countyart.txt

#get the $ per capita
grandTotalArts.txt: popart.txt grandTotalArt.py
	spark-submit grandTotalArt.py > grandTotalArts.txt

#get the population for each zipcode
popart.txt: artorgs.txt IncomePop.gz popArt.awk
	gawk -f popArt.awk > popart.txt

#get the income of art-related organizations per zipcode
artorgs.txt: artorgs.py eo1.csv eo2.csv eo3.csv eo4.csv eo_pr.csv eo_xx.csv
	python3 ./artorgs.py > artorgs.txt

#PERSCRIPTIONS
#transform perscriptions data from zipcode to county
countymed.txt: ziptocountymed.awk grandTotalMedications.txt /data/raw/ZIPcodes/ZIPcodes.gz
	gawk -f ziptocountymed.awk > countymed.txt

#get percentage of autistic people per zip
grandTotalMedications.txt: pop.txt grandTotalMedications.py
	spark-submit grandTotalMedications.py > grandTotalMedications.txt

#get the population per zipcode
pop.txt: NPItoZIP.txt IncomePop.gz pop.awk
	gawk -f pop.awk > pop.txt

#transform doctors NPI into zipcode
NPItoZIP.txt: perscriptions.txt  /data/raw/DoctorNPInumbers/npi.gz NPItoZIP.awk
	gawk -f NPItoZIP.awk > NPItoZIP.txt

#get the people per NPI that are perscribed a drug related to autism
perscriptions.txt: /data/raw/Medicare_Prescriptions/PartD_Prescriber_PUF_NPI_Drug_2017.txt.gz perscriptions.py
	python3 ./perscriptions.py > perscriptions.txt

