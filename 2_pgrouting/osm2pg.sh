#!/bin/bash
osm2pgrouting -file ./2_pgrouting/lima-callao.osm -conf ./2_pgrouting/mapconfig.xml -dbname pgrouting-workshop -user postgres -clean
