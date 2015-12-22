import subprocess
import psycopg2
import urllib

comando_creacion    = "psql -U postgres -d rutas -f ./4_esquema/cargar_rutas.sql"
p   = subprocess.Popen(comando_creacion.split(), stdout=subprocess.PIPE)
p.wait()


com_py  = "python 3_scripts/python/p12_rutaxminizona.py"
print com_py
p       = subprocess.Popen(com_py.split(), stdout=subprocess.PIPE)
p.wait()

comando_creacion    = "psql -U postgres -d rutas -f ./4_esquema/cargar_rutaxminizona.sql"
p   = subprocess.Popen(comando_creacion.split(), stdout=subprocess.PIPE)
p.wait()
