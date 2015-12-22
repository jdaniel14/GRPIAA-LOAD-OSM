import sys 
import psycopg2
import csv 
from classes import *
import time
import os
from sets import Set

connection  = psycopg2.connect('dbname=pgrouting-workshop user=postgres')
cursor      = connection.cursor()

fecha       = time.strftime("%d-%m-%Y")

#d_salida = "3_scripts/reportes/" + fecha
#if not os.path.exists(d_salida):
#	os.mkdir(d_salida)

f_in		= open("3_scripts/reportes/%s/lista_rutas.csv" % (fecha), "r")
f_bien		= open("3_scripts/reportes/%s/input_rutas.csv"	% (fecha), "wb")
f_rep_gen	= open("3_scripts/reportes/%s/reporte_general.csv"	% (fecha), "wb")
f_rep_ind	= open("3_scripts/reportes/%s/reporte_individual.csv" % (fecha), "wb")
f_ruta_tipo	= open("3_scripts/reportes/%s/reporte_tipo_ruta.csv" % (fecha), "wb")
f_usuario_ruta_errores	= open("3_scripts/reportes/%s/reporte_usuario_ruta.csv" % (fecha), "wb")
f_tipo_total_users		= open("3_scripts/reportes/%s/reporte_tipo_total_usuario.csv" % (fecha), "wb")
f_errores				= open("3_scripts/reportes/%s/lista_errores.csv" % (fecha), "wb")
f_errores_oficial		= open("3_scripts/reportes/%s/lista_errores_oficial.csv" % (fecha), "wb")
f_ayuda					= open("3_scripts/reportes/%s/ayuda_errores.csv" % (fecha), "wb")

f_ruta_tipo.write("tipo,ruta\n")
f_usuario_ruta_errores.write("usuario,ruta,nombre_ruta,tipo1,tipo2,tipo3,tipo4,tipo5,tipo6,tipo7,tipo8,tipo9,tipo10,tipo11,tipo12,tipo13,tipo14,tipo15,tipo16,tipo17,tipo18,tipo19,tipo20\n")
f_tipo_total_users.write("tipo,total,usuario\n")
f_errores_oficial.write("usuario,nombre_ruta,id_ruta,tipo_error,link\n")
f_ayuda.write('usuario,ruta_nombre,ruta_id,ruta_url\n')

dict_users				= {}
dict_users["Ale"]		= {}
dict_users["Fio"]		= {}
dict_users["Jose"]		= {}
dict_users["GRPIAA"]	= {}
dict_users["GRPIAA3"]	= {}
dict_ruta_nombre		= {}

dict_user_ruta	= {}

with f_in as f:
	lines	= f.readlines()

lines	= lines[1:]
cad		= ""
for line in lines:

	line	= line.replace('\n', '')
	l		= line.split(',')
	id		= l[2]
	nombre	= l[1]
	user	= l[0]
	dict_user_ruta[int(id)]		= user
	dict_ruta_nombre[int(id)]	= nombre

	if cad	!= "" :
		cad	= cad + ','
	cad	= cad + id
cad	= "{%s}"%(cad)
#print cad

query	= "SELECT DISTINCT rw.relation_id, w.osm_id, w.source, w.target, ST_ASTEXT(w.the_geom), w.x1, w.y1, w.x2, w.y2 FROM relation_ways rw, ways w WHERE rw.relation_id = ANY (\'%s\'::int[]) AND rw.way_id = w.osm_id ORDER BY 1;" % (cad)
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


#contador de errores_generales
dict_contador	= {}
for i in xrange(1, 20):
	dict_contador[i] = 0

f_rep_ind.write("ruta,error,cuantos\n")

for ruta in lista_gen:
	dict_nodos	= {}
	for arista in ruta:
		#print arista
		osm_id	= arista[1]
		orig	= arista[2]
		dest	= arista[3]
		geom	= arista[4]
		x1		= arista[5]
		y1		= arista[6]
		x2		= arista[7]
		y2		= arista[8]
		if not orig in dict_nodos :
			dict_nodos[orig] = [0, osm_id, geom, [], x1, y1]

		if not dest in dict_nodos :
			dict_nodos[dest] = [0, osm_id, geom, [], x2, y2]
		#f_geom.write("%d;%d;%s\n" % (orig, dest, geom))

	id_ruta	= ruta[0][0]

	f_errores.write("RUTA =======>  www.openstreetmap.org/relation/%d\n" % (id_ruta))
	f_errores.write("\n")

	for arista in ruta:

		osm_id					= arista[1]
		target					= arista[3]
		dict_nodos[target][0] 	= dict_nodos[target][0] + 1

		source					= arista[2]
		dict_nodos[source][0] 	= dict_nodos[source][0] + 1

		geom					= arista[4]
		dict_nodos[target][3].append([geom, source, target, osm_id])
		dict_nodos[source][3].append([geom, source, target, osm_id])

	#contador de errores por ruta
	dict_contador_ruta	= {}

	cont_cual	= 0

	url_ruta	= 'www.openstreetmap.org/relation/%d' % (id_ruta)
	#lista_ayuda	= []
	
	for nodo in dict_nodos.keys():
	
		#f_ayuda.write(cad_ayuda)
		cont	= dict_nodos[nodo][0]

		if cont != 2 :

			user_actual	= dict_user_ruta[id_ruta]
			#print user_actual

			if not cont in dict_users[user_actual]:
				dict_users[user_actual][cont]	= 1
			else:
				dict_users[user_actual][cont]	= dict_users[user_actual][cont] + 1

			if not cont in dict_contador_ruta:
				dict_contador_ruta[cont]	= 1
			else:
				dict_contador_ruta[cont]	= dict_contador_ruta[cont] + 1

			dict_contador[cont]	= dict_contador[cont] + 1
			cont_cual	= cont_cual + 1
			osm_id	= dict_nodos[nodo][1]
			source	= dict_nodos[nodo][4]
			target 	= dict_nodos[nodo][5]
			#print "%d -> %d [www.openstreetmap.org/way/%d] -- POINT(%s %s)" % (nodo, cont, osm_id, source, target) 
			f_errores.write("%d -> %d [www.openstreetmap.org/way/%d] -- POINT(%s %s)\n" % (nodo, cont, osm_id, source, target))
			f_errores_oficial.write("%s,%s,%d,%d,www.openstreetmap.org/relation/%s#map=19/%s/%s\n" % (user_actual, dict_ruta_nombre[id_ruta], id_ruta, cont, id_ruta,target, source))

			url_ruta		= 'www.openstreetmap.org/relation/%s#map=19/%s/%s' % (id_ruta, target, source)
			cad_aux_ayuda	= '%s,%s,%s,%s,TIPO-%d,' % (dict_user_ruta[id_ruta], dict_ruta_nombre[id_ruta], id_ruta, url_ruta, cont)
			f_ayuda.write(cad_aux_ayuda)
			set_puntos		= Set()
			
			for geo in dict_nodos[nodo][3]:
				f_errores.write("-------> %s - %s ====> [www.openstreetmap.org/way/%d] %s\n" % (geo[1], geo[2], geo[3], geo[0]))
				set_puntos.add(geo[3])
				#f_ayuda.write('www.openstreetmap.org/way/%d,' % (geo[3]))
			
			lista_puntos	= list(set_puntos)
			lista_ways		= ["www.openstreetmap.org/way/%d" % (punto) for punto in lista_puntos]
			f_ayuda.write('%s\n' % (','.join(lista_ways)))
			#print				
			f_errores.write("\n")
		#f_ayuda.write('\n')
	#f_ayuda.write(','.join(lista_ayuda) + '\n')

	#Quitamos las rutas buenas
	if 1 in dict_contador_ruta and dict_contador_ruta[1] == 2:
		dict_contador_ruta.pop(1, None)
		dict_users[user_actual][1]	= dict_users[user_actual][1]	- 2

#	print dict_users
#	print

	for key in dict_contador_ruta :
		f_rep_ind.write("%d,%d,%d\n" % (id_ruta, key, dict_contador_ruta[key]))
		f_ruta_tipo.write("%d,%d\n" % (key, id_ruta))
	
	f_usuario_ruta_errores.write("%s,%d,%s," % (dict_user_ruta[id_ruta], id_ruta, dict_ruta_nombre[id_ruta]))
	for i in xrange(1, 21):
		if i in dict_contador_ruta :
			f_usuario_ruta_errores.write("%d," % dict_contador_ruta[i])
		else :
			f_usuario_ruta_errores.write("0,")
	f_usuario_ruta_errores.write("\n")


	if cont_cual == 2 :
		f_bien.write("%d\n"%(id_ruta))
	#break
	f_errores.write("-------------------------------------------------------------------------------------\n")
#print query

f_rep_gen.write("REPORTE GENERAL\n")
for key in dict_contador :
	cad	= "%d ==> %d" % (key, dict_contador[key])
	f_rep_gen.write(cad + '\n')

for user in dict_users:
	for tipo in dict_users[user]:
		f_tipo_total_users.write("%d,%d,%s\n" % (tipo, dict_users[user][tipo], user))


