
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


