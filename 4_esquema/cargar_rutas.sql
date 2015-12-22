COPY ruta(idruta, idsolucion, frecuencia, osm_id, osm_nombre, flota) FROM '/home/jose/Dropbox/UPLOAD/3_scripts/output/o11_rutas.csv' WITH DELIMITER '|' CSV HEADER;
COPY rutaxarista(idruta, idarista, paradero, orden) FROM '/home/jose/Dropbox/UPLOAD/3_scripts/output/o11_rutaxarista.csv' WITH DELIMITER '|' CSV HEADER;
