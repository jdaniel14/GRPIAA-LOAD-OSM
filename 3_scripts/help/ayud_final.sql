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

UPDATE minizona
SET longitud = ST_X(ST_CENTROID(geom)), latitud = ST_Y(ST_CENTROID(geom));

INSERT INTO ARISTA_MINIZONA ( IDMINIZONAORIGEN, IDMINIZONADESTINO, DISTANCIA )
SELECT a.idminizona, b.idminizona , ST_DISTANCE(ST_Transform(ST_CENTROID(a.geom), 26986), ST_Transform(ST_CENTROID(b.geom),26986))/1000.0 
FROM minizona as a JOIN minizona as b ON ST_TOUCHES(a.geom,b.geom);

