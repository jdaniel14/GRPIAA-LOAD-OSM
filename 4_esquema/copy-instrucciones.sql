INSERT INTO solucion (idalgoritmo, iddatos, idparametros, estado, valor) VALUES(0, 0, 0, 0, 0);
COPY tipo_via FROM '/home/jose/Dropbox/UPLOAD/3_scripts/output/o1_tipovia.csv'WITH DELIMITER '|' CSV HEADER; 
COPY via FROM '/home/jose/Dropbox/UPLOAD/3_scripts/output/o2_via.csv'WITH DELIMITER '|' CSV HEADER; 
COPY nodo(idnodo,longitud,latitud) FROM '/home/jose/Dropbox/UPLOAD/3_scripts/output/o3_nodo.csv'WITH DELIMITER '|' CSV HEADER; 
COPY arista(idarista,idnodoorigen,idnododestino,idvia,distancia,numcarriles,accesible,direccion,geom) FROM '/home/jose/Dropbox/UPLOAD/3_scripts/output/o4_arista.csv'WITH DELIMITER '|' CSV HEADER;
COPY distrito(iddistrito, nombre, ubigeo, zona_integrada, area_polo, geom) FROM '/home/jose/Dropbox/UPLOAD/3_scripts/output/o4_distritos.csv'WITH DELIMITER '|' CSV HEADER;
COPY redvial(ID,NAME,TIPO,geom,idzona) FROM '/home/jose/Dropbox/UPLOAD/3_scripts/output/o5_redvial.csv' WITH DELIMITER '|' CSV HEADER;
COPY zonatransito(idzonatransito,iddistrito,area,codigo,flgtraspaso,flgperiferico,geom) FROM '/home/jose/Dropbox/UPLOAD/3_scripts/output/o6_zonatransito.csv'WITH DELIMITER '|' CSV HEADER;
COPY minizona(codigo,area,idzonatransito,iddistrito,geom) FROM '/home/jose/Dropbox/UPLOAD/3_scripts/output/o7_minizona.csv'WITH DELIMITER '|' CSV HEADER;
COPY demanda(idminizonaorigen,idminizonadestino,demanda) FROM '/home/jose/Dropbox/UPLOAD/3_scripts/output/o8_matrizdemanda.csv'WITH DELIMITER '|' CSV HEADER;
COPY zonacensal(id, dpto, prov, dist, nombre, length, area, geom) FROM '/home/jose/Dropbox/UPLOAD/3_scripts/output/o9_zonascensales.csv'WITH DELIMITER '|' CSV HEADER;


--redvial dentro de distrito
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

--arista dentro de distrito
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

DO $$DECLARE r record;
BEGIN
  FOR r IN SELECT idminizona, geom FROM minizona LOOP
    BEGIN
      UPDATE nodo SET idminizona = r.idminizona
      WHERE ST_Contains(r.geom , ST_SetSRID(ST_MakePoint(nodo.longitud, nodo.latitud),4326) );
    EXCEPTION
      WHEN OTHERS THEN
        RAISE WARNING 'Loading of record % failed: %', r.ogc_fid, SQLERRM;
    END;
  END LOOP;
END$$;

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
