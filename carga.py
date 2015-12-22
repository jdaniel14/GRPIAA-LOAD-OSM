import subprocess
import psycopg2
import urllib

pbf_file		= "1_osmosis/peru-latest.osm.pbf"
poly_file		= "1_osmosis/lima-callao.poly"
osm_file		= "2_pgrouting/lima-callao.osm"
pgrouting_bd	= "pgrouting-workshop"

#descargamos de GEOFABRIK
print "INICIO DE DESCARGA"
response		= urllib.URLopener()
response.retrieve("http://download.geofabrik.de/south-america/peru-latest.osm.pbf", pbf_file)
print "FIN DE DESCARGA"
#extraemos con OSMOSIS lo que nos sirve


#comando_osmosis	= "osmosis --rb file=%s  --bounding-polygon file=%s --way-key-value keyValueList=highway.primary,highway.secondary,highway.tertiary,highway.trunk,highway.motorway,highway.residential,highway.motorway_link,highway.trunk_link,highway.primary_link,highway.secondary_link,highway.tertiary_link --tf reject-relations --write-xml %s" % (pbf_file, poly_file, osm_file)
comando_osmosis	= "osmosis --rb file=%s  --bounding-polygon file=%s --way-key-value keyValueList=highway.primary,highway.secondary,highway.tertiary,highway.trunk,highway.motorway,highway.residential,highway.motorway_link,highway.trunk_link,highway.primary_link,highway.secondary_link,highway.tertiary_link --write-xml %s" % (pbf_file, poly_file, osm_file)
#comando_osmosis	= "osmosis --rb file=%s  --bounding-polygon file=%s --tf reject-nodes --tf reject-ways --write-xml %s" % (pbf_file, poly_file, osm_file)



print comando_osmosis
p	= subprocess.Popen(comando_osmosis.split(), stdout=subprocess.PIPE)
p.wait()
print "SE OBTUVO EL OSM FILE"

#raw_input("TERMINAR")

#-- Hasta aqui obtenemos el OSM ---> osm2pgrouting

connection  = psycopg2.connect('user=postgres')
connection.set_isolation_level(0)
cursor      = connection.cursor()

comando_creacion	= "psql -U postgres -f ./2_pgrouting/pgrouting_esquema.sql"
p	= subprocess.Popen(comando_creacion.split(), stdout=subprocess.PIPE)
p.wait()

print "SE CREA LA BD pgrouting-workshop"

comando_osm2pg		= "./2_pgrouting/osm2pg.sh"
print comando_osm2pg

raw_input("Por favor inserte el osm2pgrouting y fin")

#creamos los CSV que necesitamos
procesos	= ["p1_tipovia", "p2_via", "p3_nodo", "p4_distrito", "p5_redvial", "p6_zonatransito", "p7_minizona"]

for proc in procesos :
	com_py	= "python 3_scripts/python/%s.py" % (proc)
	print com_py
	p	= subprocess.Popen(com_py.split(), stdout=subprocess.PIPE)
	p.wait()

comando_creacion    = "psql -U postgres -f ./4_esquema/baserutas"
p   = subprocess.Popen(comando_creacion.split(), stdout=subprocess.PIPE)
p.wait()

print "\n\n\n\n\n\n"

comando_creacion    = "psql -U postgres -d rutas -f ./4_esquema/copy-instrucciones.sql"
p   = subprocess.Popen(comando_creacion.split(), stdout=subprocess.PIPE)
p.wait()


comando_creacion    = "psql -U postgres -d rutas -f ./5_grafo/centroide_grafo.sql"
p   = subprocess.Popen(comando_creacion.split(), stdout=subprocess.PIPE)
p.wait()













