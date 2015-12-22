import subprocess
import psycopg2
import urllib
#creamos los CSV que necesitamos

procesos	= ["p1_tipovia", "p2_via", "p3_nodo", "p5_redvial", "p6_zonatransito", "p7_minizona"]

for proc in procesos :
	com_py	= "python 3_scripts/python/%s.py" % (proc)
	print com_py
	p	= subprocess.Popen(com_py.split(), stdout=subprocess.PIPE)
	p.wait()

comando_creacion    = "psql -U postgres -f ./4_esquema/baserutas"
p   = subprocess.Popen(comando_creacion.split(), stdout=subprocess.PIPE)
p.wait()

print "LISTO PARA LA CARGA FINAL\n"

comando_creacion    = "psql -U postgres -d rutas -f ./4_esquema/copy-instrucciones.sql"
p   = subprocess.Popen(comando_creacion.split(), stdout=subprocess.PIPE)
p.wait()


comando_creacion    = "psql -U postgres -d rutas -f ./5_grafo/centroide_grafo.sql"
p   = subprocess.Popen(comando_creacion.split(), stdout=subprocess.PIPE)
p.wait()

#procesos	= ["p9_cargar_rutas", "p10_carga", "p11_rutas"]
procesos	= ["p9_cargar_rutas", "p10_carga"]

for proc in procesos :
	com_py	= "python 3_scripts/python/%s.py" % (proc)
	print com_py
	p	= subprocess.Popen(com_py.split(), stdout=subprocess.PIPE)
	p.wait()

'''
comando_creacion    = "psql -U postgres -d rutas -f ./4_esquema/cargar_rutas.sql"
p   = subprocess.Popen(comando_creacion.split(), stdout=subprocess.PIPE)
p.wait()


com_py	= "python 3_scripts/python/p12_rutaxminizona.py"
print com_py
p		= subprocess.Popen(com_py.split(), stdout=subprocess.PIPE)
p.wait()

comando_creacion    = "psql -U postgres -d rutas -f ./4_esquema/cargar_rutaxminizona.sql"
p   = subprocess.Popen(comando_creacion.split(), stdout=subprocess.PIPE)
p.wait()
'''
