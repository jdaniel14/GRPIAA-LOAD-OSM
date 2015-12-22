import sys
import psycopg2
import csv
from classes import *


connection 	= psycopg2.connect('dbname=pgrouting-workshop user=postgres')
cursor 		= connection.cursor()
sql 		= "SELECT distinct ON(name) class_id, name FROM ways"
cursor.execute(sql)

rows 		= cursor.fetchall()

connection.close()

file_via	= open("3_scripts/output/o2_via.csv", "wb")
file_via.write("idvia|nombre|velocidadprom|accesible|idtipovia\n")

with file_via as f:

	cont = 0
	for r in rows :
		cont 			= cont + 1

		idvia	 		= cont
		cad = str(r[1])
		if len(cad) == 0:
			cad = "-"
		nombre			= cad.replace(";", ",")
		velocidadprom	= str(40)
		accesible		= "True"
		idtipovia		= r[0]

		via = Via([idvia, nombre, velocidadprom, accesible, idtipovia])
		via.guardar(f)

file_via.close()
