import sys 
import psycopg2
import csv 
from classes import *
import time

fecha       = time.strftime("%d-%m-%Y")

f_rutaxminizona	= open("3_scripts/output/o12_rutaxminizona.csv", "wb")
f_rutaxminizona.write("idruta|idminizona\n")

connection  = psycopg2.connect('dbname=rutas user=postgres')
cursor      = connection.cursor()

query = "SELECT idruta FROM ruta"

cursor.execute(query)
rows        = cursor.fetchall()

for r in rows :
	idruta		= r[0]
	#print "---> %s" % (idruta)
	query_int	= "SELECT DISTINCT ON (zt.idzonatransito) zt.idzonatransito FROM rutaxarista as ra, arista as a, zonatransito zt WHERE ra.idruta = %s AND ra.idarista=a.idarista AND ST_Crosses(a.geom, zt.geom)" % (idruta)
	cursor.execute(query_int)
	rows_int	= cursor.fetchall()
	for r in rows_int :
		idminizona	= r[0]
		f_rutaxminizona.write("%s|%s\n" % (idruta, idminizona))
	#print 
f_rutaxminizona.close()
