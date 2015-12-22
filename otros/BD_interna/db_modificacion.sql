--QUERY PARA VER QUE GEOM DE LA RED VIAL ESTAN DENTRO DE UN DISTRITO
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

--QUERY PARA VER QUE GEOM DE LAS ARISTAS ESTAN DENTRO DE UN DISTRITO
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

INSERT INTO GRAFOXDISTRITO ( IDDISTRITO, IDGRAFO)
SELECT r.iddistrito, A.grafo
FROM distrito D, arista A
WHERE D.iddistrito = r.iddistrito AND ST_Intersects(D.geom, A.geom)
GROUP BY A.grafo;


DO $$DECLARE r record;
BEGIN
  FOR r IN SELECT iddistrito, nombre, geom FROM distrito LOOP
    BEGIN
		SELECT r.iddistrito, A.grafo
		FROM distrito D, arista A
		WHERE D.iddistrito = r.iddistrito AND ST_Intersects(D.geom, A.geom)
		GROUP BY A.grafo
    EXCEPTION
      WHEN OTHERS THEN
        RAISE WARNING 'Loading of record % failed: %', r.ogc_fid, SQLERRM;
    END;
  END LOOP;
END$$;

DO $$DECLARE r record;
BEGIN
FOR r IN SELECT iddistrito FROM distrito LOOP
BEGIN
INSERT INTO GRAFOXDISTRITO ( IDDISTRITO, IDGRAFO)
SELECT r.iddistrito, A.grafo
FROM distrito D, arista A
WHERE D.iddistrito = r.iddistrito AND ST_Intersects(D.geom, A.geom)
GROUP BY A.grafo;
EXCEPTION
WHEN OTHERS THEN
RAISE WARNING 'Loading of record % failed: %', r.iddistrito, SQLERRM;
END;
END LOOP;
END$$;


SELECT A.idarista as idarista, N1.latitud as x1, N1.longitud as y1, N2.latitud as x2, N2.longitud as y2 
FROM GRAFOXDISTRITO GD, arista A, nodo N1, nodo N2 
WHERE GD.iddistrito = 1 AND A.grafo = GD.idgrafo AND A.grafo > 0 AND A.idnodoorigen = N1.idnodo AND A.idnododestino = N2.idnodo;

"SELECT A.idarista as idarista, N1.latitud as x1, N1.longitud as y1, N2.latitud as x2, N2.longitud as y2 FROM GRAFOXDISTRITO GD, arista A, nodo N1, nodo N2 WHERE GD.iddistrito = ".$json["id"]." AND A.grafo = GD.idgrafo AND A.grafo > 0 AND A.idnodoorigen = N1.idnodo AND A.idnododestino = N2.idnodo;"

