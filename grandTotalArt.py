#this program will calculate the grand total of money made by art organizations on each zipcode and divide it by the population ammount 

import pyspark
sc = pyspark.SparkContext()
sc.setLogLevel("ERROR")

def mapper(line):
    fields = line.split("|")
    zipcode = fields[0]
    try:
        dollars = int(fields[1])
        population = int(fields[2])
    except:
        dollars = 0
        population = 0
    return (zipcode, (dollars, population))

data = sc.textFile("popart.txt")
pairs = data.map(mapper)                 #(zipcode, (dollars, population))

# calculate total $
a = pairs.reduceByKey(lambda x, y:(x[0]+y[0], x[1]+y[1]))      #(zipcode, (tot dollars, tot pop))
b = a.map(lambda x: (x[0], (x[1][0]/x[1][1])))                 #(zipcode, $ per capita)
#ans = b.saveAsTextFile("grandTotalArt")
ans = b.collect()
for a in ans:
    print (a)
    print()

