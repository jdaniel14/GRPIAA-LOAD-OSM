#!/bin/bash
rm -rf /tmp/*.csv
psql -U postgres -d rutas -f help.sql
chown administrador /tmp/*.csv
> input.txt
cat /tmp/cont_nodo.csv >> input.txt
cat /tmp/nodo.csv >> input.txt
cat /tmp/cont_arista.csv >> input.txt
cat /tmp/arista.csv >> input.txt
