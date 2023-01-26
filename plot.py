#!/usr/bin/env python3
import matplotlib.pyplot as plt
import random
import math

f = plt.figure()
x = []
y = []

#create a list with the x plots
m = open("final.txt")
line = m.readline()
while line:
    fields = line.split("|")
    x += [float(fields[1])] #autism
    y += [float(fields[2])] #art
    line = m.readline()
m.close()


colors = [random.random() for i in range (len(x))]
areas = [math.pi * random.random() * 600 for i in range (len(x))]
plt.scatter(x,y,c= colors, s= 10, alpha = 0.5)
plt.xlabel("percentage of autistic people per county")
plt.ylabel("public participation in the arts")

f.savefig("autismAndArt.pdf")
plt.show()
