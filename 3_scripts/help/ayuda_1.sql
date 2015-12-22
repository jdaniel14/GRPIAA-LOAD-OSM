COPY tipo_via FROM '/home/administrador/Dropbox/CARGA_DATA/FILES/tipo_via.csv'WITH DELIMITER '|' CSV HEADER;
COPY via FROM '/home/administrador/Dropbox/CARGA_DATA/FILES/via.csv'WITH DELIMITER '|' CSV HEADER;
COPY nodo FROM '/home/administrador/Dropbox/CARGA_DATA/FILES/nodo.csv'WITH DELIMITER '|' CSV HEADER;
COPY arista FROM '/home/administrador/Dropbox/CARGA_DATA/FILES/arista.csv'WITH DELIMITER '|' CSV HEADER;
--COPY distrito FROM '/home/administrador/Dropbox/CARGA_DATA/FILES/In_distritos.csv'WITH DELIMITER '|' CSV HEADER;
COPY distrito FROM '/home/administrador/Dropbox/CARGA_DATA/FILES/distritos-wkt.csv'WITH DELIMITER '|' CSV HEADER;
COPY redvial FROM '/home/administrador/Dropbox/CARGA_DATA/FILES/red_out.csv'WITH DELIMITER '|' CSV HEADER;


truncate table tipo_via cascade;
truncate table via cascade;
truncate table nodo cascade;
truncate table arista cascade;


-- BEGIN CREATES

CREATE TABLE redvial (
    ID 		integer,
    NAME 	text,
    TIPO 	integer,
    geom 	geometry(LineString,4326),
    idzona 	integer null
);



ALTER TABLE arista ADD COLUMN iddistrito integer;
ALTER TABLE arista ADD COLUMN redvial integer;

SELECT AddGeometryColumn('distrito', 'geom', 4326, 'GEOMETRY', 2, false);

DO $$DECLARE r record;
BEGIN
  FOR r IN SELECT iddistrito, nombre, geom FROM distrito LOOP
    BEGIN
      UPDATE redvial SET idzona = r.iddistrito
      WHERE ST_Intersects(r.geom, geom);
    EXCEPTION
      WHEN OTHERS THEN
        RAISE WARNING 'Loading of record % failed: %', r.ogc_fid, SQLERRM;
    END;
  END LOOP;
END$$;

DO $$DECLARE r record;
BEGIN
  FOR r IN SELECT iddistrito, nombre, geom FROM distrito LOOP
    BEGIN
      UPDATE arista SET iddistrito = r.iddistrito
      WHERE ST_Intersects(r.geom, geom);
    EXCEPTION
      WHEN OTHERS THEN
        RAISE WARNING 'Loading of record % failed: %', r.ogc_fid, SQLERRM;
    END;
  END LOOP;
END$$;

-- END CREATES

ogr2ogr -f "ESRI Shapefile" REDVIAL.SHP PG:"user=postgres dbname=rutas" -sql "SELECT geom FROM redvial"

ogr2ogr -f "ESRI Shapefile" LIMA-DISTRITOS.SHP PG:"user=postgres dbname=rutas" -sql "SELECT geom FROM distrito"

ogr2ogr -f "ESRI Shapefile" ARISTAS-FALTANTES.SHP PG:"user=postgres dbname=rutas" -sql "SELECT geom FROM redvial WHERE idzona=0"
ogr2ogr -f "ESRI Shapefile" LAPUNTA.SHP PG:"user=postgres dbname=rutas" -sql "SELECT geom FROM redvial WHERE idzona=55"


ogr2ogr -f "ESRI Shapefile" REDVIAL.SHP PG:"user=postgres dbname=rutas" -sql "SELECT geom FROM arista where distancia > 1000"

SELECT D.iddistrito, D.nombre, COUNT(A.*)
FROM arista A, distrito D
WHERE D.iddistrito = A.iddistrito
GROUP BY D.nombre, D.iddistrito
ORDER BY 3 DESC;


SELECT A.idarista, N1.latitud, N1.longitud, N2.latitud, N2.longitud
FROM arista A, nodo N1, nodo N2
WHERE 
	A.iddistrito = 1 AND
	A.idnodoorigen = N1.idnodo AND
	A.idnododestino = N2.idnodo;
	
SELECT A.idarista, N1.latitud, N1.longitud, N2.latitud, N2.longitud FROM arista A, nodo N1, nodo N2 WHERE A.iddistrito = 1 AND A.idnodoorigen = N1.idnodo AND A.idnododestino = N2.idnodo;


SELECT d.id as id, d.nombre as nombre, ST_AsText(d.the_geom) as wkt 
FROM distrito d, ruta r 
WHERE r.id = 1 AND ST_Intersects(d.the_geom, r.the_geom);

select id, name as nombre, ST_AsText(geom) as wkt from redvial WHERE idzona = 1 limit 1;

--https://www.datadoghq.com/2013/08/100x-faster-postgres-performance-by-changing-1-line/

UPDATE arista
SET redvial = 0;

UPDATE arista
SET redvial = 1
WHERE idarista = ANY (VALUES (1),(2),(3),(4),(5),(6));


--http://stackoverflow.com/questions/5404839/how-can-i-refresh-a-page-with-jquery


COPY tipo_via FROM '/home/administrador/Dropbox/CARGA_DATA/FILES/SUBIDA/FINAL/output/o1_tipovia.csv'WITH DELIMITER '|' CSV HEADER;
COPY via FROM '/home/administrador/Dropbox/CARGA_DATA/FILES/SUBIDA/FINAL/output/o2_via.csv'WITH DELIMITER '|' CSV HEADER;
COPY nodo(idnodo,longitud,latitud) FROM '/home/administrador/Dropbox/CARGA_DATA/FILES/SUBIDA/FINAL/output/o3_nodo.csv'WITH DELIMITER '|' CSV HEADER;
COPY arista(idarista,idnodoorigen,idnododestino,idvia,distancia,numcarriles,accesible,direccion,geom) FROM '/home/administrador/Dropbox/CARGA_DATA/FILES/SUBIDA/FINAL/output/o4_arista.csv'WITH DELIMITER '|' CSV HEADER;
COPY distrito FROM '/home/administrador/Dropbox/CARGA_DATA/FILES/SUBIDA/FINAL/output/o4_distritos.csv'WITH DELIMITER '|' CSV HEADER;
COPY redvial(ID,NAME,TIPO,geom,idzona) FROM '/home/administrador/Dropbox/CARGA_DATA/FILES/SUBIDA/FINAL/output/o5_redvial.csv'WITH DELIMITER '|' CSV HEADER;
COPY zonatransito(idzonatransito,iddistrito,area,codigo,flgtraspaso,flgperiferico,geom) FROM '/home/administrador/Dropbox/CARGA_DATA/FILES/SUBIDA/FINAL/output/o6_zonatransito.csv'WITH DELIMITER '|' CSV HEADER;
COPY minizona(codigo,area,idzonatransito,iddistrito,geom) FROM '/home/administrador/Dropbox/CARGA_DATA/FILES/SUBIDA/FINAL/output/o7_minizona.csv'WITH DELIMITER '|' CSV HEADER;
COPY demanda(idminizonaorigen,idminizonadestino,demanda) FROM '/home/administrador/Dropbox/CARGA_DATA/FILES/SUBIDA/FINAL/output/o8_matrizdemanda.csv'WITH DELIMITER '|' CSV HEADER;
COPY zonacensal(id, dpto, prov, dist, nombre, length, area, geom) FROM '/home/administrador/Dropbox/CARGA_DATA/FILES/SUBIDA/FINAL/output/o9_zonascensales.csv'WITH DELIMITER '|' CSV HEADER;


CREATE TABLE zonacensal (
    id 		integer,
    dpto	integer,
    prov	integer,
    dist 	integer,
    nombre	text,
    length	float,
    area	float,
    geom 	geometry(Geometry,4326)
);

CREATE TABLE censalxtransito (
	idzoncensal		integer,
	idzonatransito 	integer
);

CREATE TABLE censalxtransitoxgeom (
	id 		serial primary key,
	idzonacensal		integer,
	idzonatransito 	integer,
	geom 	geometry(Geometry,4326)
);

....................................................................
DO $$DECLARE r record;
BEGIN
  FOR r IN SELECT idzonatransito, geom FROM zonatransito LOOP
    BEGIN
    	INSERT into censalxtransitoxgeom (idzonacensal, idzonatransito, geom) (select id, r.idzonatransito, ST_Intersection(r.geom, geom) from zonacensal where ST_Intersects(r.geom, geom));  
    EXCEPTION
      WHEN OTHERS THEN
        RAISE WARNING 'Loading of record % failed: %', r.idzonatransito, SQLERRM;
    END;
  END LOOP;
END$$;

ogr2ogr -f "ESRI Shapefile" INCLUIDOS2.SHP PG:"user=postgres dbname=rutas" -sql "SELECT geom from censalxtransitoxgeom where idzonatransito = 2"

ogr2ogr -f "ESRI Shapefile" TRANSITO2.SHP PG:"user=postgres dbname=rutas" -sql "SELECT geom from zonatransito where idzonatransito = 2"
....................................................................

DO $$DECLARE r record;
BEGIN
  FOR r IN SELECT idzonatransito, geom FROM zonatransito LOOP
    BEGIN
    	INSERT into censalxtransito (idzoncensal, idzonatransito) (select id, r.idzonatransito from zonacensal where ST_Intersects(r.geom, geom));  
    EXCEPTION
      WHEN OTHERS THEN
        RAISE WARNING 'Loading of record % failed: %', r.idzonatransito, SQLERRM;
    END;
  END LOOP;
END$$;


--EL SHP DE LA ZONATRANSITO X
ogr2ogr -f "ESRI Shapefile" ZT3.SHP PG:"user=postgres dbname=rutas" -sql "SELECT geom from zonatransito where idzonatransito = 3"


--LAS ZONAS CENSALES Q ESTAN EN LA ZON DE TRANSITO X
ogr2ogr -f "ESRI Shapefile" ZC_ZT3.SHP PG:"user=postgres dbname=rutas" -sql "SELECT ZC.geom from censalxtransito C, zonacensal ZC where C.idzonatransito = 3 and C.idzoncensal = ZC.id"


DO $$DECLARE r record;
BEGIN
  FOR r IN SELECT idzonatransito, geom FROM zonatransito LOOP
    BEGIN
    	INSERT into censalxtransito (idzoncensal, idzonatransito) (select id, r.idzonatransito from zonacensal where ST_Intersects(r.geom, geom));  
    EXCEPTION
      WHEN OTHERS THEN
        RAISE WARNING 'Loading of record % failed: %', r.idzonatransito, SQLERRM;
    END;
  END LOOP;
END$$;


SELECT AM.idaristaminizona as idarista, M1.latitud as x1, M1.longitud as y1, M2.latitud as x2, M2.longitud as y2
FROM arista_minizona AM, minizona M1, minizona M2	
WHERE AM.idminizonaorigen = M1.idminizona AND AM.idminizonadestino = M2.idminizona;






SELECT AM.idaristaminizona as idarista, M1.latitud as x1, M1.longitud as y1, M2.latitud as x2, M2.longitud as y2 FROM arista_minizona AM, minizona M1, minizona M2 WHERE AM.idminizonaorigen = M1.idminizona AND AM.idminizonadestino = M2.idminizona;



