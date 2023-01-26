#this program will calculate the grand total of totday supply per zipcode and divide it by the population ammount 

import pyspark
sc = pyspark.SparkContext()
sc.setLogLevel("ERROR")

def mapper(line):
    fields = line.split("|")
    zipcode = fields[0]
    try:
        supply = int(fields[1])
        population = int(fields[2])
    except:
        supply = 0
        population = 0
    return (zipcode, (supply, population))

data = sc.textFile("pop.txt")
pairs = data.map(mapper)                 #(zipcode, (supply, population))

# calculate total $
a = pairs.reduceByKey(lambda x, y:(x[0]+y[0], x[1]+y[1]))      #(zipcode, (tot supply, tot pop))
b = a.filter(lambda x: x[1][0] != 0 and x[1][1] != 0)          #(zipcode, (tot supply >0, tot pop>0))
c = b.map(lambda x: (x[0], 100 * (x[1][0]/x[1][1])))           #(zipcode, supply percentage per capita)
#ans = c.saveAsTextFile("grandTotalMedications")
ans = c.collect()
for a in ans:
    print(a)
    print()

