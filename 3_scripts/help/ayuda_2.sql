--insertsMinizonaxNodo
	SELECT nodo.idnodo as ID, minizona.idminizona 
	FROM minizona, nodo 
	WHERE ST_Contains(minizona.geom , ST_SetSRID(ST_MakePoint(nodo.longitud, nodo.latitud),4326) )
	
	INSERT INTO MINIZONAXNODO(IDNODO, IDMINIZONA) VALUES
	
	--1° inserto todos los nodos en MINIZONAXNODO y luego actualizo
	DO $$DECLARE r record;
	BEGIN
	  FOR r IN SELECT idminizona, geom FROM minizona LOOP
		BEGIN
		  UPDATE nodo SET idzonatransito = r.idminizona
		  WHERE ST_Contains(r.geom , ST_SetSRID(ST_MakePoint(nodo.longitud, nodo.latitud),4326) );
		EXCEPTION
		  WHEN OTHERS THEN
		    RAISE WARNING 'Loading of record % failed: %', r.ogc_fid, SQLERRM;
		END;
	  END LOOP;
	END$$;
	
--creaInsertsDistrito AGREGAR AL Q YA TENGO
	In_distritos.txt
	INSERT INTO DISTRITO(IDDISTRITO, NOMBRE, UBIGEO, ZONA_INTEGRADA, AREA_POLO)
	
--creaInsertaZonasTransito
	In_ZonasTransito.txt
	INSERT INTO ZONATRANSITO(IDZONATRANSITO,IDDISTRITO,AREA,CODIGO,GEOM)
	
--actualiza_zonatransito
	In_UpdateZonasTransito.txt
	UPDATE ZONATRANSITO 
	SET FLGTRASPASO = a[19], FLGPERIFERICO = a[20]
	WHERE IDZONATRANSITO = a[1] --ACA ESTA EL PROBLEMA, HAY CODIGO DE MAS DE 427, ACASO HAN CONSIDERADO ESOS VALORES?

--creaInsertsMinizonasConTodasZonasDeTransito
	In_ZonasTransito.txt
	
	INSERT INTO MINIZONA (CODIGO, AREA, IDZONATRANSITO,IDDISTRITO , GEOM) VALUES
--ponerCentroideEnMinizona ACTUALIZAR , FACIL
	select idminizona, ST_X(ST_CENTROID(a.geom)), ST_Y(ST_CENTROID(a.geom)) from minizona as a
	
	UPDATE minizona
	SET longitud = ST_X(ST_CENTROID(geom)), latitud = ST_Y(ST_CENTROID(geom));


--creaInsertsDemanda

	MatrizDemandaPersonas.txt
	SELECT  *
	FROM    minizona
	WHERE   minizona.idzonatransito = idO

	SELECT  *
	FROM    minizona
	WHERE   minizona.idzonatransito = idD

	INSERT INTO DEMANDA(IDMINIZONAORIGEN, IDMINIZONADESTINO, DEMANDA) VALUES
		
--creaInsertsGrafoZona 

--http://stackoverflow.com/questions/25969/sql-insert-into-values-select-from

SELECT a.idminizona, b.idminizona , ST_DISTANCE(ST_Transform(ST_CENTROID(a.geom), 26986), ST_Transform(ST_CENTROID(b.geom),26986)) FROM minizona as a JOIN minizona as b ON ST_TOUCHES(a.geom,b.geom);
	

INSERT INTO ARISTA_MINIZONA ( IDMINIZONAORIGEN, IDMINIZONADESTINO, DISTANCIA )
SELECT a.idminizona, b.idminizona , ST_DISTANCE(ST_Transform(ST_CENTROID(a.geom), 26986), ST_Transform(ST_CENTROID(b.geom),26986))/1000.0 
FROM minizona as a JOIN minizona as b ON ST_TOUCHES(a.geom,b.geom);

SELECT ST_Distance(ST_Transform(ST_GeomFromText('POINT(-77.1611916  -11.7733985)',4326),26986),ST_Transform(ST_GeomFromText('POINT(-77.160878  -11.772455)', 4326),26986))/1000.0;

SELECT ST_Distance(ST_Transform(ST_GeomFromText('POINT(-77.1611916  -11.7733985)',4326),26986),ST_Transform(ST_GeomFromText('POINT(-77.160878  -11.772455)', 4326),26986))/1000.0;

SELECT ST_Distance(ST_Transform(ST_SetSRID(ST_MakePoint(-77.1611916,-11.7733985),4326),26986),ST_Transform(ST_SetSRID(ST_MakePoint(-77.160878,-11.772455),4326),26986))/1000.0;

SELECT ST_Distance(ST_Transform(ST_SetSRID(ST_MakePoint(x1,y1),4326),26986),ST_Transform(ST_SetSRID(ST_MakePoint(x2,y2),4326),26986))/1000.0;
SELECT source, x1, y1, target, x2, y2, name, ST_Distance(ST_Transform(ST_SetSRID(ST_MakePoint(x1,y1),4326),26986),ST_Transform(ST_SetSRID(ST_MakePoint(x2,y2),4326),26986))/1000.0, ST_AsTEXT(the_geom) FROM ways limit 10;

--ST_SetSRID(ST_MakePoint(-77.1611916,-11.7733985),4326)
--ST_SetSRID(ST_MakePoint(-77.160878,-11.772455),4326)

select a.distancia, ST_Length(a.geom), n1.longitud, n1.latitud, n2.longitud, n2.latitud,  st_astext(a.geom) 
from nodo n1, nodo n2, arista a
where a.idarista = 49909 and a.idnodoorigen = n1.idnodo and a.idnododestino = n2.idnodo;

--http://stackoverflow.com/questions/16717019/adding-list-to-array-of-list-in-localstorage
