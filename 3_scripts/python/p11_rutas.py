import sys 
import psycopg2
import csv 
from classes import *
import time

connection  = psycopg2.connect('dbname=pgrouting-workshop user=postgres')
cursor      = connection.cursor()

fecha       = time.strftime("%d-%m-%Y")

f_in			= open("3_scripts/reportes/%s/input_rutas.csv" % (fecha), "r")
f_ruta			= open("3_scripts/output/o11_rutas.csv", "wb")
f_rutaxarista	= open("3_scripts/output/o11_rutaxarista.csv", "wb")

f_ruta.write("idruta|idsolucion|frecuencia|osm_id|osm_nombre|flota\n")
f_rutaxarista.write("idruta|idarista|paradero|orden\n")

with f_in as f:
	lines	= f.readlines()



lines	= lines[1:]
cad		= ""
for line in lines:
	line	= line.replace('\n', '')
	l		= line.split(',')
	id		= l[0]
	#nombre	= l[1]
	if cad	!= "" :
		cad	= cad + ','
	cad	= cad + id
cad	= "{%s}"%(cad)
#print cad

query	= "SELECT rw.relation_id, w.osm_id, w.source, w.target, ST_ASTEXT(w.the_geom), w.x1, w.y1, w.x2, w.y2, w.gid FROM relation_ways rw, ways w WHERE rw.relation_id = ANY (\'%s\'::int[]) AND rw.way_id = w.osm_id ORDER BY 1;" % (cad)
#print query

cursor.execute(query)
rows        = cursor.fetchall()

route_id	= -1
lista_gen	= []
lista_arist	= []
for r in rows :
	if route_id == r[0]:
		lista_arist.append(r)
	else :
		route_id = r[0]
		if len(lista_arist) > 0:
			lista_gen.append(lista_arist)
			#print lista_arist[0][0]
		lista_arist	= []
		lista_arist.append(r)

if len(lista_arist) > 0:
	lista_gen.append(lista_arist)
	#print lista_arist[0][0]

for ruta in lista_gen:
	dict_nodos	= {}

	grafo		= {}
	vis			= {}

	for arista in ruta:
		#print arista
		osm_id	= arista[1]
		orig	= int(arista[2])
		dest	= int(arista[3])
		geom	= arista[4]
		x1		= arista[5]
		y1		= arista[6]
		x2		= arista[7]
		y2		= arista[8]
		gid		= arista[9]

		nd_in			= orig
		nd_out			= dest
		
		vis[nd_in]		= 0
		vis[nd_out]		= 0
	
		if not nd_in in grafo:
			grafo[nd_in] = [(nd_out, gid)]
		else :
			grafo[nd_in].append((nd_out, gid))
	
		if not nd_out in grafo:
			grafo[nd_out] = [(nd_in, gid)]
		else :
			grafo[nd_out].append((nd_in, gid))

		if not orig in dict_nodos :
			dict_nodos[orig] = [0, osm_id, geom, [], x1, y1]

		if not dest in dict_nodos :
			dict_nodos[dest] = [0, osm_id, geom, [], x2, y2]

	print "RUTA =======>  www.openstreetmap.org/relation/%d" % (ruta[0][0])
	idruta	= ruta[0][0]
	f_ruta.write("%d|1|0|%d|%s|0\n" % (idruta, idruta, "ruta"))
	print
	for arista in ruta:

		osm_id					= arista[1]
		target					= arista[3]
		dict_nodos[target][0] 	= dict_nodos[target][0] + 1

		source					= arista[2]
		dict_nodos[source][0] 	= dict_nodos[source][0] + 1

		geom					= arista[4]
		dict_nodos[target][3].append([geom, source, target, osm_id])
		dict_nodos[source][3].append([geom, source, target, osm_id])

	inicio_ruta	= None
	fin_ruta	= None

	for nodo in dict_nodos.keys():

		cont	= dict_nodos[nodo][0]
		if cont != 2 :
			osm_id	= dict_nodos[nodo][1]
			source	= dict_nodos[nodo][4]
			target 	= dict_nodos[nodo][5]
			print "%d -> %d [www.openstreetmap.org/way/%d] -- POINT(%s %s)" % (nodo, cont, osm_id, source, target) 
			for geo in dict_nodos[nodo][3]:
				print "-------> %s - %s ====> [www.openstreetmap.org/way/%d] %s" % (geo[1], geo[2], geo[3], geo[0])
			print

		if cont == 1 :
			#pos_inicio	= dict_nodos[nodo][3][0][1]
			#if nodo	== pos_inicio :
			#	inicio_ruta	= nodo
			#else :
			#	fin_ruta	= nodo
			if inicio_ruta is None:
				inicio_ruta	= nodo
			elif fin_ruta is None:
				fin_ruta	= nodo

	print "%d ----------> %d" %(inicio_ruta, fin_ruta)
	
	sig	= inicio_ruta
	fin	= fin_ruta

	orden	= 0
	#print grafo
	while sig != fin :
		vis[sig]	= 1
		#print sig
		for grf in grafo[sig]:
			hijo	= grf[0]
			gid		= grf[1]
			if vis[hijo] != 1 :
				#print "%d - %d" % (sig, gid)
				f_rutaxarista.write("%d|%d|FALSE|%d\n" % (idruta, gid, orden))
				orden 	= orden + 1
				sig 	= hijo
				break
	print "%d" % (sig)

	#print grafo
	print "-------------------------------------------------------------------------------------"
	#break

