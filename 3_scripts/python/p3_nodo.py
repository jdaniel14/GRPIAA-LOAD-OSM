import sys
import psycopg2
import csv
from classes import *

#tam	 	= int(sys.argv[1])
#freq	= int(sys.argv[2])

def insert_pto(dict, nodo) :
	if not (nodo.idnodo in dict) :
		dict[nodo.idnodo] = nodo

def dict_via() :
	dict = {}
	with open("3_scripts/output/o2_via.csv", "r") as csvfile:
		archivo = csv.reader(csvfile, delimiter="|")
		flag 	= True
		for row in archivo :
			if flag :
				flag = False
				continue
			via  = Via(row)
			dict[via.nombre] = via.idvia

	return dict

connection 	= psycopg2.connect('dbname=pgrouting-workshop user=postgres')
cursor 		= connection.cursor()
#sql 		= "SELECT source, x1, y1, target, x2, y2, name, length, ST_AsTEXT(the_geom) FROM ways"
sql 		= "SELECT gid, source, x1, y1, target, x2, y2, name, ST_Distance(ST_Transform(ST_SetSRID(ST_MakePoint(x1,y1),4326),26986),ST_Transform(ST_SetSRID(ST_MakePoint(x2,y2),4326),26986))/1000.0, ST_AsTEXT(the_geom) FROM ways"
cursor.execute(sql)

dict_ptos 	= {}
rows 		= cursor.fetchall()

connection.close()

file_nodo	= open("3_scripts/output/o3_nodo.csv", "wb")
file_nodo.write("idnodo|longitud|latitud\n")

file_arista	= open("3_scripts/output/o4_arista.csv", "wb")
file_arista.write("idarista|idnodoorigen|idnododestino|idvia|distancia|numcarriles|accesible|direccion|geom\n")

with file_nodo as f_nodo:

	for r in rows :
		id1 	= int(r[1])
		x1		= str(r[2])
		y1		= str(r[3])
		nodo1 	= Nodo([id1,x1,y1])
		insert_pto(dict_ptos, nodo1)

		id2		= int(r[4])
		x2		= str(r[5])
		y2		= str(r[6])
		nodo2	= Nodo([id2,x2,y2])
		insert_pto(dict_ptos, nodo2)

	for key in dict_ptos.keys() :
		nodo	= dict_ptos[key]
		nodo.guardar(f_nodo)

	dict = dict_via()
	cont = 0
	for r in rows :
		cont = cont + 1

		arista		 	 		= Arista()
		arista.idarista 	 	= r[0]
		arista.idnodoorigen 	= r[1]
		arista.idnododestino	= r[4]
		cad = r[7]
		if len(cad) == 0 :
			cad = "-"
		arista.idvia			= dict[cad.replace(";", ",").strip()]
		arista.distancia		= r[8]
		arista.numcarriles		= str(2)
		arista.accesible		= str(1)
		arista.direccion		= str(1)
		arista.geom				= "SRID=4326;%s"%(r[9])

		arista.guardar(file_arista)
		
file_nodo.close()
file_arista.close()
