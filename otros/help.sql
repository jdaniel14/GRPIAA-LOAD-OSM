g++ -c -I/usr/include/postgresql/libpq main.cpp
g++ -o exec main.o -L/usr/include/postgresql/libpq -lpq


ALTER TABLE arista ADD COLUMN grafo bigint
time psql -U postgres -d rutas -f out.txt 

CREATE TABLE GRAFOXDISTRITO (
	iddistrito	integer,
	idgrafo 	integer
);

SELECT A.grafo
FROM distrito D, arista A
WHERE D.iddistrito = 1 AND ST_Intersects(D.geom, A.geom)
GROUP BY A.grafo;

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





COPY (SELECT idnodo FROM nodo) TO '/tmp/nodo.csv';
COPY (SELECT idarista, idnodoorigen, idnododestino FROM arista) TO '/tmp/arista.csv';
