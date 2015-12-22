import json
from bs4 import BeautifulSoup
from pprint import pprint
import sys 
import codecs
import time
from sets import Set
import os

reload(sys)
sys.setdefaultencoding("utf-8")
sys.stdout = codecs.getwriter("utf-8")(sys.stdout)

fecha       = time.strftime("%d-%m-%Y")

file_xml 	= open("2_pgrouting/lima-callao.osm", "r").read()
file_pers	= open("3_scripts/python/ruta_persona.csv", "r")

lines		= []
with file_pers as f :
	lines	= f.readlines()

set_fio		= Set()
set_ale		= Set()
for line in lines[1:]:
	line	= line.strip()
	l		= line.split(',')
	pers	= l[0]
	ruta	= l[1]
	if pers == "Fiorella" :
		set_fio.add(ruta)
	else :
		set_ale.add(ruta)

fecha       = time.strftime("%d-%m-%Y")

d_salida = "3_scripts/reportes/" + fecha
if not os.path.exists(d_salida):
    os.mkdir(d_salida)

#3_scripts/input/i8_zonatransito.csv
f_out		= open("3_scripts/reportes/%s/lista_rutas.csv" % (fecha), "wb")
#f_no_tocar	= open("3_scripts/reportes/%s/no_tocar.csv" % (fecha), "wb")

soup		= BeautifulSoup(file_xml)
#f_out.write("ruta_id,nombre\n");
#f_no_tocar.write("modificado_por,asignado_a,perteneciente,ruta,id,url\n")

#f_no_tocar.write("modificado_por,asignado_a,nombre_ruta,id,url\n")
f_out.write("asignado_a,nombre_ruta,id,url\n")

for relation in soup.select("relation") :
	tag_k	= relation.find("tag", {"k" : "route"})

	if tag_k :
		tag_name	= relation.find("tag", {"k":"name"})

		if tag_name:
			user	= relation.get("user") #Solo sirve para saber quien fue el ULTIMO QUE MODIFICO
			user	= user.upper()

			if user == "GRPIAA" or user == "JDANIEL14" or user == "GRPIAA3" or user == "ARNOLDCP": #aqui se puede agregar un nuevo usuario
				id 		= relation.get("id")
				name	= tag_name.get("v")
				time	= relation.get("timestamp")

				if name[0] == 'X' :
					ruta_aux		= name[2:-2].upper()
					user_asignado	= user

					if ruta_aux in set_ale:
						user_asignado	= 'Ale'
					elif ruta_aux in set_fio:
						user_asignado	= 'Fio'
					
					f_out.write("%s,%s,%s,http://www.openstreetmap.org/relation/%s\n" % (user_asignado, name, id, id))
f_out.close()
