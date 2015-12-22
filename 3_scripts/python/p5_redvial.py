import sys
import psycopg2
import csv
from classes import *

#connection 	= psycopg2.connect('dbname=rutas user=postgres')
#cursor 		= connection.cursor()

file_red	= open("3_scripts/input/i6_redvial.csv", "r")

file_out	= open("3_scripts/output/o5_redvial.csv", "wb")
file_out.write("ID|NAME|TIPO|geom|idzona\n")

with file_red as f_red:
	archivo 	= csv.reader(f_red, delimiter = ";")
	flag 		= True
	cont 		= 0
	for row in archivo :
		cont	= cont + 1
		if flag :
			flag = False
			continue
		red		= RedVial(row)
		if int(red.TIPO) > 8 :
			continue 
		print cont
		red.guardar(file_out)

file_out.close()
#connection.close()
