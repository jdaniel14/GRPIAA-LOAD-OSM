#!/bin/bash
/etc/init.d/postgresql stop
/etc/init.d/postgresql start
python 1.py
./2_pgrouting/osm2pg.sh
./2_pgrouting/osm2pg.sh
python 2.py
python 3_scripts/python/p11_rutas.py
python 3.py
