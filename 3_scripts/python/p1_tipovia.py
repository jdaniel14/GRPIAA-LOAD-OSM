import sys
import psycopg2
import csv
from classes import *


connection 	= psycopg2.connect('dbname=pgrouting-workshop user=postgres')
cursor 		= connection.cursor()
sql 		= "SELECT id, name FROM classes"
cursor.execute(sql)

rows 		= cursor.fetchall()

connection.close()

file_tipovia	= open("3_scripts/output/o1_tipovia.csv", "wb")
file_tipovia.write("idtipovia|nombretipo|rutasmax\n")

with file_tipovia as f:

	for r in rows :
		id 	 		= int(r[0])
		name		= str(r[1])
		rutasmax	= str(10) 
		tipo_via = Tipo_Via([id, name, rutasmax])
		tipo_via.guardar(f)

file_tipovia.close()
